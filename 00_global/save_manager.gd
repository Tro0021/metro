<<<<<<< HEAD
=======

>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
extends Node

const SLOTS : Array[String] = [
	"save_01", "save_02", "save_03"
]

var current_slot : int = 0
var save_data : Dictionary
var discovered_areas : Array = []
var persistent_data : Dictionary = {}


func _ready() -> void:
	pass



func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_EQUAL:
			save_game()
		elif event.keycode == KEY_0:
			load_game()
	pass



func create_new_game_save() -> void:
	var new_game_scene : String = "res://levels/00_forest/01.tscn"
	discovered_areas.append(new_game_scene)
	save_data = {
<<<<<<< HEAD
		"version" : 1,
=======
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
		"scene_path" : new_game_scene,
		"x" : 60,
		"y" : 220,
		"hp" : 20,
		"max_hp" : 20,
		"dash" : false,
		"double_jump" : false,
		"ground_slam" : false,
		"morph_roll" : false,
		"discovered_areas" : discovered_areas,
		"persistent_data" : persistent_data,
	}
	
	var save_file = FileAccess.open(get_file_name(), FileAccess.WRITE)
<<<<<<< HEAD
	save_file.store_var(save_data)
=======
	save_file.store_line(JSON.stringify(save_data))
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
	pass



func save_game() -> void:
<<<<<<< HEAD
	var player : Player = PlayerManager.player
	save_data = {
		"version" : 1,
=======
	var player : Player = get_tree().get_first_node_in_group("Player")
	save_data = {
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
		"scene_path" : SceneManager.current_scene_uid,
		"x" : player.global_position.x,
		"y" : player.global_position.y,
		"hp" : player.hp,
		"max_hp" : player.max_hp,
<<<<<<< HEAD
		"abilities" : player.abilities,
=======
		"dash" : player.dash,
		"double_jump" : player.double_jump,
		"ground_slam" : player.ground_slam,
		"morph_roll" : player.morph_roll,
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
		"discovered_areas" : discovered_areas,
		"persistent_data" : persistent_data,
	}
	var save_file = FileAccess.open(get_file_name(), FileAccess.WRITE)
<<<<<<< HEAD
	save_file.store_var(save_data)
=======
	save_file.store_line(JSON.stringify(save_data))
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
	pass



func load_game() -> void:
	if not FileAccess.file_exists(get_file_name()):
		return
	
	var save_file = FileAccess.open(get_file_name(), FileAccess.READ)
<<<<<<< HEAD
	save_data = save_file.get_var()
	
	var version = save_data.get("version", 1)
=======
	save_data = JSON.parse_string(save_file.get_line())
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
	
	persistent_data = save_data.get("persistent_data", {})
	discovered_areas = save_data.get("discovered_areas", [])
	var scene_path : String = save_data.get("scene_path", "uid://ccxi1l11cch26")
	SceneManager.transition_scene(scene_path, "", Vector2.ZERO, "up")
	setup_player()
	pass


func setup_player() -> void:
<<<<<<< HEAD
	var player : Player = PlayerManager.player
	while player == null:
		await get_tree().process_frame
		player = PlayerManager.player
=======
	var player : Player = null 
	while not player:
		player = get_tree().get_first_node_in_group("Player")
		await  get_tree().process_frame
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
	
	player.max_hp = save_data.get("max_hp", 20)
	player.hp = save_data.get("hp", 20)
	
<<<<<<< HEAD
	player.abilities = save_data.get("abilities", {})
=======
	player.dash = save_data.get("dash", false)
	player.double_jump = save_data.get("double_jump", false)
	player.ground_slam = save_data.get("ground_slam", false)
	player.morph_roll = save_data.get("morph_roll", false)
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
	
	player.global_position = Vector2(
			save_data.get("x", 0),
			save_data.get("y", 0)
		)
	pass



func get_file_name() -> String:
	return "user://" + SLOTS[current_slot] + ".sav"
