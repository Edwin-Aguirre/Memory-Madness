extends TextureButton


class_name MemoryTile


@onready var item_image: TextureRect = $ItemImage


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reveal(false)


func reveal(r: bool) -> void:
	item_image.visible = r


func setup(image: Texture2D) -> void:
	item_image.texture = image


func _on_pressed() -> void:
	pass # Replace with function body.
