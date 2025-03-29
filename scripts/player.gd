extends CharacterBody2D
@export var anim: AnimatedSprite2D

const SPEED = 10000
const RUN = 20000
const SNEAK = 5000
var last_direction = 1  # Default to facing right (1 for right, -1 for left)

var self_pos: Vector2
var world_state: bool
var timer_wait_time: float = 2

func _ready() -> void:
	$Timer.wait_time = timer_wait_time
	$Timer.start()
	SignalBus.connect("respond_world_state", take_world_state)
	self_pos = global_position


func _on_timer_timeout() -> void:
	if world_state:
		SignalBus.emit_signal("respond_player_posiiton", self_pos)
		$Timer.start()

# Получает состояние мира. True - Silence для игрока, False - Darkness для игрока
func take_world_state(state: bool):
	world_state = state
	if world_state:
		$Timer.start()

func _physics_process(delta):
	var speed = SPEED
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	if Input.is_action_pressed("Run"):
		speed = RUN
	if Input.is_action_pressed("Sneak"):
		speed = SNEAK
	elif direction != Vector2.ZERO:
		self_pos = global_position
	
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
