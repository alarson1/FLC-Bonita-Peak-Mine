#extends Node3D
#
#func _ready() -> void:
	## controller signals
	#$"../PositionUpdated".position_updated.connect(_select_object)
	##$"../PositionSet".position_set.connect(_on_position_set)
#
	## desktop fallback
	#var bridge = get_node_or_null("../MouseInputBridge")
	#if bridge:
		#bridge.position_updated.connect(_select_object)
		##bridge.position_set.connect(_on_position_set)
#
#@export var ray_length: float = 50.0
#@export var collision_mask: int = 1
#
#var _last_hit: Dictionary = {}  # sender_id -> Dictionary
#
#func _select_object(pos: Vector3, dir: Vector3, sender_id: int):
	#var c = raycast_widget(sender_id, pos, dir)
	#var selected_object : Dictionary[Node,StringName]
	#
	#if c is Node:
		#if !c.get_groups().is_empty():
			#selected_object[c] = c.get_groups()[0]
			#return selected_object
		#elif c.get_groups().is_empty():
			#var p: Node = c
			#while p != null:
				#if !p.get_groups().is_empty():
					#selected_object[p] = p.get_groups()[0]
					#return selected_object
				#p = p.get_parent()
#
#func raycast_widget(sender_id: int, pos: Vector3, dir: Vector3):
	#return _raycast_widget(sender_id, pos, dir)
#
#func get_last_hit(sender_id: int) -> Dictionary:
	#return _last_hit.get(sender_id, {})
#
#func _raycast_widget(sender_id: int, pos: Vector3, dir: Vector3):
	#var space = get_world_3d().direct_space_state
	#var ray = PhysicsRayQueryParameters3D.new()
	#ray.from = pos
	#ray.to = pos + dir.normalized() * ray_length
	#ray.collision_mask = collision_mask
	#ray.hit_from_inside = true
	#ray.hit_back_faces = true
#
	#var hit = space.intersect_ray(ray)
#
	#if not hit:
		#_last_hit.erase(sender_id)
		#return null
#
	#_last_hit[sender_id] = {
		#"point": hit.position,
		#"normal": hit.normal,
		#"distance": pos.distance_to(hit.position),
		#"collider": hit.collider
	#}
#
	##var c = hit.collider
	##if c.is_in_group("markers"):
		##return c
	##if c is Node:
		##var p: Node = c
		##while p != null:
			##if p.is_in_group("markers"):
				##return p
			##p = p.get_parent()
			#
	#var c = hit.collider
	#return c
		#
#
	#return null
