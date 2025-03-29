extends Control

@export var lable: RichTextLabel
@export var timer: Timer
@export var col: ColorRect

func _ready() -> void:
	#################подключите сигнал
	visible = false
	lable.visible_characters = 0
	show_txt()

func show_txt(type: bool = false) -> void:
	lable.visible_characters = 0
	if type == false:
		col.color = '0000ff'
		lable.text = '[color=#ffffff]Your pc is dead
This is gor texting values
-----------------------------[/color]
		'
		lable.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		lable.vertical_alignment = VERTICAL_ALIGNMENT_TOP
		timer.wait_time = 0.01
	else:
		col.color = 'ffffff'
		lable.text = '[color=#000000]You won![/color]'
		lable.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		lable.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		timer.wait_time = 0.5
	var len: int = len(lable.text)
	visible = true
	for i in range(0,len):
		timer.start()
		await timer.timeout
		lable.visible_characters += 1
