extends CanvasLayer

@onready var button_save: Button = $VBoxContainer/Button_save
@onready var button_load: Button = $VBoxContainer/button_load

var is_paused: bool = false

func _ready() -> void:
	hide_paused_menu()
	button_save.pressed.connect(_on_save_pressed)
	button_load.pressed.connect(_on_load_pressed)
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('pause'):
		if is_paused == false:
			show_paused_menu()
		else:
			hide_paused_menu()
		get_viewport().set_input_as_handled()
		
func show_paused_menu() -> void:
	get_tree().paused = true;
	visible = true
	is_paused = true;
	button_save.grab_focus()
	
func hide_paused_menu() -> void:
	get_tree().paused = false;
	visible = false
	is_paused = false;
		
func _on_save_pressed() -> void:
	if not is_paused:
		return
	SaveManager.save_game()
	hide_paused_menu()

func _on_load_pressed() -> void:
	if not is_paused:
		return
	SaveManager.load_game()
	await LevelManager.level_load_started
	hide_paused_menu()
	pass
