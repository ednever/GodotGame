extends Area2D

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("Plus 1 key")
	queue_free()

## Определяем класс с именем "Key"
#class_name Key
#
## Свойства ключа
#var key_name: String = "Rusty Key"
#var is_picked_up: bool = false
#var key_id: int = 1
#
#@onready var sprite = $Sprite2D
#
## Конструктор (опционально, если нужно что-то инициализировать)
#
#func _init(name: String = "Default Key", id: int = 0):
	#key_name = name
	#key_id = id
#
#
## Функция для "поднятия" ключа
#func pick_up() -> void:
	#if not is_picked_up:
		#is_picked_up = true
		#print("Key '" + key_name + "' подобран!")
		#hide()
## Функция для проверки статуса
#func get_status() -> String:
	#return "Key: " + key_name + ", Статус: " + ("Подобран" if is_picked_up else "На месте")
#
#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body.is_in_group("CharacterBody2D"):  # Предполагаем, что игрок в группе "player"
		#pick_up()
