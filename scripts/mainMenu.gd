extends Control
@export var audio: AudioStreamPlayer2D

func _ready() -> void:
	$AudioStreamPlayer2D/Timer.start()
	$AudioStreamPlayer2D/Timer.wait_time = 96

func _on_play_pressed() -> void:
	# Переход на сцену игры
	audio.stop()
	get_tree().change_scene_to_file("res://scenes/Main.tscn") 
	

func _on_exit_pressed() -> void:
	# Выход из игры
	get_tree().quit()

func _on_timer_timeout() -> void:
	audio.play()
	$AudioStreamPlayer2D/Timer.start()
