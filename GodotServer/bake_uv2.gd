@tool
extends MeshInstance3D

var aerial_tex := load("res://source_data/color.png")
const UV_SCALE := Vector2(1.0 / 4740.0, 1.0 / 3017.0)
const BAKED_PATH := "res://source_data/terrain_baked3.res"

# bakes fixed UV into new array mesh to correct carry-over world scale UV from Terrain3D import
# attach to MeshInstance3D node, hit button, and save scene
# for some reason doesn't load material correctly, re-apply both material and texture

@export var bake_now := false:
	set(v):
		bake_now = false
		if v:
			_bake()

func _bake() -> void:
	var baked := ArrayMesh.new()
	for s in self.mesh.get_surface_count():
		var arrays := self.mesh.surface_get_arrays(s)
		if s == 0:
			var uvs: PackedVector2Array = arrays[Mesh.ARRAY_TEX_UV]
			for i in uvs.size():
				uvs[i] = uvs[i] * UV_SCALE
			arrays[Mesh.ARRAY_TEX_UV] = uvs
		baked.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)

	var m := StandardMaterial3D.new() 
	m.albedo_texture = aerial_tex 
	m.albedo_color = Color.WHITE         
	baked.surface_set_material(0, m) 
	for s in range(1, mesh.get_surface_count()): 
		baked.surface_set_material(s, mesh.surface_get_material(s)) 

	if ResourceSaver.save(baked, BAKED_PATH) != OK: 
		push_error("Save failed."); return 
	baked.take_over_path(BAKED_PATH)      # node references new .res  
	self.mesh = baked 
	print("Baked -> ", BAKED_PATH)
