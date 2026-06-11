extends Node

# Enables manipulation of the model and UI using mouse for testing outside of lab.
# Disable this node when running in the lab so VRPN can take over.

@onready var _ui_root = $"../UIRoot"

signal position_updated(pos: Vector3, dir: Vector3, sender_id: int)
signal position_set(sender_id: int)

const SENDER_ID := 1
var _camera: Camera3D

var mouse_pos
var ray_origin
var ray_dir
var _mouse_held := false

func _ready() -> void:
	_camera = get_viewport().get_camera_3d()
	if _camera == null:
		printerr("MouseInputBridge: no active camera found")

func _process(_delta: float) -> void:
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return

	_get_mouse_pos()
	_get_ray_origin()
	_get_ray_dir()

	_ui_root.on_position_updated(ray_origin, ray_dir, SENDER_ID)
	position_updated.emit(ray_origin, ray_dir, SENDER_ID)

func _input(event: InputEvent) -> void:
	if not (event is InputEventMouseButton):
		return
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	_mouse_held = event.pressed
	if not event.pressed:
		_ui_root.on_position_set(SENDER_ID)
		position_set.emit(SENDER_ID)

func _get_mouse_pos():
	mouse_pos = get_viewport().get_mouse_position()
	return mouse_pos

func _get_ray_origin():
	ray_origin = _camera.project_ray_origin(mouse_pos)
	return ray_origin
	
func _get_ray_dir():
	ray_dir = _camera.project_ray_normal(mouse_pos)
