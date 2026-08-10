extends RefCounted

class_name UIDefinitions

# define panel items and properties
const LAYOUT := {
	"panels": [
		{
			"name": "ControlsPanel",
			"title": "Controls",
			"pos": Vector3(-2.2, 1.5, 0),
			"cols": 2,
			"rows": 0,
			"spacing": Vector2(0.02, 0.02),
			"padding": Vector2(0.03, 0.03), 
			"bg_inset": Vector2(0.0, 0.0),
			"bg_scale": Vector2(1.0, 1.0),
			"cell_padding": Vector2(0.0, 0.0), 
			"items": [
				# scale
				{"type": "stepper", "name": "UIScaleSlider", "label": "Scale", "min": 0.1, "max": 2, "value": 1, "step": 0.05},
				# rotation
				{"type": "stepper", "name": "UIRotationSlider", "label": "Rotation", "min": 0, "max": 1, "value": 0.5, "step": .05},
				# x translation
				{"type": "stepper", "name": "UI_XStepper", "label": "X-Translation", "min": -10, "max": 10, "value": 0.0, "step": 0.5},
				# y translation
				{"type": "stepper", "name": "UI_YStepper", "label": "Y-Translation", "min": -10, "max": 10.0, "value": 0.0, "step": 0.5},
				# z translation
				{"type": "stepper", "name": "UI_ZStepper", "label": "Z-Translation", "min": -10, "max": 10.0, "value": 0.0, "step": 0.5},
				# terrain toggle
				{"type": "button", "name": "UITerrainToggle", "label": "Toggle Terrain"},
			]
		},
		{
			"name": "LayerSelectionPanel",
			"title": "Layer_Selection",
			"pos": Vector3(0.5, 1.5, 0),
			"cols": 1,
			"rows": 0,
			"spacing": Vector2(0.02, 0.02),
			"padding": Vector2(0.03, 0.03),
			"bg_inset": Vector2(0.0, 0.0),
			"bg_scale": Vector2(1.0, 1.0), # test 1.0
			"cell_padding": Vector2(0.0, 0.0),
			"items": [
				# mine select menu
				{"type": "dropdown", "name": "UIMineLayerDropdown", "label": "Mine Sections", "items": ["All", "Red_and_Bonita_Mine", "Gold_King", "Gold_Prince", "Sunnyside_Mine", "Mogul_Mine_and_Brenneman_Shaft", "Pride_Of_Bonita_Region", "Updated_Bulkheads"]},
			]
		},
		{
			"name": "Gold_King",
			"title": "Gold_King_Layers",
			"pos": Vector3(2.0, 1.5, 0),
			"cols": 3,
			"rows": 0,
			"spacing": Vector2(0.02, 0.02),
			"padding": Vector2(0.03, 0.03),
			"bg_inset": Vector2(0.0, 0.0),
			"bg_scale": Vector2(1.0, 1.0),
			"cell_padding": Vector2(0.0, 0.0),
			"items": [
				{"type": "dropdown", "name": "UISubLayerDropdown", "label": "Sub-Sections", "items": ["All", "Gold_King_Shafts", "GK_Paul_Level", "GK_Sampson_Level", "Gold_King_No1_Level", "GK_Sampson_Level_No2", "GK_No2_Level", "GK_No3_Level", "GK_Midway_Level", "GK_No4_Level", "GK_No5", "GK_No6_Level", "GK_No7_Level"]},
			]
		},
		{
			"name": "Gold_Prince",
			"title": "Gold_Prince_Layers",
			"pos": Vector3(2.0, 1.5, 0),
			"cols": 2,
			"rows": 0,
			"spacing": Vector2(0.02, 0.02),
			"padding": Vector2(0.03, 0.03),
			"bg_inset": Vector2(0.0, 0.0),
			"bg_scale": Vector2(1.0, 1.0),
			"cell_padding": Vector2(0.0, 0.0),
			"items": [
				{"type": "dropdown", "name": "UISubLayerDropdown", "label": "Sub-Sections", "items": ["All", "Gold_Prince_Shafts", "GoldPrince_No2", "GoldPrince_No3"]},
			]
		},
		{
			"name": "Sunnyside_Mine",
			"title": "Sunnyside_Mine_Layers",
			"pos": Vector3(2.0, 1.5, 0),
			"cols": 3,
			"rows": 0,
			"spacing": Vector2(0.02, 0.02),
			"padding": Vector2(0.03, 0.03),
			"bg_inset": Vector2(0.0, 0.0),
			"bg_scale": Vector2(1.0, 1.0),
			"cell_padding": Vector2(0.0, 0.0),
			"items": [
				{"type": "dropdown", "name": "UISubLayerDropdown#1", "label": "Sub-Sections#1", "items": ["All", "Sunnyside_no7_sketch", "Sunnyside_No6_sketch", "Sunnyside_No5", "Sunnyside_No4", "Sunnyside_No3", "Sunnyside_UpperMidway", "Sunnyside_LowerMidway", "Sunnyside_No2", "Sunnyside_No1", "Sunnyside_A_Level", "SS_CLevel_2450", "B_Level_Fixed", "Sunnyside_CLevel", "D_Level_Updated"]},
				{"type": "dropdown", "name": "UISubLayerDropdown#2", "label": "Sub-Sections#2", "items": ["All", "E_Level_Updated", "F_Level_Updated_2", "Sunnyside_G_Level_Updated", "Sunnyside_HLevel", "Sunnyside_I_Level", "Sunnyside_ATLevel", "AmericanTunnel", "RSE_2890_Drift", "RSE_3710_Drift", "Terry_Shaft", "Washington_VerticalShaft", "AT_WashingtonShaft", "Gold_Prince_Shaft", "Sunnyside_Raises_OrePass"]},
			]
		},
		{
			"name": "Mogul_Mine_and_Brenneman_Shaft",
			"title": "Mogul_Mine_and_Brenneman_Shaft_Layers",
			"pos": Vector3(2.0, 1.5, 0),
			"cols": 3,
			"rows": 0,
			"spacing": Vector2(0.02, 0.02),
			"padding": Vector2(0.03, 0.03),
			"bg_inset": Vector2(0.0, 0.0),
			"bg_scale": Vector2(1.0, 1.0),
			"cell_padding": Vector2(0.0, 0.0),
			"items": [
				{"type": "dropdown", "name": "UISubLayerDropdown#1", "label": "Sub-Sections#1", "items": ["All", "Surface_Shafts", "Mogul_4_5_raises", "Level2Raise", "Brenneman_Shaft", "Brenneman_D_B_Raises", "Brenneman_B_No1_Raise", "Brenneman_900_Raise", "Midway_Raises", "BrennemanBLevel_Digitize", "BrennemanCLevel_Digitize"]},
				{"type": "dropdown", "name": "UISubLayerDropdown#2", "label": "Sub-Sections#2", "items": ["All", "BrennemanDLevel_Digitized", "Brenneman_D_Sublevel", "MogulLevel5Digitize", "MogulLevel4Digitize", "MogulLevel3", "Mogul_Level2_Updated", "Upper_Midway_Mogul", "Lower_Midway_Mogul", "Mogul_No1_Updated"]},
			]
		},
		{
			"name": "UIPositionLock",
			"title": "",
			"pos": Vector3(-2.62, 2, 0),
			"cols": 2,
			"rows": 0,
			"spacing": Vector2(0.02, 0.02),
			"padding": Vector2(0.03, 0.03), 
			"bg_inset": Vector2(0.0, 0.0),
			"bg_scale": Vector2(1.0, 1.0),
			"cell_padding": Vector2(0.0, 0.0), 
			"items": [
				{"type": "button", "name": "lock", "label": ""},
				{"type": "button", "name": "vrpn", "label": ""},
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
			"panel": "LayerSelectionPanel",
			"dropdown": "UIMineLayerDropdown",
			"param": "Mine_Sections",
			"options": {
				"All": -1,
				"Red_and_Bonita_Mine": 0,
				"Gold_King": 1,
				"Gold_Prince": 2,
				"Sunnyside_Mine": 3,
				"Mogul_Mine_and_Brenneman_Shaft": 4,
				"Pride_Of_Bonita_Region": 5,
				"Updated_Bulkheads": 6,
			}
		},
		{
			"panel": "Gold_King",
			"dropdown": "UISubLayerDropdown",
			"param": "Gold_King_Mine",
			"options": {
				"All" : -1,
				"Gold_King_Shafts": 0,
				"GK_Paul_Level": 1,
				"GK_Sampson_Level": 2,
				"Gold_King_No1_Level": 3,
				"GK_Sampson_Level_No2": 4,
				"GK_No2_Level": 5,
				"GK_No3_Level": 6,
				"GK_Midway_Level": 7,
				"GK_No4_Level": 8,
				"GK_No5": 9,
				"GK_No6_Level": 10,
				"GK_No7_Level": 11,
			}
		},
		{
			"panel": "Gold_Prince",
			"dropdown": "UISubLayerDropdown",
			"param": "Gold_Prince",
			"options": {
				"All": -1,
				"Gold_Prince_Shafts": 0,
				"GoldPrince_No2": 1,
				"GoldPrince_No3": 2,
			}
		},
		{
			"panel": "Sunnyside_Mine",
			"dropdown": "UISubLayerDropdown#1",
			"param": "Sunnyside_Mine#1",
			"options": {
				"All": -1,
				"Sunnyside_no7_sketch": 0,
				"Sunnyside_No6_sketch": 1,
				"Sunnyside_No5" : 2,
				"Sunnyside_No4": 3,
				"Sunnyside_No3":4,
				"Sunnyside_UpperMidway": 5,
				"Sunnyside_LowerMidway": 6,
				"Sunnyside_No2": 7,
				"Sunnyside_No1": 8,
				"Sunnyside_A_Level": 9,
				"SS_CLevel_2450": 10,
				"B_Level_Fixed": 11,
				"Sunnyside_CLevel": 12,
				"D_Level_Updated": 13,
			}
		},
		{
			"panel": "Sunnyside_Mine",
			"dropdown": "UISubLayerDropdown#2",
			"param": "Sunnyside_Mine#2",
			"options": {
				"All": -1,
				"E_Level_Updated": 14,
				"F_Level_Updated_2": 15,
				"Sunnyside_G_Level_Updated": 16,
				"Sunnyside_HLevel": 17,
				"Sunnyside_I_Level": 18,
				"Sunnyside_ATLevel": 19,
				"AmericanTunnel": 20,
				"RSE_2890_Drift": 21,
				"RSE_3710_Drift": 22,
				"Terry_Shaft": 23,
				"Washington_VerticalShaft": 24,
				"AT_WashingtonShaft": 25,
				"Gold_Prince_Shaft": 26,
				"Sunnyside_Raises_OrePass": 27,
			}
		},
		{
			"panel": "Mogul_Mine_and_Brenneman_Shaft",
			"dropdown": "UISubLayerDropdown#1",
			"param": "Mogul_Mine_and_Brenneman_Shaft#1",
			"options": {
				"All": -1,
				"Surface_Shafts": 0,
				"Mogul_4_5_raises": 1,
				"Level2Raise": 2,
				"Brenneman_Shaft": 3,
				"Brenneman_D_B_Raises": 4,
				"Brenneman_B_No1_Raise": 5,
				"Brenneman_900_Raise": 6,
				"Midway_Raises": 7,
				"BrennemanBLevel_Digitize": 8,
				"BrennemanCLevel_Digitize": 9,
			}
		},
		{
			"panel": "Mogul_Mine_and_Brenneman_Shaft",
			"dropdown": "UISubLayerDropdown#2",
			"param": "Mogul_Mine_and_Brenneman_Shaft#2",
			"options": {
				"All": -1,
				"BrennemanDLevel_Digitized": 10,
				"Brenneman_D_Sublevel": 11,
				"MogulLevel5Digitize": 12,
				"MogulLevel4Digitize": 13,
				"MogulLevel3": 14,
				"Mogul_Level2_Updated": 15,
				"Upper_Midway_Mogul": 16,
				"Lower_Midway_Mogul": 17,
				"Mogul_No1_Updated": 18,
			}
		},
	],
	"buttons": [
	{
		"panel": "ControlsPanel",
		"button": "UITerrainToggle",
		"param": "Terrain",
		"value": 0,
	},
	{
		"panel": "UIPositionLock",
		"button": "lock",
		"param": "lock",
		"value": 0,
	},
	{
		"panel": "UIPositionLock",
		"button": "vrpn",
		"param": "lock",
		"value": 1,
	},
],
}

static func get_layout() -> Dictionary:
	return LAYOUT.duplicate(true)

static func get_bindings() -> Dictionary:
	return BINDINGS.duplicate(true)
