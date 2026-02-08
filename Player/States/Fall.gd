class_name PlayerStateFall extends PlayerState

@export var fall_gravity_multipler : float = 1.165
@export var coyote_time : float = 0.125
@export var jump_buffer_time = 0.2

var coyote_timer : float = 0
var buffer_timer : float = 0



#What happens when this state is initialized ?
func init() -> void:
	pass


#What happens when we enter this state?
func enter() -> void:
	player.animation_player.play("jump")
	player.animation_player.pause()
	player.gravity_multipler = fall_gravity_multipler
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
	pass


#What happens when we exit this state?
func exit() -> void:
	player.gravity_multipler = 1.0
	buffer_timer = 0
	pass


#What happens when an input is pressed?
func handled_input( _event: InputEvent) -> PlayerState:
	#Handle_ input
	if _event.is_action_pressed( "jump" ):
		if coyote_timer > 0:
			return jump
		else:
			buffer_timer = jump_buffer_time
	
	return next_state


#What happens each process tick in this state?
func process( _delta: float ) -> PlayerState:
	coyote_timer -= _delta
	buffer_timer -= _delta
	set_jump_frame()
	return next_state


#What happens each physics_process tick in this state?
func physics_process( _delta: float ) -> PlayerState:
	if player.is_on_floor():
		#player.add_debug_indicator()
		if buffer_timer > 0:
			return jump
		return idle
	player.velocity.x = player.direction.x * player.move_speed
	return next_state


func set_jump_frame() -> void:
	var frame : float = remap(player.velocity.y, 0.0, player.max_fall_speed, 0.5, 1.0)
	player.animation_player.seek(frame, true)
	pass
