extends CharacterBody2D
@export var anim: AnimatedSprite2D

const SPEED = 10000
const RUN = 20000
const SNEAK = 5000
var last_direction = 1  # Default to facing right (1 for right, -1 for left)


var world_state: bool
var timer_wait_time: float = 2

func _ready() -> void:
	$Timer.wait_time = timer_wait_time
	$Timer.start()
	SignalBus.connect("respond_world_state", take_world_state)


func _on_timer_timeout() -> void:
	SignalBus.emit_signal("respond_player_posiiton", global_position)
	$Timer.start()

# Получает состояние мира. True - Silence, False - Darkness
func take_world_state(state: bool):
	world_state = state

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
