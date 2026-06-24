extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var global_coords: Vector3 = self.global_position
	print("Terrain coords: %s" % global_coords)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
