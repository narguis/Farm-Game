extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree : AnimationTree = $AnimationTree

var input_direction : Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true
	animation_tree.set("parameters/Idle/blend_position", starting_direction)

func _process(_delta):
	update_animation_parameters()

func _physics_process(_delta):
#	var input_direction = Vector2(
#		Input.get_action_strength("right") - Input.get_action_strength("left"),
#		Input.get_action_strength("down") - Input.get_action_strength("up")
#	)
	input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	if input_direction:
		velocity = input_direction * move_speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func update_animation_parameters():
	if(velocity == Vector2.ZERO):
		animation_tree.set("parameters/conditions/idle", true)
		animation_tree.set("parameters/conditions/is_moving", false)
	else:
		animation_tree.set("parameters/conditions/idle", false)
		animation_tree.set("parameters/conditions/is_moving", true)
		
	if(input_direction != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", input_direction)
		animation_tree.set("parameters/Walk/blend_position", input_direction)
	
