extends TileMap

var selected_crop = "pumpkin"
const pumpkin_scene = "res://Scenes/Pumpkin.tscn"
const potato_scene = "res://Scenes/Potato.tscn"
const tomato_scene = "res://Scenes/Tomato.tscn"
onready var player = $"../Player"



# UJ --------------------------
var MAX_PLANT_DISTANCE = 20
var occupied_tiles = []


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			var mouse_position = get_local_mouse_position()
			var cell = world_to_map(mouse_position) #current cell
			var tile_id = get_cellv(cell)
			print("Tile ID: ", tile_id)
			
			
			# UJ --------------------------
			if is_player_near(cell):
				if event.button_index == BUTTON_LEFT:
					if tile_id == 10: 
						set_cellv(cell, 32)
					elif tile_id == 32:
						place_crop(cell)
						occupied_tiles.append(cell)
				elif event.button_index == BUTTON_RIGHT:
					reset_tile(cell)

func place_crop(cell):
	var crop_scene

	if selected_crop == "pumpkin" and Global.MONEY >= 1:
		Global.MONEY -= 1
		crop_scene = load(pumpkin_scene)
	elif selected_crop == "potato" and Global.MONEY >= 5:
		Global.MONEY -= 5
		crop_scene = load(potato_scene)
	elif selected_crop == "tomato" and Global.MONEY >= 10:
		Global.MONEY -= 10
		crop_scene = load(tomato_scene)

	if crop_scene != null:
		set_cellv(cell, 72)
		var crop_instance = crop_scene.instance()
		add_child(crop_instance)
		crop_instance.position = map_to_world(cell)
		crop_scene = null


# UJ --------------------------
func reset_tile(cell):
	if cell in occupied_tiles:
		print("Cannot reset occupied tile")
	else:
		set_cellv(cell, 10)

func is_player_near(cell):
	var player_position = player.position
	var cell_world_position = map_to_world(cell)
	var distance_to_cell = player_position.distance_to(cell_world_position)
	return distance_to_cell <= MAX_PLANT_DISTANCE

func _on_PUMPKIN_pressed():
	selected_crop = "pumpkin"

func _on_POTATO_pressed():
	selected_crop = "potato"

func _on_TOMATO_pressed():
	selected_crop = "tomato"
