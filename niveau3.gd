extends Node3D

var nb_messer = 9
var nb_messer2 = 9
var vie_barriere = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgressBar.max_value = vie_barriere
	$TextureProgressBar.value = vie_barriere


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (nb_messer == 0 and nb_messer2 == 0):
		get_tree().change_scene_to_file("res://win_3.tscn")


func _on_raid_messer_child_exiting_tree(node):
	nb_messer -= 1


func _on_area_3d_area_entered(area):
	vie_barriere = vie_barriere - 1
	$TextureProgressBar.value = vie_barriere
	if vie_barriere == 0:
		get_tree().change_scene_to_file("res://gameover_3.tscn")


func _on_raid_messer_2_child_exiting_tree(node):
	nb_messer2 -= 1
