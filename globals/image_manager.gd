extends Node


const FRAME_IMAGES: Array[Texture2D] = [
	 preload("res://assets/ui/button_square_depth_line.png"),
	 preload("res://assets/ui/button_square_depth_border.png")
]


var _image_list: Array[Texture2D]


func _enter_tree() -> void:
	var ifl: ImageFilesListResource = load("res://resources/image_files_list.tres")
	for file in ifl.file_names:
		_image_list.append(load(file))



func get_random_item_image() -> Texture2D:
	return _image_list.pick_random()


func get_random_frame_image() -> Texture2D:
	return FRAME_IMAGES.pick_random()


func get_image(index: int) -> Texture2D:
	return _image_list[index]


func shuffle_images() -> void:
	_image_list.shuffle()
