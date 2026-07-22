@tool
extends EditorPlugin

var line: MeshInstance3D
var label: Label3D
var timer: Timer

# Selection tracking variables
var node_a: Node3D = null
var node_b: Node3D = null

# ---------------- INIT ----------------
func _enter_tree():
	var sel = get_editor_interface().get_selection()
	sel.selection_changed.connect(_on_select)

	# 1. Timer setup
	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 2.0
	timer.timeout.connect(_hide)
	add_child(timer)

func _exit_tree():
	var sel = get_editor_interface().get_selection()
	if sel.selection_changed.is_connected(_on_select):
		sel.selection_changed.disconnect(_on_select)

	_hide()
	if timer:
		timer.queue_free()

# ---------------- SELECTION ----------------
func _on_select():
	var nodes = get_editor_interface().get_selection().get_selected_nodes()

	# Agar 2 nodes selected nahi hain to clear karo
	if nodes.size() != 2 or not (nodes[0] is Node3D and nodes[1] is Node3D):
		node_a = null
		node_b = null
		_hide()
		return

	# Nodes ko save kar lo (abhi draw nahi karega)
	node_a = nodes[0]
	node_b = nodes[1]

# ---------------- INPUT OVERRIDE ----------------
# Yeh Godot Editor ki main window ka input catch karta hai, jo hamesha kaam karega
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP or event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			# Agar wheel rotate hua AUR 2 nodes selected hain, tabhi chalay
			if is_instance_valid(node_a) and is_instance_valid(node_b):
				_update_measurement()

# ---------------- UPDATE MEASUREMENT ----------------
func _update_measurement():
	if not is_instance_valid(node_a) or not is_instance_valid(node_b):
		return

	var dist = node_a.global_position.distance_to(node_b.global_position)
	var mid = (node_a.global_position + node_b.global_position) / 2

	_draw_line(node_a.global_position, node_b.global_position)
	_show_label(mid, dist)
	_restart()

# ---------------- DRAW LINE ----------------
func _draw_line(pos_a: Vector3, pos_b: Vector3):
	if is_instance_valid(line):
		line.queue_free()

	line = MeshInstance3D.new()
	get_tree().root.add_child(line) # Editor ke root mein add taaki selection hatne par bhi dikhe

	var mesh = ImmediateMesh.new()
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	mesh.surface_add_vertex(pos_a)
	mesh.surface_add_vertex(pos_b)
	mesh.surface_end()

	line.mesh = mesh

	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(0.0, 1.0, 0.2)
	mat.emission_enabled = true
	mat.emission = Color(0.0, 1.0, 0.2)
	mat.emission_energy = 3.0
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED

	line.material_override = mat

# ---------------- LABEL ----------------
func _show_label(pos: Vector3, dist: float):
	if is_instance_valid(label):
		label.queue_free()

	label = Label3D.new()
	get_tree().root.add_child(label) # Editor ke root mein add

	label.global_position = pos
	label.text = "%.3f m" % dist
	label.font_size = 64
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	label.modulate = Color(0.0, 1.0, 0.2)
	label.no_depth_test = true

# ---------------- TIMER CONTROL ----------------
func _restart():
	timer.stop()
	timer.start()

func _hide():
	if is_instance_valid(line):
		line.queue_free()
		line = null

	if is_instance_valid(label):
		label.queue_free()
		label = null
