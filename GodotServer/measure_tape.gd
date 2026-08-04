@tool
extends Node3D

# calculates distance and generates display

#external references
@onready var _p1 = get_node_or_null("Point1")
@onready var _p2 = get_node_or_null("Point2")
@onready var _display = get_node_or_null("Display")
@onready var _terrain = get_node_or_null("../../Terrain/TerrainMesh")
@onready var _trace = get_node_or_null("Trace")

# config
var pos_1 : Vector3
var pos_2 : Vector3
var lpos_1 : Vector3
var lpos_2 : Vector3
var diff : Vector3
var distance : float
var dist_h : float
var dist_v : float
var dist : float
var line_color : Color = Color.YELLOW
var line_width := 0.001

# inspector activation
@export var measure_now: bool = false:
	set(m):
		measure_now = false
		if m:
			_measure()
func _ready() -> void:
	call_deferred("_measure")
	#_measure()

# main function
func _measure() -> void:
	pos_1 = _p1.global_position
	pos_2 = _p2.global_position
	
	lpos_1 = _p1.position
	lpos_2 = _p2.position
	
	distance = pos_1.distance_to(pos_2) * (1/_terrain.global_transform.basis.get_scale().x)
	print(distance)
	
	diff = pos_1 - pos_2
	print(diff)
	
	dist_h = (sqrt((diff.x **2) + (diff.z **2))) * (1/_terrain.global_transform.basis.get_scale().x)
	dist_v = diff.y * (1/_terrain.global_transform.basis.get_scale().y)
	dist = sqrt((dist_h**2) + (dist_v**2))
	
	_refresh_display()
	_refresh_trace()
	
func _refresh_display() -> void:
	_display.global_position = pos_1 - (diff/2)
	#_display.mesh.text = "distance: " + str(snapped(distance, 0.01)) + "m"
	_display.mesh.text = str(snapped(distance, 0.01)) + "m"
	
	var direction : Vector3 = diff.rotated(Vector3.UP, PI / 2.0)
	var target_look_dir: Vector3 = _display.global_position + direction
	_display.look_at(target_look_dir, Vector3.UP)
	_display.rotation.z = _display.rotation.x
	_display.rotation.x = 0
	_display.position.y += 0.1

func _refresh_trace() -> void:
	#var mesh = _trace.mesh as ImmediateMesh
	#mesh.clear_surfaces()
	#
	#var material = StandardMaterial3D.new()
	#material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	#material.albedo_color = line_color
	#
	#mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	#
	#mesh.surface_add_vertex(lpos_1)
	#mesh.surface_add_vertex(lpos_2)
	#
	#mesh.surface_end()
	
	# ImmediateMesh doesnt come across to client side withought surfaces,
	# need to generate 3D mesh 
	#-------------------------------------------------------
	
	var dir := (lpos_2 - lpos_1).normalized()
	var a := dir.cross(Vector3.UP).normalized() * line_width
	if a.length() < 0.0001:
		a = dir.cross(Vector3.RIGHT).normalized() * line_width
	var b := dir.cross(a).normalized() * line_width

	var material = StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = line_color

	var st := SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	st.set_material(material)

	st.add_vertex(lpos_1 - a - b)
	st.add_vertex(lpos_1 + a - b)
	st.add_vertex(lpos_1 + a + b)
	st.add_vertex(lpos_1 - a + b)
	st.add_vertex(lpos_2 - a - b)
	st.add_vertex(lpos_2 + a - b)
	st.add_vertex(lpos_2 + a + b)
	st.add_vertex(lpos_2 - a + b)

	for i in [0,1,2, 0,2,3,  4,6,5, 4,7,6,  0,4,5, 0,5,1,
			  1,5,6, 1,6,2,  2,6,7, 2,7,3,  3,7,4, 3,4,0]:
		st.add_index(i)

	st.generate_normals()
	_trace.mesh = st.commit()
