extends Node3D


signal obstacle_position_set()

@onready var static_bodies = [
	 $"MineModel3D/StaticBody3D",
]

@onready var _bridge = get_node_or_null("../MouseInputBridge")

# current visible obstacle index
var obs_idx = -1  # -1 for no visible obstacle

# ID oif the client that currently owns the object
var possession_id = 0
var dist_from_pos = 0
var obs_offset = 0


func _ready() -> void:
	_find_all_static_bodies(get_tree().get_root())
	#for body in static_bodies:
		#print("StaticBody ID: ", body.get_instance_id(), " Layer: ", body.collision_layer)
	$"../PositionUpdated".position_updated.connect(_grab_obstacle)
	$"../PositionSet".position_set.connect(_release_obstacle)
	set_process(false)  # not using
	
	if _bridge:
		_bridge.position_updated.connect(_grab_obstacle)
		_bridge.position_set.connect(_release_obstacle)
	set_obstacle(0)
	
func set_obstacle(idx: int):
	if idx < static_bodies.size():
		obs_idx = idx
	else:
		obs_idx = -1
	
	
func _grab_obstacle(pos: Vector3, dir: Vector3, sender_id: int):
	# another ID is already grabbing the object
	if possession_id != 0:
		_move_obstacle(pos, dir)
		return
	
	# check if sender has collision with object
	if !check_collision(pos, dir):
		return

	### client has sucessfully grabbed an obstacle ###
	print_debug("%d has grabbed an obstacle." % sender_id)
	possession_id = sender_id  # lock object to sender
	
	
func _release_obstacle(sender_id: int):
	if sender_id == possession_id:
		possession_id = 0
		print_debug("%d has released an obstacle." % sender_id)
		obstacle_position_set.emit()  # to root

	
func _move_obstacle(pos: Vector3, dir: Vector3):
	if obs_idx == -1:   # no VIRTUAL obstacle selected
		return

	# update the objects global position
	self.global_position = pos + (dir * dist_from_pos) - obs_offset
	
	
func check_collision(from_pos: Vector3, direction: Vector3, distance: float=50) -> bool:
	"""Checks collision; if there is a collision, also updates dis_from_pos"""
	var space_state = get_world_3d().direct_space_state
	
	# define vector and queery
	var ray_start = from_pos
	var ray_end = from_pos + (direction * distance)
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	
	# fire ray
	var result = space_state.intersect_ray(query)
	#print("Ray result: ", result)
	if not result:
		return false   # no collision at all
	print("Hit: ", result.collider)
	if result.collider not in static_bodies:
		return false   # no collision with obstacle
		
	# get the distance from the cleints ray source and object center
	dist_from_pos = abs(from_pos.distance_to(result.position))
	obs_offset = result.position - result.collider.global_position
	return true
	
func _find_all_static_bodies(node: Node) -> void:
	if node is StaticBody3D:
		print("StaticBody: ", node.name, " ID: ", node.get_instance_id(), " Layer: ", node.collision_layer)
	for child in node.get_children():
		_find_all_static_bodies(child)
