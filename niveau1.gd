extends Node3D

var nb_bomber1 = 11
var nb_bomber2 = 11
var nb_bomber = nb_bomber1 + nb_bomber2
var vie_barriere = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgressBar.max_value = vie_barriere
	$TextureProgressBar.value = vie_barriere

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	nb_bomber = nb_bomber1 + nb_bomber2
	if (nb_bomber == 0):
		get_tree().change_scene_to_file("res://win_1.tscn")

func _on_raid_bomb_2_child_exiting_tree(node):
	nb_bomber2 -= 1


func _on_raid_bomb_child_exiting_tree(node):
	nb_bomber1 -= 1


func _on_area_3d_area_entered(area):
	vie_barriere = vie_barriere - 1
	$TextureProgressBar.value = vie_barriere
	if vie_barriere == 0:
		get_tree().change_scene_to_file("res://gameover.tscn")
