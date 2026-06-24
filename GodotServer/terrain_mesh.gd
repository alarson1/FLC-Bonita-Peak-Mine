@tool
extends MeshInstance3D

var aerial_tex := load("res://source_data/color.png")

func _apply(v):
	var m: Material = get_active_material(0)
	if m:
		print("Material name: ", m.resource_name)
		print("Material path: ", m.resource_path)
	else:
		print("No material found on surface ", 0)
	if v:
		if m.albedo_texture == null:
			m.albedo_texture = aerial_tex
		m.uv1_scale = Vector3(1.0/4740.0, 1.0/3017.0, 1.0)
		self.mesh.surface_set_material(0, m)
		m.albedo_color = Color(1.0, 1.0, 1.0, 0.51)
	elif !v:
		if m.albedo_texture != null:
			m.albedo_texture = null
		m.albedo_color = Color(0.412, 0.412, 0.412, 0.459)
			

@export var show_aerial := false:
	set(v):
		show_aerial = v
		_apply(v)
			
#func _apply(v):
	#var m: Material = get_active_material(0)
	#if m:
		#print("Material name: ", m.resource_name)
		#print("Material path: ", m.resource_path)
	#else:
		#print("No material found on surface ", 0)
	#if v:
		##m.albedo_texture = aerial_tex
		#m.uv1_scale = Vector3(1.0/4740.0, 1.0/3017.0, 1.0)
		#self.mesh.surface_set_material(0, m)

func _ready() -> void:
	var global_coords: Vector3 = self.global_position
	print("Terrain coords: %s" % global_coords)
	#_apply()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
