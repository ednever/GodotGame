extends Node

signal respond_world_state(state: bool)
signal change_world_state()

signal respond_player_posiiton(position: Vector2)
signal respond_monster_posiiton(position: Vector2)
signal respond_random_position_for_monster(position: Vector2)

signal key_was_taken()

signal game_ending(type: bool)

signal player_on_dead()
