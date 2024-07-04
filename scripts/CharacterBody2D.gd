extends CharacterBody2D

var JUMP_VELOCITY = -200.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		$AnimationPlayer.play('fly')
	elif Input.is_action_just_released("ui_accept"):
		$AnimationPlayer.stop()
		
	move_and_slide()
	
func _on_area_2d_area_entered(area):
	if !area.is_in_group("point"):
		rotation = 1.0
		JUMP_VELOCITY = 0
		$AnimationPlayer.active = false
