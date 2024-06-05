extends Node3D

var nb_stuka1 = 9
var nb_stuka2 = 9
var nb_stuka = nb_stuka1 + nb_stuka2
var vie_barriere = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgressBar.max_value = vie_barriere
	$TextureProgressBar.value = vie_barriere


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	nb_stuka = nb_stuka1 + nb_stuka2
	if (nb_stuka == 0):
		get_tree().change_scene_to_file("res://win_2.tscn")


func _on_raid_stuka_child_exiting_tree(node):
	nb_stuka1 -= 1

func _on_raid_stuka_2_child_exiting_tree(node):
	nb_stuka2 -= 1


func _on_area_3d_area_entered(area):
	vie_barriere = vie_barriere - 1
	$TextureProgressBar.value = vie_barriere
	if vie_barriere == 0:
		get_tree().change_scene_to_file("res://gameover_2.tscn")
