# Data source for HMD UI layout and bindings.
extends RefCounted

class_name UIDefinitions

## Layout
const LAYOUT := {
	"panels": [
		{
			"name": "ControlsPanel",
			"title": "Controls",
			"pos": Vector3(0, 1.0, 0),
			"cols": 0,
			"rows": 1,
			"spacing": Vector2(0.1, 1),
			"padding": Vector2(0.12, 0.12),
			"bg_inset": Vector2(0.0, 0.0),
			"bg_scale": Vector2(1.0, 1.0),
			"cell_padding": Vector2(0.0, 0.0),
			"items": [
				# scale/size
				{"type": "slider", "name": "UIScaleSlider", "label": "Scale", }, 
				# rotation
				{"type": "slider", "name": "UIRotationSlider", "label": "Rotation",},
				# x translation 
				{"type": "stepper", "name": "UI_XStepper", "label": "X-Translation",},
				# y translation
				{"type": "stepper", "name": "UI_YStepper", "label": "Y-Translation",},
				# z translation
				{"type": "stepper", "name": "UI_ZStepper", "label": "Z-Translation",},
			]
		},
	]
}

## Bindings
const BINDINGS := {
	"sliders": [
		# scaling
		{"panel": "ControlsPanel", "slider": "UIScaleSlider", "param": "Scale"},
		# rotation
		{"panel": "ControlsPanel", "slider": "UIRotationSlider", "param": "Rotation"},
	],
	"steppers": [
		# x translation 
		{"type": "stepper", "name": "UI_XStepper", "label": "X-Translation", "min": -2.0, "max": 2.0, "value": 0.0, "step": 0.01, "hide_slider": true},
		# y translation
		{"type": "stepper", "name": "UI_YStepper", "label": "Y-Translation", "min": -2.0, "max": 2.0, "value": 0.0, "step": 0.01, "hide_slider": true},
		# z translation
		{"type": "stepper", "name": "UI_ZStepper", "label": "Z-Translation", "min": -2.0, "max": 2.0, "value": 0.0, "step": 0.01, "hide_slider": true},
	],
}

static func get_layout() -> Dictionary:
	# Return a deep copy so runtime edits do not touch constants.
	return LAYOUT.duplicate(true)

static func get_bindings() -> Dictionary:
	# Return a deep copy so runtime edits do not touch constants.
	return BINDINGS.duplicate(true)
