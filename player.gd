extends CharacterBody2D

const max_speed = 75
const accel = 250
const friction = 1500
const jump_velocity = -250
const gravity = 1000

var input = Vector2.ZERO

func handle_animation():
	if Input.is_action_pressed("ui_right") and is_on_floor():
		$Wizard.flip_h = false
		$Wizard/WizardAnimation.play("Walk")
	elif Input.is_action_pressed("ui_left") and is_on_floor():
		$Wizard.flip_h = true
		$Wizard/WizardAnimation.play("Walk")
	elif Input.is_action_pressed("ui_down"):
		$Wizard/WizardAnimation.play("Crouch")
	else:
		$Wizard/WizardAnimation.play("Idle")
		
		
func _physics_process(delta):
	
	# Handle jump
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_velocity
		$AudioStreamPlayer2D.play()
	
	# Handle left and right movement
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * max_speed, accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)	
		
	handle_animation()
	move_and_slide()

	



	
