@tool
@icon("res://general/icon/level_bounds.svg")
class_name LevelBounds extends Node2D

@export_range(480, 2048, 32, "suffix:px") var bound_width : int = 480 : set = _on_width_changed
@export_range(270, 2048, 32, "suffix:px") var bound_height : int = 270 : set = _on_height_changed


func _ready() -> void:
	z_index = 256
	
	if Engine.is_editor_hint():
		return
		
	var _camera : Camera2D = null
	
	while not _camera:
		await  get_tree().process_frame
		_camera = get_viewport().get_camera_2d()
	
	_camera.limit_left = int(global_position.x)
	_camera.limit_top = int(global_position.y)
	_camera.limit_right = int(global_position.x) + bound_width
	_camera.limit_bottom = int(global_position.y) + bound_height
	pass
	
	
func _draw() -> void:
	if Engine.is_editor_hint():
		var r : Rect2 = Rect2(Vector2.ZERO, Vector2(bound_width, bound_height))
		draw_rect(r, Color(0.0, 0.45, 1.0, 0.6), false, 3)
		draw_rect(r, Color(0.0, 0.75, 1.0), false, 1)
	pass


func _on_width_changed (new_width : int) -> void:
	bound_width = new_width
	queue_redraw()
	pass


func _on_height_changed (new_height : int) -> void:
	bound_height = new_height
	queue_redraw()
	pass
