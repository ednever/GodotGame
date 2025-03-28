extends CharacterBody2D

var world_state: bool

# Получает состояние мира. True - Darkness, False - Silence
func take_world_state(state: bool):
	world_state = !state

# Adjust these values as needed
var speed = 5000
var change_direction_time = 2.0
var timer = 0.0
var direction = Vector2.ZERO

func _ready():
	randomize()
	_choose_new_direction()
	SignalBus.connect("respond_world_state", take_world_state)

func _physics_process(delta):
	timer -= delta
	if timer <= 0:
		_choose_new_direction()
	velocity = direction * speed * delta
	move_and_slide()  # No argument needed in Godot 4

func _choose_new_direction():
	# Pick a random angle between 0 and 360 degrees using deg_to_rad()
	var angle = deg_to_rad(randi() % 360)
	direction = Vector2(cos(angle), sin(angle)).normalized()
	timer = change_direction_time
