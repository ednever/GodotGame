extends CharacterBody2D
@export var anim: AnimatedSprite2D
@onready var nav: NavigationAgent2D = $NavigationAgent2D

var world_state: bool

# Получает состояние мира. True - Silence, False - Darkness
func take_world_state(state: bool):
	world_state = !state
	if !world_state:
		$Timer.start()
	else:
		$Timer.stop()

# Adjust these values as needed
var speed = 5000
var change_direction_time = 2.0
var timer = 0.0
var direction = Vector2.ZERO
var last_direction = 1
# Таймер для обновления координат игрока для монстра
var timer_wait_time: float = 1

var player_position_with_random: Vector2

var player = null

func update_player_position(position):
	player_position_with_random = position

func _ready():
	randomize()
	_choose_new_direction()
	$Timer.wait_time = timer_wait_time
	$Timer.start()
	SignalBus.connect("respond_world_state", take_world_state)
	SignalBus.connect("respond_random_position_for_monster", update_player_position)
	

func move_towards_target(delta: float):
	nav.target_position = player_position_with_random
	direction = (nav.get_next_path_position() - global_position).normalized()
	velocity = direction * speed * delta
	move_and_slide()

func _on_timer_timeout() -> void:
	if !world_state:
		SignalBus.emit_signal("respond_monster_posiiton", global_position)
		$Timer.start()

func animate():

	# If no movement, you can choose an idle animation or simply do nothing
	if direction == Vector2.ZERO:
		anim.play("idle")
		return

		# Determine whether horizontal or vertical movement is dominant.
	if abs(direction.x) > abs(direction.y):
		# Horizontal movement is stronger.
		if direction.x > 0:
			anim.play("walk_right")
		else:
			anim.play("walk_left")
	else:
		# Vertical movement is stronger.
		if direction.y > 0:
			anim.play("walk_down")
		else:
			anim.play("walk_up")
	

func _physics_process(delta):
	
	animate()  # Upload the animation
		
	if world_state:
		if player:
			nav.target_position = player.global_position
			direction = (nav.get_next_path_position() - global_position).normalized()
			velocity = direction * speed * delta
			move_and_slide()
		else:
			timer -= delta
			if timer <= 0:
				_choose_new_direction()
				
			velocity = direction * speed * delta
			move_and_slide()  # No argument needed in Godot 4
	if !world_state:
		move_towards_target(delta)

func _choose_new_direction():
	# Pick a random angle between 0 and 360 degrees using deg_to_rad()
	var angle = deg_to_rad(randi() % 360)
	direction = Vector2(cos(angle), sin(angle)).normalized()
	timer = change_direction_time


func _on_monster_vision_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body


func _on_monster_vision_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = null
