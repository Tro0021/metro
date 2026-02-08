class_name PlayerStateCrouch extends PlayerState

@export var deceleration_rate : float = 10


#What happens when this state is initialized ?
func init() -> void:
	pass


#What happens when we enter this state?
func enter() -> void:
	player.animation_player.play("crouch")
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	pass


#What happens when we exit this state?
func exit() -> void:
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	pass


#What happens when an input is pressed?
func handled_input( _event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		if player.one_way_platform_ray_cast.is_colliding() == true:
			player.position.y += 4
			return fall
		return jump
	return next_state


#What happens each process tick in this state?
func process( _delta: float ) -> PlayerState:
	if player.direction.y <= 0.5:
		return idle
	return next_state


#What happens each physics_process tick in this state?
func physics_process( _delta: float ) -> PlayerState:
	player.velocity.x -= player.velocity.x * deceleration_rate * _delta
	if player.is_on_floor() == false:
		return fall
	return next_state
