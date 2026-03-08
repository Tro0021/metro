class_name Player extends CharacterBody2D

const JUMP_INDICATOR = preload("uid://md8hxcf63b2i")
<<<<<<< HEAD
const MAX_RISE_SPEED := -1000.0

var tree : SceneTree
=======

>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5

#region on ready variables
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_stand: CollisionShape2D = $CollisionStand
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch
@onready var one_way_platform_ray_cast: RayCast2D = $OneWayPlatformRayCast
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#endregion

#region export variables
@export var move_speed : float = 150
<<<<<<< HEAD
@export var acceleration : float = 900
@export var friction : float = 1200
=======
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
@export var max_fall_speed : float = 600.0
#endregion


#region state machine variables
<<<<<<< HEAD
var states : Array[PlayerState]
var current_state : PlayerState
var previous_state : PlayerState
=======
var states : Array[ PlayerState ]
var current_state : PlayerState :
	get : return states.front()
var previous_state : PlayerState :
	get : return states[ 1 ]
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
#endregion

#region player stats
var hp : float = 20
var max_hp : float = 20
<<<<<<< HEAD

var abilities := {
	"dash": true,
	"double_jump": false,
	"ground_slam": false,
	"morph_roll": false
}
=======
var dash : bool = false
var double_jump : bool = false
var ground_slam : bool = false
var morph_roll : bool = false
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
#endregion


#region standard variables
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980
var gravity_multipler : float = 1.0
#endregion



<<<<<<< HEAD
func _ready() -> void:
	tree = get_tree()

	if tree.get_first_node_in_group("Player") != self:
		queue_free()

	PlayerManager.player = self
	initialize_states()
	call_deferred("reparent", tree.root)
=======
func  _ready() -> void:
	if get_tree().get_first_node_in_group("Player") != self:
		self.queue_free()
	initialize_states()
	self.call_deferred("reparent", get_tree().root)
	pass
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5



func _unhandled_input(event: InputEvent) -> void:
	change_state( current_state.handled_input( event ))
	pass



func _process( _delta: float) -> void:
	update_direction()
	change_state( current_state.process( _delta) )
	pass



func _physics_process( _delta: float) -> void:
	velocity.y += gravity * _delta * gravity_multipler
<<<<<<< HEAD
	velocity.y = clampf(velocity.y, MAX_RISE_SPEED, max_fall_speed)
=======
	velocity.y = clampf(velocity.y, -1000.0, max_fall_speed)
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
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
	
<<<<<<< HEAD
	current_state = states[0]
=======
	change_state( current_state )
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
	current_state.enter()
	$Label.text = current_state.name
	pass




<<<<<<< HEAD
func change_state(new_state : PlayerState) -> void:
	if new_state == null or new_state == current_state:
		return

	if current_state:
		current_state.exit()

	previous_state = current_state
	current_state = new_state

	current_state.enter()
	$Label.text = current_state.name
=======
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
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5



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




<<<<<<< HEAD
func add_debug_indicator(color : Color = Color.RED) -> void:
	var d : Node2D = JUMP_INDICATOR.instantiate()
	tree.root.add_child(d)
	d.global_position = global_position
	d.modulate = color
	await tree.create_timer(3.0).timeout
	d.queue_free()

func take_damage(amount : float) -> void:
	hp -= amount
	
	if hp <= 0:
		die()

func die() -> void:
	hp = 0
	queue_free()
=======
func add_debug_indicator(color : Color =  Color.RED) -> void:
	var d : Node2D = JUMP_INDICATOR.instantiate()
	get_tree().root.add_child( d )
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer( 3.0 ).timeout
	d .queue_free()
	pass
>>>>>>> 0cdac4234134e59f003d1cc5c763d4504afeaec5
