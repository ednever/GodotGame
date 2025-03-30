extends Control
@export var audio: AudioStreamPlayer2D

func _ready() -> void:
	$Timer.start()
	$Timer.wait_time = 36

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn") 


func _on_timer_timeout() -> void:
	audio.play()
