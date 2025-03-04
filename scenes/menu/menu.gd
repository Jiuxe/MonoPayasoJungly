extends Control

@onready var btn_play = $MarginContainer/Control/VBoxContainer/PlayButton
@onready var btn_exit = $MarginContainer/Control/VBoxContainer/ExitButton
@onready var tutorial_button = $MarginContainer/Control/VBoxContainer/TutorialButton

@onready var player_name = %player_name


func _ready():
	# needed for gamepads to work
	player_name.grab_focus()
	if OS.has_feature('web'):
		btn_exit.queue_free() # exit button dosn't make sense on HTML5


func _on_PlayButton_pressed() -> void:
	var params = {
		"player_name": player_name.text
	}
	Game.change_scene_to_file("res://scenes/gameplay/levels/TestLevelToni2.tscn", params)


func _on_ExitButton_pressed() -> void:
	# gently shutdown the game
	var transitions = get_node_or_null("/root/Transitions")
	if transitions:
		transitions.fade_in({
			'show_progress_bar': false
		})
		await transitions.anim.animation_finished
		await get_tree().create_timer(0.3).timeout
	get_tree().quit()
	
func _on_TutorialButton_pressed() -> void:
	var params = {
		"player_name": player_name.text
	}
	Game.change_scene_to_file("res://scenes/gameplay/levels/tutorial.tscn", params)
