@tool
extends Node3D


# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------
const MIN_ZOOM : float = 2.0
const MAX_ZOOM : float = 20.0

const MIN_PITCH : float = -deg_to_rad(90)
const MAX_PITCH : float = deg_to_rad(90)

# ------------------------------------------------------------------------------
# Export Variables
# ------------------------------------------------------------------------------
@export_category("Orbit cam")
@export var current : bool:											set=set_current, get=get_current
@export_range(MIN_PITCH, MAX_PITCH) var pitch : float = 0.0:		set=set_pitch
@export_range(MIN_ZOOM, MAX_ZOOM) var zoom : float = MIN_ZOOM:		set=set_zoom

# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
var _current : bool = false

# ------------------------------------------------------------------------------
# Onready Variables
# ------------------------------------------------------------------------------
@onready var _pitch : Node3D = $Pitch
@onready var _camera : Camera3D = $Pitch/Camera3D

# ------------------------------------------------------------------------------
# Setters
# ------------------------------------------------------------------------------
func set_pitch(p : float) -> void:
	if p >= MIN_PITCH and p <= MAX_PITCH:
		pitch = p
		_UpdatePitchNZoom()

func set_zoom(z : float) -> void:
	if z >= MIN_ZOOM and z <= MAX_ZOOM:
		zoom = z
		_UpdatePitchNZoom()

func set_current(c : bool) -> void:
	if _camera != null:
		_camera.current = c
	_current = c

func get_current() -> bool:
	if _camera != null:
		return _camera.current
	return _current

# ------------------------------------------------------------------------------
# Override methods
# ------------------------------------------------------------------------------
func _ready() -> void:
	_UpdatePitchNZoom()
	_camera.current = _current

# ------------------------------------------------------------------------------
# Private methods
# ------------------------------------------------------------------------------
func _UpdatePitchNZoom() -> void:
	if _pitch != null:
		_pitch.rotation.x = pitch
	if _camera != null:
		_camera.position = Vector3(0,0,zoom)


