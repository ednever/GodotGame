extends CharacterBody2D

const SPEED = 10000

func _physics_process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("Up"):
		direction.y -= 1
	if Input.is_action_pressed("Down"):
		direction.y += 1
	if Input.is_action_pressed("Left"):
		direction.x -= 1
	if Input.is_action_pressed("Right"):
		direction.x += 1
	
	direction = direction.normalized()
	
	velocity = direction * SPEED * delta
	
	move_and_slide()
