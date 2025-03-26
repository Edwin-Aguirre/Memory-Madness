extends Node


class_name Scorer


@onready var sound: AudioStreamPlayer = $Sound
@onready var reveal_timer: Timer = $RevealTimer


static var selected_enabled: bool = true


var selections: Array[MemoryTile]
var _target_pairs: int = 0
var moves_made: int = 0
var pairs_made: int = 0


func _enter_tree() -> void:
	SignalHub.on_tile_selected.connect(on_tile_selected)
	SignalHub.on_game_exit_pressed.connect(on_game_exit_pressed)
	


func get_moves_made_str() -> String:
	return str(moves_made)


func get_pairs_made_str() -> String:
	return "%d/%d" % [pairs_made, _target_pairs]


func clear_new_game(target_pairs: int) -> void:
	selections.clear()
	_target_pairs = target_pairs
	moves_made = 0
	pairs_made = 0
	selected_enabled = true


func check_for_pair() -> void:
	moves_made += 1
	if selections[0].matches_other_tile(selections[1]) == true:
		selections[0].kill_on_success()
		selections[1].kill_on_success()
		pairs_made += 1
		SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)


func process_pair() -> void:
	if selections.size() != 2:
		return
	
	selected_enabled = false
	reveal_timer.start()
	check_for_pair()


func check_game_over() -> void:
	if pairs_made == _target_pairs:
		selected_enabled = false
		SignalHub.emit_on_game_over(moves_made)
	else:
		selected_enabled = true


func on_tile_selected(tile: MemoryTile) -> void:
	if tile in selections:
		return
	
	selections.append(tile)
	SoundManager.play_tile_click(sound)
	process_pair()


func on_game_exit_pressed() -> void:
	reveal_timer.stop()


func _on_reveal_timer_timeout() -> void:
	for s in selections:
		s.reveal(false)
	selections.clear()
	check_game_over()
