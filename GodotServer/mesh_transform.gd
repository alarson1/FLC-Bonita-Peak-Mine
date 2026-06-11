#@tool
#extends MeshInstance3D
### Attach directly to the terrain MeshInstance3D.
### Aligns the terrain to the mine model
### Toggle Apply to (re)run after edits.
#
#@export var apply: bool = false:
	#set(v):
		#if v:
			#_apply()
#

#const XFORM := Transform3D(
	#Basis(
		#Vector3( 0.013383, 0.0,-0.000386), # X axis (scale + rotation)
		#Vector3( 0.0,0.010538,0.0),# Y axis (vertical scale)
		#Vector3( 0.000386, 0.0,0.013383)# Z axis (scale + rotation)
	#),
	#Vector3(-30.976, -34.153, -18.347) # origin
#)
#
#func _ready() -> void:
	#transform = XFORM
#
#func _apply() -> void:
	#apply = false
	#transform = XFORM
	#print("Terrain aligned to model. AABB world size = ", get_aabb().size * scale)
	
### ------Terrain Model Data----------
### CRS: UTM 13N / EPSG: 26913; origin offset (267100, 4196800).
### Model - real scale: ~74.7 m/unit horizontal, ~94.9 vertical, rotation −1.65°.
### Terrain transform: origin (-30.976, -34.153, -18.347).
### Terrain source: USGS 3DEP, 2000×1273 over the bbox, heights 3193–4103 m, vertex_spacing 2.37.
