extends CharacterBody2D

var world_state: bool

# Получает состояние мира. True - Silence, False - Darkness
func take_world_state(state: bool):
	world_state = !state
	if !world_state:
		$Timer.start()

# Adjust these values as needed
var speed = 5000
var change_direction_time = 2.0
var timer = 0.0
var direction = Vector2.ZERO
# Таймер для обновления координат игрока для монстра
var timer_wait_time: float = 1

var player_position_with_random: Vector2

func update_player_position(position):
	player_position_with_random = position
	print("Pos with rand: ", player_position_with_random)

func _ready():
	randomize()
	_choose_new_direction()
	$Timer.wait_time = timer_wait_time
	$Timer.start()
	SignalBus.connect("respond_world_state", take_world_state)
	SignalBus.connect("respond_random_position_for_monster", update_player_position)


func move_towards_target(delta: float):
	var direction = (player_position_with_random - global_position).normalized()
	velocity = direction * speed * delta
	move_and_slide()

func _on_timer_timeout() -> void:
	if !world_state:
		SignalBus.emit_signal("respond_monster_posiiton", global_position)
		$Timer.start()

func _physics_process(delta):
	if world_state:
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
