@tool
extends Node3D

## use to read various properties about a Node3D

@export var inspect_now: bool = false:
	set(v):
		inspect_now = false
		if v:
			_inspect()

func _inspect() -> void:
	#local transform properties
	var node_scale: Vector3 = scale
	print("local scale: ", node_scale)
	
	# global transform properties
	var current_global_scale = self.global_transform.basis.get_scale()
	var current_global_rotation = self.global_rotation_degrees.y
	var current_global_position = self.global_position
	var current_global_transform = global_transform
	print("global scale: ", current_global_scale, ", global rotation: ", current_global_rotation, ", global postion", current_global_position)
	print("global transform: ", current_global_transform)
