@tool
extends MeshInstance3D

#external references
var aerial_tex := load("res://source_data/color.png")

# applies fixed UV and texture to terrain mesh to fix hold-over world scale UV from Terrain3D import
# changes from this script will not show up on client side due to noodles not accessing UV1 channel, UV needs to be baked in using bake uv .gd
# includes toggle for texture, but toggling off during runtime makes noodles mad, use seperate mesh.

@export var show_aerial := false:
	set(v):
		show_aerial = v
		_apply(v)


func _apply(v):
	var m: Material = self.get_active_material(0)
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
		m.albedo_color = Color(1.0, 1.0, 1.0)
	elif !v:
		if m.albedo_texture != null:
			m.albedo_texture = null
		m.albedo_color = Color(0.412, 0.412, 0.412)
			

func _ready() -> void:
	var global_coords: Vector3 = self.global_position
	print("Terrain coords: %s" % global_coords)
