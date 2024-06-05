extends Node3D

var vie_barriere = 5
var cooldown_time = 3
var unite = 5
var chois = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = str(vie_barriere)
	cooldown_time -= delta
	if cooldown_time <= 0:
		unite = randi()
		cooldown_time = 3
	if (unite % 5 == 0):
		unite = 1
		chois = randf_range(0,3)
		if (chois >= 0):
			var bombeur = preload("res://raid_bomb.tscn")
			var ennemy = bombeur.instantiate()
			ennemy.position = Vector3(130, 60, 0)
			#ennemy.rotate_y(180)
			# Positionnez le projectile à l'emplacement du canon
			add_child(ennemy)
			#print("bombardier :", ennemy)
		if (chois >= 1):
			var bombeur = preload("res://raid_stuka.tscn")
			var ennemy = bombeur.instantiate()
			ennemy.position = Vector3(130, 50, 0)
			##ennemy.rotate_y(-90)
			#ennemy.set_rotation_degrees()
			# Positionnez le projectile à l'emplacement du canon
			add_child(ennemy)
			#print("stuka")
		if (chois >= 2):
			var bombeur = preload("res://raid_messer.tscn")
			var ennemy = bombeur.instantiate()
			ennemy.position = Vector3(130, 40, 0)
			#ennemy.rotate_y(180)
			# Positionnez le projectile à l'emplacement du canon
			add_child(ennemy)
			#print("messer")

func _on_area_3d_area_entered(area):
	vie_barriere = vie_barriere - 1
	$Label.text = str(vie_barriere)
	if vie_barriere == 0:
		get_tree().change_scene_to_file("res://mort_survie.tscn")
