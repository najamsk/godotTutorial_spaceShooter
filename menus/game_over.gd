extends Control

const SAVE_PATH = "user://save.cfg"
const TEST_SAVE_PATH = "res://save.cfg"

@export var game_stats: GameStats

var save_path = TEST_SAVE_PATH

@onready var score_value_label: Label = %ScoreValueLabel
@onready var high_score_value_label: Label = %HighScoreValueLabel

func _ready() -> void:
	load_highscore()
	if game_stats.score > game_stats.high_Score:
		game_stats.high_Score = game_stats.score
		save_highscore()
	score_value_label.text = str(game_stats.score)
	high_score_value_label.text = str(game_stats.high_Score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		game_stats.score = 0
		get_tree().change_scene_to_file("res://menus/menu.tscn")
		
func load_highscore() -> void:
	var config = ConfigFile.new()
	var error = config.load(save_path)
	if error != OK: return
	game_stats.high_Score = config.get_value("game", "highscore")
	
	
	
func save_highscore() -> void:
	var config = ConfigFile.new()
	config.set_value("game", "highscore", game_stats.high_Score)
	config.save(save_path)
