extends Node

#--------External References----------
@onready var _hmd_ui = $"../../NoodlesRoot/UIRoot/UIgrabbable/hmdUI"
@onready var _mine_model_3D = $"../../NoodlesRoot/ObstacleRoot/MineModel3D"
@onready var _obstacle_root = $"../ObstacleRoot"
@onready var _terrain_mesh = $"../ObstacleRoot/MineModel3D/TerrainMesh"
@onready var _aerial_mesh = $"../ObstacleRoot/MineModel3D/AerialMesh"
var _UI_BINDINGS = UIDefinitions.get_bindings()

# --------Variable Declarations--------
var _UI_ACTIONS: Dictionary

# _on_scale_changed config
@onready var base_scale = _mine_model_3D.scale
@onready var scale_min : Vector3 = 0.0 * base_scale
@onready var scale_max : Vector3 = 2.0 * base_scale

# _on_rotation_changed config
@onready var current_rotation = _mine_model_3D.global_rotation_degrees.y
const rotation_min := -180.0
const rotation_max := 180.0

# _on_Layer_selected/sublayer_selected config
@onready var LayerTrees : Dictionary[String,Node3D] = {
	"Red_and_Bonita_Mine": $"../ObstacleRoot/MineModel3D/RedBonitaMine",
	"Gold_King": $"../ObstacleRoot/MineModel3D/Gold_King_Mine",
	"Gold_Prince": $"../ObstacleRoot/MineModel3D/Gold_Prince",
	"Sunnyside_Mine": $"../ObstacleRoot/MineModel3D/Sunnyside_Mine",
	"Mogul_Mine_and_Brenneman_Shaft": $"../ObstacleRoot/MineModel3D/Mogul_Mine_and_Brenneman_Shaft",
	"Pride_Of_Bonita_Region": $"../ObstacleRoot/MineModel3D/Pride_of_Bonita",
	"Updated_Bulkheads": $"../ObstacleRoot/MineModel3D/Bulkheads",
}
@onready var LayerNodes : Array[Node3D] = LayerTrees.values()
@onready var LayerNames : Array[String] = LayerTrees.keys()

# _on_terrain_toggled config
var toggle : bool = true
@onready var mode : Array[MeshInstance3D] = [_terrain_mesh, _aerial_mesh, null]
var current_mode : int = 0
@onready var terrain_material = _terrain_mesh.get_active_material(0)
@onready var aerial_material = _aerial_mesh.get_active_material(0)
var t_alpha = 0.412


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
		"Mine_Sections": self._on_layer_selected,
		"Gold_King_Mine": self._on_sublayer_selected,
		"Gold_Prince": self._on_sublayer_selected,
		"Sunnyside_Mine#1": self._on_sublayer_selected,
		"Sunnyside_Mine#2": self._on_sublayer_selected,
		"Mogul_Mine_and_Brenneman_Shaft#1": self._on_sublayer_selected,
		"Mogul_Mine_and_Brenneman_Shaft#2": self._on_sublayer_selected,
		"Terrain": self._on_terrain_toggled,
	}
	
	call_deferred("_init_subpanels") # initialize sub-layer panels to inactive after UIDefinitions is fully built


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
	# map 0.1 - 2 stepper settings to 0->2X initial model size
	var range = value / 2
	_mine_model_3D.scale  = lerp(scale_min, scale_max, range)

func _on_rotation_changed(value: float) -> void:
	# remap 0-1 stepper scale to degrees (-180->180)
	var degrees : float = lerp(rotation_min, rotation_max, value)
	_mine_model_3D.rotation_degrees.y = current_rotation + degrees

# translation functions
# value is the stepper's absolute position (sets X directly)
func _on_translate_x_changed(value: float) -> void:
	var pos : Vector3 = _obstacle_root.position
	pos.x = value
	_obstacle_root.position = pos

func _on_translate_y_changed(value: float) -> void:
	var pos: Vector3 = _obstacle_root.position
	pos.y = value
	_obstacle_root.position = pos

func _on_translate_z_changed(value: float) -> void:
	var pos: Vector3 = _obstacle_root.position
	pos.z = value
	_obstacle_root.position = pos

