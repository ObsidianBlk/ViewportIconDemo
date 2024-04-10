@tool
extends Button


# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------
const ANGLE_PER_SECOND : float = deg_to_rad(90)

# ------------------------------------------------------------------------------
# Export Variables
# ------------------------------------------------------------------------------
@export_category("Mesh View Button")
@export var snapshot : bool = false:				set=set_snapshot


# ------------------------------------------------------------------------------
# Onready Variables
# ------------------------------------------------------------------------------
@onready var _orbit_cam : Node3D = %OrbitCam
@onready var _sub_viewport : SubViewport = %SubViewport

# ------------------------------------------------------------------------------
# Setters
# ------------------------------------------------------------------------------
func set_snapshot(s : bool) -> void:
	snapshot = s
	_UpdateViewportMode()

# ------------------------------------------------------------------------------
# Override Methods
# ------------------------------------------------------------------------------
func _ready() -> void:
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

# ------------------------------------------------------------------------------
# Public Methods
# ------------------------------------------------------------------------------
func snap() -> void:
	if snapshot and _sub_viewport != null:
		_sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
