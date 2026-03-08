extends CanvasLayer

signal load_scene_started
signal new_scene_ready(target_name : String, offset : Vector2)
signal load_scene_finished
signal scene_entered(uid : String)

var current_scene_uid : String
<<<<<<< HEAD
var transitioning : bool = false
=======
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5

func _ready() -> void:
	await get_tree().process_frame
	load_scene_finished.emit()
	pass



func transition_scene(new_scene : String, target_area : String, player_offset : Vector2, _dir : String) -> void:
<<<<<<< HEAD
	if transitioning:
		return
	transitioning = true
=======
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
	
	load_scene_started.emit()
	
	await get_tree().process_frame
	
	get_tree().change_scene_to_file(new_scene)
	current_scene_uid = ResourceUID.path_to_uid(new_scene)
	scene_entered.emit(current_scene_uid)
	
	await get_tree().scene_changed
	
	new_scene_ready.emit(target_area, player_offset)
	
	
	
	load_scene_finished.emit()
<<<<<<< HEAD
	transitioning = false
=======
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
	pass
