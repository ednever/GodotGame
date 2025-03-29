extends Node

signal respond_world_state(state: bool)
signal change_world_state()

signal respond_player_posiiton(position: Vector2)
signal respond_monster_posiiton(position: Vector2)
signal respond_random_position_for_monster(position: Vector2)

signal key_was_taken()


#Добавить камеру в группу камер в скрипте камеры с помощью сигнала
#Вызвать камеры с помощью сигнала в коде

func getCamera():
	var camera = get_tree().get_first_node_in_group("Camera")

signal player_on_dead()
