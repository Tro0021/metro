class_name Player extends CharacterBody2D

const JUMP_INDICATOR = preload("uid://md8hxcf63b2i")


#region on ready variables
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_stand: CollisionShape2D = $CollisionStand
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch
@onready var one_way_platform_ray_cast: RayCast2D = $OneWayPlatformRayCast
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#endregion

#region export variables
@export var move_speed : float = 150
@export var max_fall_speed : float = 600.0
#endregion


#region state machine variables
var states : Array[ PlayerState ]
var current_state : PlayerState :
	get : return states.front()
var previous_state : PlayerState :
	get : return states[ 1 ]
#endregion

#region player stats
var hp : float = 20
var max_hp : float = 20
var dash : bool = false
var double_jump : bool = false
var ground_slam : bool = false
var morph_roll : bool = false
#endregion


#region standard variables
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980
var gravity_multipler : float = 1.0
#endregion



func  _ready() -> void:
	if get_tree().get_first_node_in_group("Player") != self:
		self.queue_free()
	initialize_states()
	self.call_deferred("reparent", get_tree().root)
	pass



func _unhandled_input(event: InputEvent) -> void:
	change_state( current_state.handled_input( event ))
	pass



func _process( _delta: float) -> void:
	update_direction()
	change_state( current_state.process( _delta) )
	pass



func _physics_process( _delta: float) -> void:
	velocity.y += gravity * _delta * gravity_multipler
	velocity.y = clampf(velocity.y, -1000.0, max_fall_speed)
	move_and_slide()
	change_state( current_state.physics_process( _delta) )
	pass



func initialize_states() -> void:
	states = []
	for c in $States.get_children():
		if c is PlayerState:
			states.append( c )
			c.player = self
		pass
	
	if states.size() == 0:
		return
	
	for state in states:
		state.init()
	
	change_state( current_state )
	current_state.enter()
	$Label.text = current_state.name
	pass




func change_state( new_state : PlayerState ) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	states.push_front( new_state )
	current_state.enter()
	states.resize( 3 )
	$Label.text = current_state.name
	pass



func update_direction() -> void:
	var prev_direction : Vector2 = direction
	
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("up", "down")
	direction = Vector2(x_axis, y_axis)
	
	if prev_direction.x != direction.x:
		if direction.x < 0:
			sprite_2d.flip_h = true
		elif direction.x > 0:
			sprite_2d.flip_h = false
	pass




func add_debug_indicator(color : Color =  Color.RED) -> void:
	var d : Node2D = JUMP_INDICATOR.instantiate()
	get_tree().root.add_child( d )
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer( 3.0 ).timeout
	d .queue_free()
	pass
