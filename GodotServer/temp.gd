@tool
extends Node3D

## use to read various properties about a mesh

@export var rotate_now: bool = false:
	set(v):
		rotate_now = false
		if v:
			_turn()

func _turn():
	rotation_degrees.y -= 1.65
