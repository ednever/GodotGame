#extends CharacterBody2D
#
#@export var anim: AnimatedSprite2D
#const SPEED = 10000
#var last_direction = 1  # Default to facing right (1 for right, -1 for left)
#
#func _physics_process(delta):
	#var direction = Vector2.ZERO
	#
	#if Input.is_action_pressed("Up"):
		#direction.y -= 1
	#if Input.is_action_pressed("Down"):
		#direction.y += 1
	#if Input.is_action_pressed("Left"):
		#direction.x -= 1
	#if Input.is_action_pressed("Right"):
		#direction.x += 1
	#
	#if direction.x != 0:
		#last_direction = direction.x  # Store last horizontal movement direction
	#
	#if anim:
		#if direction == Vector2.ZERO:
			#anim.play("idle")
		#else:
			#anim.play("walk")
		#
		## Keep character facing last movement direction
		#anim.flip_h = last_direction < 0  
#
	#velocity = direction.normalized() * SPEED * delta
	#move_and_slide()

extends CharacterBody2D

@export var anim: AnimatedSprite2D
const SPEED = 10000
const RUN = 20000
const SNEAK = 5000
var last_direction = 1  # Default to facing right (1 for right, -1 for left)


func _physics_process(delta):
	var speed = SPEED
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	if Input.is_action_pressed("Run"):
		speed = RUN
	if Input.is_action_pressed("Sneak"):
		speed = SNEAK
	
	if direction.x != 0:
		last_direction = direction.x  # Store last horizontal movement direction
	
	if anim:
		if direction == Vector2.ZERO:
			anim.play("idle")
		else:
			anim.play("walk")
		
		# Keep character facing last movement direction
		anim.flip_h = last_direction < 0  

	velocity = direction.normalized() * speed * delta
	move_and_slide()
