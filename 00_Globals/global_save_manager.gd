extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save: Dictionary = {
	scene_path = "",
	player = {
		hp = 1,
		maxHp = 1,
		pos_x = 0,
		pos_y = 0
	},
	itens = [],
	persistance = [],
	quests = [],
}

func save_game() -> void:
	update_game_data()
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()
	pass
	
func load_game() ->void:
	var file = FileAccess.open(SAVE_PATH + "save.sav", FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict: Dictionary = json.get_data() as Dictionary
	current_save = save_dict
	
	LevelManager.load_new_level(current_save.scene_path, "", Vector2.ZERO)
	
	await LevelManager.level_load_started
	
	PlayerManager.set_player_position(Vector2(current_save.player.pos_x, current_save.player.pos_y))
	PlayerManager.set_health(current_save.player.hp, current_save.player.maxHp)
	
	await LevelManager.level_loaded
	
	game_loaded.emit()
	pass
	
func update_game_data() -> void:
	var player: Player = PlayerManager.player
	var path: String = ""
	
	#Update player
	current_save.player.hp = player.hp
	current_save.player.maxHp = player.max_hp
	current_save.player.pos_x = player.global_position.x
	current_save.player.pos_y = player.global_position.y
	
	#Update scene
	for c in get_tree().root.get_children():
		if c is Level:
			path = c.scene_file_path
	current_save.scene_path = path;
