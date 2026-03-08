@tool
@icon("res://general/icon/level_transition.svg")
class_name LevelTransition extends Node2D

const SIDE_OFFSET := 12
const TOP_OFFSET := -2
const BOTTOM_OFFSET := 48

enum SIDE {LEFT, RIGHT, TOP, BOTTOM}

@export_range(2, 12, 1, "or_greater") var size : int = 2 :
	set(value):
		size = value
		apply_area_settings()

@export var location : SIDE = SIDE.LEFT:
	set(value):
		location = value
		apply_area_settings()

@export_file("*.tscn") var target_level : String = ""
@export var target_area_name : String = "LevelTransition"

@onready var area_2d: Area2D = $Area2D



func _ready() -> void:
	if Engine.is_editor_hint():
		return
	SceneManager.new_scene_ready.connect(_on_new_scene_ready)
	SceneManager.load_scene_finished.connect(_on_load_scene_finished)
	pass


func _on_player_entered(_n : Node2D) -> void:
	
	SceneManager.transition_scene(target_level, target_area_name, get_offset(_n), "Left")
	pass



func _on_new_scene_ready(target_name : String, offset : Vector2) -> void:
	if target_name == name:
		var player : Node = PlayerManager.player
		player.global_position = global_position + offset
	pass


func _on_load_scene_finished() -> void:
	area_2d.monitoring = false
	area_2d.body_entered.connect(_on_player_entered)
	await get_tree().physics_frame
	await get_tree().physics_frame
	area_2d.monitoring = true
	pass


func apply_area_settings() -> void:
	area_2d = get_node_or_null("Area2D")
	if not area_2d:
		return
	if location == SIDE.LEFT or location == SIDE.RIGHT:
		area_2d.scale.y = size
		if location == SIDE.LEFT:
			area_2d.scale.x = -1
		else:
			area_2d.scale.x = 1
	else:
		area_2d.scale.x = size
		if location == SIDE.TOP:
			area_2d.scale.y = 1
		else:
			area_2d.scale.y = -1
	pass


func get_offset(player : Node2D) -> Vector2:
	var offset : Vector2 = Vector2.ZERO
	var player_pos : Vector2 = player.global_position
	
	if location == SIDE.LEFT or location == SIDE.RIGHT:
		offset.y = player_pos.y - self.global_position.y
		if location == SIDE.LEFT:
			offset.x = -SIDE_OFFSET
		else:
			offset.x = SIDE_OFFSET
	else:
		offset.x = player_pos.x - self.global_position.x
		if location == SIDE.TOP:
			offset.y = TOP_OFFSET
		else:
			offset.y = BOTTOM_OFFSET
	
	return offset
