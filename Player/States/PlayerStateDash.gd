class_name PlayerStateDash
extends PlayerState

@export var dash_speed : float = 450
@export var dash_time : float = 0.15

var timer : float = 0


func enter() -> void:
	timer = dash_time
	player.animation_player.play("run")


func physics_process(delta: float) -> PlayerState:
	timer -= delta
	
	player.velocity.y = 0
	player.velocity.x = player.direction.x * dash_speed
	
	if timer <= 0:
		return idle
	
	return next_state
