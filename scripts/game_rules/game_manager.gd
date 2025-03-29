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
var timer_wait_time_for_state_change: float = 5
var player_position: Vector2
var monster_position: Vector2
var keys: int

# В начале игры:
# Устанавливается таймер
# Переменные состояний получают значения
func _ready() -> void:
	$Timer.wait_time = timer_wait_time_for_state_change
	$Timer.start()
	SignalBus.connect("change_world_state", change_state)
	SignalBus.connect("respond_player_posiiton", update_player_position)
	SignalBus.connect("respond_monster_posiiton", update_monster_position)
	SignalBus.connect("key_was_taken", take_keys)

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
	print("Player pos: ", player_position)

func update_monster_position(position):
	monster_position = position
	print("State: ", state)
	vector_counter()

# Функция принимает векторы монстра и игрока и отсылает монстру рандомную координату, куда ему стоит идти
# Функция работает, если монстр in DARKNESS, state = 1
func vector_counter() -> void:
	if state == 1:
		var distance = player_position.distance_to(monster_position)
		# Установка погрешности в зависимости от расстояния (например, 10% от расстояния)
		var error_magnitude = distance * 0.1
			
		# Генерация случайного отклонения в пределах погрешности
		var random_offset = Vector2(
			randf_range(-error_magnitude, error_magnitude),
			randf_range(-error_magnitude, error_magnitude)
		)
		   
		# Создание нового вектора возле позиции игрока с учетом погрешности
		var random_position_for_monster = player_position + random_offset   
		SignalBus.emit_signal("respond_random_position_for_monster", random_position_for_monster)

# Подбор ключей
func take_keys():
	keys += 1
	print(keys)
