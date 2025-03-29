extends Control

func _on_play_pressed() -> void:
	# Переход на сцену игры
	get_tree().change_scene_to_file("res://scenes/Main.tscn") 
	

func _on_exit_pressed() -> void:
	# Выход из игры
	get_tree().quit()
