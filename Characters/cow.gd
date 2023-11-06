extends CharacterBody2D

@export var move_speed : float = 30

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

enum COW_STATE {IDLE, WALK}

var move_direction : Vector2 = Vector2.ZERO
var current_state : COW_STATE = COW_STATE.IDLE


func _ready():
	animation_tree.active = true
	velocity = Vector2.ZERO
	select_new_direction()
	
func _physics_process(delta):
	velocity = move_direction * move_speed
	move_and_slide()
	
func select_new_direction():
	move_direction = Vector2(
		randi_range(1, -1),
		randi_range(-1, 1)
	)
	
func pick_new_state():
	if(current_state == COW_STATE.IDLE):
		animation_tree.set("parameters/Walk/blend_position", false)
		animation_tree.set("parameters/Idle/blend_position", true)
		state_machine.travel("Walk")
		current_state = COW_STATE.WALK
	elif(current_state == COW_STATE.WALK):
		animation_tree.set("parameters/Walk/blend_position", true)
		animation_tree.set("parameters/Idle/blend_position", false)
		state_machine.travel("Idle")
		current_state = COW_STATE.IDLE
		print("Oi")
		

#func update_animation_parameters():
#	if(velocity == Vector2.ZERO):
#		animation_tree.set("parameters/Walk/blend_position", false)
#		if timer.time_left == 0:
#			animation_tree.set("parameters/Blink/blend_position", true)
