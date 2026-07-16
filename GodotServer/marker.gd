extends UIWidget

# --------- direct connect to label (static) ----------
var _bg: Sprite3D

# config:
@export_multiline var display_text : String = "default text"
@export var bg_padding := Vector2(0.2, 0.2)
@onready var _display = get_node_or_null("Display")
@onready var display_position = _display.position

func _ready() -> void:
	
	_setup_display()
	call_deferred("_setup_background")
	
	# connect function
	var cb = func(sender_id: int):
		var v = not _display.visible
		_display.visible = v
		_bg.visible = v
	activated.connect(cb)

func _setup_display() -> void:
	_display.mesh = _display.mesh.duplicate()
	_display.mesh.text = display_text
	_display.mesh.text = display_text

func _setup_background() -> void:
	var tex = load("res://hmdUI/assets/ui_panel_dark.png")
	print("tex size: ", tex.get_size())
	
	var text_size = UIWidget.text_mesh_size(_display)
	print("text_size: ", text_size)

	_bg = Sprite3D.new()
	_bg.name = "InfoBackground"
	_bg.texture = load("res://hmdUI/assets/ui_panel_dark.png")
	_bg.pixel_size = 0.01
	_bg.centered = true

	UIWidget.set_sprite_world_size(_bg, text_size + Vector2(bg_padding.x * 2, bg_padding.y * 2))
	_bg.position = Vector3(display_position.x, display_position.y, display_position.z - 0.01)
	_bg.rotation = _display.rotation
	_bg.visible = false
	
	add_child(_bg)

## --------- direct connect to label (runtime generation) ----------
#
#var _display: MeshInstance3D
#var _bg: Sprite3D
#
## config:
#@export var display_text : String = "enter text here"
#@export var display_text_size : float = 200
#@export var billboard_enable : bool = false #for some reason the text wont display if disababled
#@export var display_position := Vector3(0,1,0)
#@export var bg_padding := Vector2(0.05, 0.03)
#
#func _ready() -> void:
	#
	## display 
	#_setup_display()
	#
	## background
	#call_deferred("_setup_background")
	#
	## connect to signal
	#var cb = func(sender_id: int):
		#var v = not _display.visible
		#_display.visible = v
		#_bg.visible = v
	#activated.connect(cb)
#
	## bug testing
	#print("material: ", _display.mesh.material)
	#print("mesh: ", _display.mesh)
	#print("text: ", _display.mesh.text)
#
## display -----------------
#func _setup_display() -> void:
	#_display = UIWidget.make_text_mesh_label("InfoDisplay", display_text, display_text_size)
	#_display.get_active_material(0).billboard_keep_scale = true
	#
	## enable billboard mode
	#if billboard_enable == true:
		#_display.mesh.material.billboard_mode = 1
	#
	#_display.position = display_position
	#
	#_display.visible = false
	#add_child(_display)
	#
## background ---------------
#func _setup_background() -> void:
	#var tex = load("res://hmdUI/assets/ui_panel_dark.png")
	#print("tex size: ", tex.get_size())
	#
	#var text_size = UIWidget.text_mesh_size(_display)
	#print("text_size: ", text_size)
#
	#_bg = Sprite3D.new()
	#_bg.name = "InfoBackground"
	#_bg.texture = load("res://hmdUI/assets/ui_panel_dark.png")
	#_bg.pixel_size = 0.01
	#_bg.centered = true
#
	#UIWidget.set_sprite_world_size(_bg, text_size + Vector2(bg_padding.x * 2, bg_padding.y * 2))
	#_bg.position = Vector3(display_position.x, display_position.y, display_position.z - 0.01)
	#_bg.visible = false
	#
	#if billboard_enable:
		#_bg.billboard = 1
	#
	#add_child(_bg)
	#
	##debug:
#
	#print("bg scale: ", _bg.scale)
	#print("bg position: ", _bg.position)
#
	#print("billboard_enable: ", billboard_enable)
#
	#print("scale: ", _display.scale)
## ----------------------------------------------------------------

## ------------- function connect to UserInteractions--------------
## untested

#@onready var _hmd_ui = $"PATH/TO/hmdUI"

#func _ready() -> void:
	#var cb = func(sender_id: int) -> void: _hmd_ui.parameter_changed.emit("marker", true)
	#activated.connect(cb)
## -----------------------------------------------------------------
