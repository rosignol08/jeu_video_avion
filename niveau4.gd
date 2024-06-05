extends Node3D

var zepelin = 1
var nb_messer = 9
var nb_bomber1 = 11
var nb_bomber2 = 11
var nb_stuka = 9
var vie_barriere = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgressBar.max_value = vie_barriere
	$TextureProgressBar.value = vie_barriere


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ($zepelin.position.y < 36):
		zepelin = 0
	#print($zepelin.position)
	#print(nb_messer, " ",zepelin, " ",nb_bomber1, " ", nb_stuka, " ")
	if (nb_messer <= 0 and zepelin <= 0 and nb_bomber1 <= 0 and nb_stuka <= 0 and nb_bomber2 <= 0):
		get_tree().change_scene_to_file("res://win_4.tscn")

func _on_raid_messer_child_exiting_tree(node):
	nb_messer -= 1

func _on_raid_bomb_child_exiting_tree(node):
	nb_bomber1 -= 1

func _on_raid_stuka_child_exiting_tree(node):
	nb_stuka -= 1

func _on_area_3d_area_entered(area):
	vie_barriere = vie_barriere - 1
	$TextureProgressBar.value = vie_barriere
	if vie_barriere == 0:
		get_tree().change_scene_to_file("res://gameover_4.tscn")


func _on_raid_bomb_2_child_exiting_tree(node):
	nb_bomber2 -= 1
