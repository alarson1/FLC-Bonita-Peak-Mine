extends Node

#--------External References----------
#@onready var _hmd_ui = $"../NoodlesRoot/UIRoot/UIGrabbable/hmdUI"
@onready var _hmd_ui = $"../../NoodlesRoot/UIRoot/UIgrabbable/hmdUI"
@onready var _mine_model_3D = $"../../NoodlesRoot/ObstacleRoot/MineModel3D"
var _UI_BINDINGS = UIDefinitions.get_bindings()

# --------Variable Declarations--------
var _UI_ACTIONS: Dictionary
# _on_scale_changed config
const scale_min := 0.1
const scale_max := 3.0
# _on_rotation_changed config
const rotation_min := 0.0
const rotation_max := 360.0


# ---------- _ready() -----------------
# Called when the node enters the scene tree for the first time.
func _ready():
	# 1. Connect the core signal from the UI
	_hmd_ui.parameter_changed.connect(self._on_ui_parameter_updated)
	
	# 2. Map the parameter strings to specific functions
	_UI_ACTIONS = {
		"Scale": self._on_scale_changed,
		"Rotation": self._on_rotation_changed,
		"X-Translation": self._on_translate_x_changed,
		"Y-Translation": self._on_translate_y_changed,
		"Z-Translation": self._on_translate_z_changed,
	}


# -------------Router-----------------
# catches the signal and dynamically calls the correct method from your dictionary.
func _on_ui_parameter_updated(param: String, value: Variant) -> void:
	"""Catches every parameter_changed signal and dispatches to the associated method."""
	var action = _UI_ACTIONS.get(param, null)
	if action == null:
		printerr("Parameter %s does not exist in _UI_ACTIONS." % param)
		return
	
	# Call the mapped function, handling both 1-argument and 2-argument functions
	if action.get_argument_count() == 1:
		action.call(value)
	else:
		action.call(param, value)

# ----------Action Methods--------------

# scale and rotation
func _on_scale_changed(value: float) -> void:
	# remap 0-1 slider scale to 0.1-3 x
	var scale_val : float = lerp(scale_min, scale_max, value)
	_mine_model_3D.scale = Vector3.ONE * scale_val

func _on_rotation_changed(value: float) -> void:
	# remap 0-1 slider scale to degrees (0-360)
	var degrees : float = lerp(rotation_min, rotation_max, value)
	_mine_model_3D.rotation_degrees.y = degrees

# translation functions
# value is the stepper's absolute position (sets X directly)
func _on_translate_x_changed(value: float) -> void:
	var pos : Vector3 = _mine_model_3D.position
	pos.x = value
	_mine_model_3D.position = pos

func _on_translate_y_changed(value: float) -> void:
	var pos: Vector3 = _mine_model_3D.position
	pos.y = value
	_mine_model_3D.position = pos

func _on_translate_z_changed(value: float) -> void:
	var pos: Vector3 = _mine_model_3D.position
	pos.z = value
	_mine_model_3D.position = pos
