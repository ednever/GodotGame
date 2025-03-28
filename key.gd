# Key.gd
extends Node2D

# Определяем класс с именем "Key"
class_name Key

# Свойства ключа
var key_name: String = "Rusty Key"
var is_picked_up: bool = false
var key_id: int = 1

@onready var sprite = $Sprite2D

# Конструктор (опционально, если нужно что-то инициализировать)

func _init(name: String = "Default Key", id: int = 0):
	key_name = name
	key_id = id

func _ready():
	if sprite:
		print("Ключ '" + key_name + "' готов с текстурой!")

# Функция для "поднятия" ключа
func pick_up() -> void:
	if not is_picked_up:
		is_picked_up = true
		print("Ключ '" + key_name + "' подобран!")
		hide()
# Функция для проверки статуса
func get_status() -> String:
	return "Ключ: " + key_name + ", Статус: " + ("Подобран" if is_picked_up else "На месте")

## Сигнал при входе в область
#func _on_area_2d_body_entered(body):
	#if body.is_in_group("player"):  # Предполагаем, что игрок в группе "player"
		#pick_up()


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
