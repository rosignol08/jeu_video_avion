extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://niveau2.tscn")

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://niveau1.tscn")


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://menu_2d.gd")



func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
