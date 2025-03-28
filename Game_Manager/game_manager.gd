extends Node

enum State {
	PLAYER_HEAR_AND_MONSTER_SEE = 0,
	PLAYER_SEE_AND_MONSTER_HEAR = 1
}

var  state: State = 0
@export var timer_to_change_world_state: Timer
var timer_wait_time: float = 2

# В начале игры:
# Устанавливается таймер
# Переменные состояний получают значения
func _ready() -> void:
	$Timer.wait_time = timer_wait_time
	$Timer.start()
	SignalBus.connect("request_world_state", get_state)
	SignalBus.connect("change_world_state", change_state)

# Возращает сигнал по сигналу
func get_state():
	if state == 0:
		SignalBus.emit_signal("respond_world_state", "player hear and monster see")
	else:
		SignalBus.emit_signal("respond_world_state", "player see and monster hear")

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
