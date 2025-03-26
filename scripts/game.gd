extends Control


@onready var tile_grid: GridContainer = $HB/TileGrid
const MEMORY_TILE = preload("res://scenes/memory_tile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _enter_tree() -> void:
	SignalHub.on_level_selected.connect(on_level_selected)


func add_memory_tile(image: Texture2D) -> void:
	var mt: MemoryTile = MEMORY_TILE.instantiate()
	tile_grid.add_child(mt)
	mt.setup(image)


func on_level_selected(level_num: int) -> void:
	var lds: LevelDataSelector = LevelDataSelector.get_level_selection(level_num)
	
	tile_grid.columns = lds.get_num_cols()
	
	for im in lds.get_selected_images():
		add_memory_tile(im)


func _on_exit_button_pressed() -> void:
	for t in tile_grid.get_children():
		t.queue_free()
	
	SignalHub.emit_on_game_exit_pressed()
