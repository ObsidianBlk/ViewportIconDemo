extends Node3D



# ------------------------------------------------------------------------------
# Onready Variables
# ------------------------------------------------------------------------------
@onready var _info_label : Label = %InfoLabel



# ------------------------------------------------------------------------------
# Handler Methods
# ------------------------------------------------------------------------------

func _on_mesh_view_button_pressed() -> void:
	_info_label.text = "This button uses a MeshInstance for the 3D model."

func _on_tile_button_pressed(tile : int) -> void:
	_info_label.text = "This button uses a MeshLibrary and GridMap. Current Tile: %s"%[tile]
