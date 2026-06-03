# Data source for HMD UI layout and bindings.
extends RefCounted

class_name UIDefinitions

## Layout
const LAYOUT := {
	"panels": [
		{
			"name": "MainPanel",
			"title": "UI Demo",
			"pos": Vector3(0, 1.0, 0),
			"cols": 1,
			"rows": 1,
			"spacing": Vector2(0.1, -.5),
			"padding": Vector2(0.12, 0.12),
			"bg_inset": Vector2(0.0, 0.0),
			"bg_scale": Vector2(1.0, 1.0),
			"cell_padding": Vector2(0.0, 0.0),
			"items": [
				{"type": "button", "name": "MyButton", "label": "Press!", },
			]
		},
	]
}

## Bindings
const BINDINGS := {
	"buttons": [
		{"panel": "MainPanel", "button": "MyButton", "param": "button1"},
	],
}

static func get_layout() -> Dictionary:
	# Return a deep copy so runtime edits do not touch constants.
	return LAYOUT.duplicate(true)

static func get_bindings() -> Dictionary:
	# Return a deep copy so runtime edits do not touch constants.
	return BINDINGS.duplicate(true)