# Terrain Toggle
#func _on_terrain_toggled(vale : int): # gets passed value but doesn't need it, maybe remove later
	#toggle = !toggle
	#_terrain_mesh.visible = toggle
func _on_terrain_toggled(vale : int):
	current_mode = (current_mode + 1) % mode.size()
	for i in range(mode.size()):
		if mode[i]:
			mode[i].visible = (i == current_mode)
	if current_mode == 2:
		toggle = !toggle
		if toggle:
			terrain_material.albedo_color.a = 1
			aerial_material.albedo_color.a = 1
		else: 
			terrain_material.albedo_color.a = t_alpha
			aerial_material.albedo_color.a = t_alpha



# ---------Layer Select Functions----------

# overlayer selection
#toggles visibility of mine group and activates/deactivates associated sublayer panel
func _on_layer_selected(value: int) -> void:
	if (value == -1):
		var group = get_tree().get_nodes_in_group("MineLayer")
		for node in group: 
			_set_tree_visible(node, true)
		#get_tree().set_group("MineLayer", "visible", true)
		for key in LayerTrees:
			var sub_panel = get_node_or_null("../UIRoot/UIgrabbable/hmdUI/UIDefinition/" + key)
			if sub_panel:
				_set_tree_state(sub_panel, false)
	else:
		var target_node : Node3D = LayerNodes[value]
		var target_subpanel = get_node_or_null("../UIRoot/UIgrabbable/hmdUI/UIDefinition/" + LayerNames[value])
		target_node.visible = true
		if target_subpanel:
			_set_tree_state(target_subpanel, true)
		
		for key in LayerTrees:
			var sub_panel = get_node_or_null("../UIRoot/UIgrabbable/hmdUI/UIDefinition/" + key)
			if LayerTrees[key] != target_node:
				LayerTrees[key].visible = false
				
				if sub_panel:
					_set_tree_state(sub_panel, false)
		
		#for i in LayerNodes:
			#if i == target_node:
				#i.visible = true
			#else:
				#i.visible = false
#
func _on_sublayer_selected(param: String, value: int):
	var target_node = get_node_or_null("../ObstacleRoot/MineModel3D/" + param.get_slice("#",0))
	if target_node:
		var sublayers = target_node.get_children()
		if (value == -1):
			for i in sublayers:
				if ((i is Node3D) or (i is MeshInstance3D)):
					i.visible = true
		else:
			if (value < sublayers.size()) && (value > -1):
				var target_sublayer = sublayers[value]
				target_sublayer.visible = true
				for i in sublayers:
					if i != target_sublayer and ((i is Node3D) or (i is MeshInstance3D)):
						i.visible = false
		_toggle_dropdown(param)

#---------tree navigation functions------------

# subtree enable/dissable (pass in node and true for enabled, false for disabled)
func _set_tree_state(node: Node, switch: bool, is_root: bool = true):
	if  (node is Node3D) && is_root:
		#node.process_mode = Node.PROCESS_MODE_INHERIT
		node.visible = switch
	if node is UIWidget:
		node.set_enabled(switch)
	if node is CollisionShape3D:
		node.disabled = !switch
	if (node.get_child_count() > 0):
		for child in node.get_children():
			_set_tree_state(child, switch, false)

# set entire tree to visible. Don't use on panel nodes (contain purposefully hidden children nodes)
func _set_tree_visible(node: Node, switch: bool):
	if (node is Node3D) or (node is MeshInstance3D):
		node.visible = switch
	if (node.get_child_count() > 0):
		for child in node.get_children():
				_set_tree_visible(child, switch)
				
func _toggle_dropdown(param: String):
	var target_panel = get_node_or_null("../UIRoot/UIgrabbable/hmdUI/UIDefinition/" + param.get_slice("#",0))
	if target_panel:
		var current_dropdown = "UISubLayerDropdown#" + param.get_slice("#",1)
		_reset_panel(target_panel, current_dropdown)

func _reset_panel(node: Node, target_node: String):
	for child in node.get_children():
		if (child is UIDropdown) && (child.name != target_node):
			child.set_selected_index(0, -1, false)
			_reset_panel(child, target_node)

# ----init functions------
func _init_subpanels() -> void:
	_on_ui_parameter_updated("Mine_Sections", -1)
