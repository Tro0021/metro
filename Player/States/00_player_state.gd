@icon("res://Player/States/state.svg")
class_name PlayerState extends Node

var player : Player
var next_state : PlayerState

#region state references
@onready var idle: PlayerStateIdle = %Idle
@onready var run: PlayerStateRun = %Run
@onready var jump: PlayerStatejump = %jump
@onready var fall: PlayerStateFall = %fall
@onready var crouch: PlayerStateCrouch = %crouch
#endregion


#What happens when this state is initialized ?
func init() -> void:
	pass


#What happens when we enter this state?
func enter() -> void:
	pass


#What happens when we exit this state?
func exit() -> void:
	pass


#What happens when an input is pressed?
func handled_input( _event: InputEvent) -> PlayerState:
	return next_state


#What happens each process tick in this state?
func process( _delta: float ) -> PlayerState:
	return next_state


#What happens each physics_process tick in this state?
func physics_process( _delta: float ) -> PlayerState:
	return next_state
