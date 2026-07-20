@tool
extends MeshInstance3D

## use to read various properties about a mesh

@export var inspect_now: bool = false:
	set(v):
		inspect_now = false
		if v:
			_inspect()

func _inspect() -> void:
	#local transform properties
	var aabb: AABB = mesh.get_aabb()
	var mesh_scale: Vector3 = scale
	var mesh_size : Vector3 = aabb.size
	var true_size: Vector3 = aabb.size * mesh_scale
	print("local scale: ", mesh_scale, ", local size: ", mesh_size,  ", Width: ", true_size.x, ", Height: ", true_size.y, ", Depth: ", true_size.z)
	#print("mesh scale: ", mesh_scale, ", mesh size: ", mesh_size,  "'true' size: ", true_size)
	
	# global transform properties
	var global_box_size = mesh.get_aabb().size * global_transform.basis.get_scale()
	var current_global_scale = self.global_transform.basis.get_scale()
	var current_global_rotation = self.global_rotation_degrees.y
	var current_global_position = self.global_position
	var current_global_transform = global_transform
	print ("global boxsize: ", global_box_size)
	print("global scale: ", current_global_scale, ", global rotation: ", current_global_rotation, ", global postion", current_global_position)
	print("global transform: ", current_global_transform)
	
	# mesh properties
	var vertex_count = self.mesh.surface_get_array_len(0) #test
	print("vertex count: (TerrainMesh): ", vertex_count) #test
	
	# uv properties
	#if mesh == null:
		#push_error("No mesh on this node."); return
		#
		#print("=== UV inspect: ", mesh.resource_path if mesh.resource_path else "(embedded mesh)", " ===")
		#print("surfaces: ", mesh.get_surface_count())
#
	#for s in mesh.get_surface_count():
		#var arrays: Array = mesh.surface_get_arrays(s)
		#var raw_uv = arrays[Mesh.ARRAY_TEX_UV]
		#var raw_uv2 = arrays[Mesh.ARRAY_TEX_UV2]
#
		#print("--- surface ", s, " ---")
		#if raw_uv == null or (raw_uv is PackedVector2Array and raw_uv.is_empty()):
			#print("  UV1: (none)")
		#else:
			#var uvs: PackedVector2Array = raw_uv
			#var lo := uvs[0]; var hi := uvs[0]
			#for uv in uvs:
				#lo.x = minf(lo.x, uv.x); lo.y = minf(lo.y, uv.y)
				#hi.x = maxf(hi.x, uv.x); hi.y = maxf(hi.y, uv.y)
			#print("  UV1 count: ", uvs.size())
			#print("  UV1 lo:    ", lo)
			#print("  UV1 hi:    ", hi)
			#print("  UV1 span:  ", hi - lo)
			#print("  UV1 first 5: ", uvs.slice(0, mini(5, uvs.size())))
#
		#if raw_uv2 == null or (raw_uv2 is PackedVector2Array and raw_uv2.is_empty()):
			#print("  UV2: (none)")
		#else:
			#print("  UV2 present, count: ", (raw_uv2 as PackedVector2Array).size())
#
		## material UV transform, if any (this is what your uv1_scale lived in)
		#var m: Material = mesh.surface_get_material(s)
		#if m is BaseMaterial3D:
			#print("  surface mat uv1_scale:  ", (m as BaseMaterial3D).uv1_scale)
			#print("  surface mat uv1_offset: ", (m as BaseMaterial3D).uv1_offset)
			#print("  surface mat albedo_tex: ", (m as BaseMaterial3D).albedo_texture)
		#elif m == null:
			#print("  surface mat: (none)")
		#else:
			#print("  surface mat: ", m.get_class(), " (not a BaseMaterial3D)")
