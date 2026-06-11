@tool
extends MeshInstance3D
## Attach directly to the baked terrain MeshInstance3D.
## Aligns the terrain to the mine model (which stays untouched at its current
## transform). Scale and rotation are baked into the transform below — no
## separate scale step. Toggle Apply to (re)run after edits.

@export var apply: bool = false:
	set(v):
		if v:
			_apply()

# terrain-data coords -> model frame.
# Includes the full georef fit: H-scale 1/74.69, V-scale 1/94.90, rot -1.65deg.
const XFORM := Transform3D(
	Basis(
		Vector3( 0.013383, 0.0,      -0.000386),  # X axis (scale + rotation)
		Vector3( 0.0,      0.010538,  0.0),       # Y axis (vertical scale)
		Vector3( 0.000386, 0.0,       0.013383)   # Z axis (scale + rotation)
	),
	Vector3(-30.976, -34.153, -18.347)            # origin
)

func _ready() -> void:
	transform = XFORM

func _apply() -> void:
	apply = false
	transform = XFORM
	print("Terrain aligned to model. AABB world size = ", get_aabb().size * scale)
