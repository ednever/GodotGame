extends Control
@export var audio: AudioStreamPlayer2D

func _ready() -> void:
	pass
	#$Timer.start()
	#$Timer.wait_time = 36

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn") 


func _on_timer_timeout() -> void:
	audio.play()
