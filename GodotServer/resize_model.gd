@tool
extends Node3D

## temp script to view and change scale of mine model
# todo: calc needs to be simplified and values pulled straight from mesh and minemodel

@export var inspect_now: bool = false:
	set(v):
		inspect_now = false
		if v:
			_inspect()

func _inspect() -> void:
	var local_scale = scale 
	print(scale)

	var target_size = 9.47999999997 # get from mesh calc (target scale (2m/km)) / (current size of m/km scale) * current_size 
	var current_size = 9.1141943 # get from mesh (size of actual terrain excluding padding)
	var target_scale = target_size/current_size
	var current_scale = Vector3(0.144839, 0.144839, 0.144839)
	#var new_scale = local_scale * target_scale 
	var new_scale = current_scale * target_scale
	
	scale = new_scale
	print(new_scale)
