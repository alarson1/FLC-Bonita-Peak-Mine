extends RefCounted

class_name UIDefinitions

# define panel items and properties
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
				# scale
				{"type": "stepper", "name": "UIScaleSlider", "label": "Scale", "min": 0, "max": 1, "value": .2, "step": 0.05},
				# rotation
				{"type": "stepper", "name": "UIRotationSlider", "label": "Rotation", "min": 0, "max": 1, "value": 0.5, "step": .05},
				# x translation
				{"type": "stepper", "name": "UI_XStepper", "label": "X-Translation", "min": -10, "max": 10, "value": 0.0, "step": 0.5},
				# y translation
				{"type": "stepper", "name": "UI_YStepper", "label": "Y-Translation", "min": -10, "max": 10.0, "value": 0.0, "step": 0.5},
				# z translation
				{"type": "stepper", "name": "UI_ZStepper", "label": "Z-Translation", "min": -10, "max": 10.0, "value": 0.0, "step": 0.5},
				# mine select menu
				{"type": "dropdown", "name": "UILayerDropdown", "label": "Layers", "items": ["All", "Red_and_Bonita_Mine", "Gold_King", "Gold_Prince", "Sunnyside_Mine", "Mogul_Mine_and_Brenneman_Shaft", "Pride_Of_Bonita_Region", "Updated_Bulkheads", "Lake_Emma_Hole"]},
			]
		},
	]
}

# attach previously defined items to internal parameters
const BINDINGS := {
	"steppers": [
		# x translation
		{"panel": "ControlsPanel", "stepper": "UI_XStepper", "param": "X-Translation"},
		# y translation
		{"panel": "ControlsPanel", "stepper": "UI_YStepper", "param": "Y-Translation"},
		# z translation
		{"panel": "ControlsPanel", "stepper": "UI_ZStepper", "param": "Z-Translation"},
		# scaling
		{"panel": "ControlsPanel", "stepper": "UIScaleSlider", "param": "Scale"},
		# rotation
		{"panel": "ControlsPanel", "stepper": "UIRotationSlider", "param": "Rotation"},
	],
	"dropdowns": [
		{
			"panel": "MainPanel",
			"dropdown": "UILayerDropdown",
			"param": "loc",
			"options": {
				"All": -1,
				"Red_and_Bonita_Mine": 0,
				"Gold_King": 1,
				"Gold_Prince": 2,
				"Sunnyside_Mine": 3,
				"Mogul_Mine_and_Brenneman_Shaft": 4,
				"Pride_Of_Bonita_Region": 5,
				"Updated_Bulkheads": 6,
				"Lake_Emma_Hole": 7,
			}
		},
	],
}

static func get_layout() -> Dictionary:
	return LAYOUT.duplicate(true)

static func get_bindings() -> Dictionary:
	return BINDINGS.duplicate(true)
