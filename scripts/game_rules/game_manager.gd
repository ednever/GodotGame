extends Node

# Эти состояния применяются для игрока, для монстра они обратные
enum State {
	DARKNESS = 0, 
	SILENCE = 1
}

var  state = 0:
	get:
		return state
	set(value):
		state = value
		if state == 0:
			SignalBus.emit_signal("respond_world_state", false)
		else:
			SignalBus.emit_signal("respond_world_state", true)
		
@export var timer_to_change_world_state: Timer
var timer_wait_time: float = 2
var player_position: Vector2

# В начале игры:
# Устанавливается таймер
# Переменные состояний получают значения
func _ready() -> void:
	$Timer.wait_time = timer_wait_time
	$Timer.start()
	SignalBus.connect("change_world_state", change_state)
	SignalBus.connect("respond_player_posiiton", update_player_position)

# Меняет состояния мира на противоположные
func change_state():
	if state == 0:
		state = 1
	else:
		state = 0

# Когда таймер заканчивается, состояние мира меняется, таймер начинается заново
func _on_timer_timeout() -> void:
	SignalBus.emit_signal("change_world_state")
	$Timer.start()

func update_player_position(position):
	player_position = position
	print(player_position)
