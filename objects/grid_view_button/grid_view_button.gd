@tool
extends Button


# ------------------------------------------------------------------------------
# Signals
# ------------------------------------------------------------------------------
signal tile_pressed(tile : int)

# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------
const ANGLE_PER_SECOND : float = deg_to_rad(90)

# ------------------------------------------------------------------------------
# Export Variables
# ------------------------------------------------------------------------------
@export_category("Grid View Button")
@export var mesh_library : MeshLibrary = null:		set=set_mesh_library
@export var tile_id : int = 0:						set=set_tile_id
@export var snapshot : bool = false:				set=set_snapshot


# ------------------------------------------------------------------------------
# Onready Variables
# ------------------------------------------------------------------------------
@onready var _orbit_cam : Node3D = %OrbitCam
@onready var _sub_viewport : SubViewport = %SubViewport
@onready var _grid_map : GridMap = %GridMap

# ------------------------------------------------------------------------------
# Setters
# ------------------------------------------------------------------------------
func set_mesh_library(ml : MeshLibrary) -> void:
	if ml != mesh_library:
		mesh_library = ml
		if mesh_library == null:
			tile_id = 0
		elif mesh_library.get_item_list().size() <= tile_id:
			tile_id = mesh_library.get_item_list().size() - 1
		_UpdateMeshLibrary()

func set_tile_id(tid : int) -> void:
	if tid >= 0:
		tile_id = tid
		_UpdateGridTile()

func set_snapshot(s : bool) -> void:
	snapshot = s
	_UpdateViewportMode()

# ------------------------------------------------------------------------------
# Override Methods
# ------------------------------------------------------------------------------
func _ready() -> void:
	if not Engine.is_editor_hint():
		pressed.connect(_on_pressed)
	_UpdateMeshLibrary()
	_UpdateGridTile()
	_UpdateViewportMode()

func _process(delta : float) -> void:
	_orbit_cam.rotation.y = wrapf(
		_orbit_cam.rotation.y + ANGLE_PER_SECOND * delta,
		0.0,
		deg_to_rad(360.0)
	)

# ------------------------------------------------------------------------------
# Private Methods
# ------------------------------------------------------------------------------
func _UpdateViewportMode() -> void:
	if _sub_viewport == null: return
	if snapshot:
		_sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	else:
		_sub_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS

func _UpdateMeshLibrary() -> void:
	if _grid_map == null: return
	if _grid_map.mesh_library != mesh_library:
		_grid_map.mesh_library = mesh_library
		_UpdateGridTile()

func _UpdateGridTile() -> void:
	if _grid_map == null: return
	_grid_map.clear()
	if mesh_library != null and tile_id < mesh_library.get_item_list().size():
		_grid_map.set_cell_item(Vector3i.ZERO, tile_id)
	snap() # To update the snapshot (if we're in snapshot mode)
		

# ------------------------------------------------------------------------------
# Public Methods
# ------------------------------------------------------------------------------
func snap() -> void:
	if snapshot and _sub_viewport != null:
		_sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE

# ------------------------------------------------------------------------------
# Handler Methods
# ------------------------------------------------------------------------------
func _on_pressed() -> void:
	tile_pressed.emit(tile_id)
