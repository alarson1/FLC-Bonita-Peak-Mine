extends RefCounted

class_name UIDefinitions

const LAYOUT := {
	"panels": [
		{
			"name": "ControlsPanel",
			"title": "Controls",
			"pos": Vector3(-.3, 1, 0),
			"cols": 2,
			"rows": 0,
			"spacing": Vector2(0.02, 0.02),
			"padding": Vector2(0.03, 0.03),
			"bg_inset": Vector2(0.0, 0.0),
			"bg_scale": Vector2(1.0, 1.0),
			"cell_padding": Vector2(0.0, 0.0),
			"items": [
				{"type": "stepper", "name": "UIScaleSlider", "label": "Scale", "min": 0, "max": 1, "value": .2, "step": 0.05},
				{"type": "stepper", "name": "UIRotationSlider", "label": "Rotation", "min": 0, "max": 1, "value": 0.0, "step": .05},
				{"type": "stepper", "name": "UI_XStepper", "label": "X-Translation", "min": -10, "max": 10, "value": 0.0, "step": 0.5},
				{"type": "stepper", "name": "UI_YStepper", "label": "Y-Translation", "min": -10, "max": 10.0, "value": 0.0, "step": 0.5},
				{"type": "stepper", "name": "UI_ZStepper", "label": "Z-Translation", "min": -10, "max": 10.0, "value": 0.0, "step": 0.5},
			]
		},
	]
}

const BINDINGS := {
	"steppers": [
		{"panel": "ControlsPanel", "stepper": "UI_XStepper", "param": "X-Translation"},
		{"panel": "ControlsPanel", "stepper": "UI_YStepper", "param": "Y-Translation"},
		{"panel": "ControlsPanel", "stepper": "UI_ZStepper", "param": "Z-Translation"},
		{"panel": "ControlsPanel", "stepper": "UIScaleSlider", "param": "Scale"},
		{"panel": "ControlsPanel", "stepper": "UIRotationSlider", "param": "Rotation"},
	],
}

static func get_layout() -> Dictionary:
	return LAYOUT.duplicate(true)

static func get_bindings() -> Dictionary:
	return BINDINGS.duplicate(true)
