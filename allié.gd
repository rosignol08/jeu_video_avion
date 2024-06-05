extends Node3D

var max_gauche = -45;
var max_droit = -120;
var max_haut = 50;
var max_bas = 30;
var rotation_x_actuelle = 0
var rotation_y_actuelle = 0
var rotation_increment = 0.003
var is_shooting = false # Indique si le tir est en cours
var direction = Vector3(0, 0, 1) # Direction initiale du canon
var move_speed = 0.2 # Vitesse de déplacement
var time_until_next_shot = 3.0 # Temps jusqu'au prochain tir
var shoot_interval_range = Vector2(0.5, 2.0) # Intervalle de temps aléatoire pour tirer
var cooldown_time = 1.2
var cooldown_time2 = 1.7
var haut_bas = 0
var gauche_droite = 0

func _ready():
	$OmniLight3D.hide()

func _process(delta):
	rotation_x_actuelle = get_rotation_degrees().x
	rotation_y_actuelle = get_rotation_degrees().y
	# Mouvement de gauche à droite
	if (is_shooting==false):
		move_left_right(delta)
		# Mouvement de haut en bas
		move_up_down(delta)
	time_until_next_shot = randi()
	if (time_until_next_shot % 37 == 0):
		shoot()

func move_left_right(delta):
	# Mouvement de gauche à droite
	rotation_y_actuelle = get_rotation_degrees().y
	cooldown_time2 -= delta
	if (cooldown_time2 <= 0):
		gauche_droite = cos(randi())
		cooldown_time2 = 0.7
	# Mouvement de haut en bas
	if gauche_droite < 0:
		if rotation_y_actuelle < max_gauche:
			rotate_y(rotation_increment)
		else:
			pass
			#rotate_y(-rotation_increment)
			#print("tourne à droite",rotation_y_actuelle)
	
	elif gauche_droite >= 0:
		if rotation_y_actuelle > max_droit:
			rotate_y(-rotation_increment)
		else:
			pass
			#rotate_y(rotation_increment)
			#print("tourne à gauche",rotation_y_actuelle)

func move_up_down(delta):
	cooldown_time2 -= delta
	if (cooldown_time2 <= 0):
		haut_bas = cos(randi())
		cooldown_time2 = 0.7
	#print(haut_bas)
	# Mouvement de haut en bas
	if haut_bas < 0:
		if rotation_x_actuelle < max_haut:
			rotate_object_local(Vector3(1, 0, 0), rotation_increment)
		else:
			pass
			#rotate_object_local(Vector3(1, 0, 0), -rotation_increment)
	else:
		if rotation_x_actuelle > max_bas:
			rotate_object_local(Vector3(1, 0, 0), -rotation_increment)
		else:
			pass
			#rotate_object_local(Vector3(1, 0, 0), rotation_increment)

func shoot():
	if not is_shooting:
		# Instanciez le projectile
		var scene = preload("res://area_3d_balle.tscn")
		var new_projectile = scene.instantiate()
		# Obtenez la position actuelle du canon
		var position_actuelle = $MeshInstance3D.global_transform.origin
		# Positionnez le projectile à l'emplacement du canon
		add_child(new_projectile)
		new_projectile.global_transform.origin = position_actuelle
		
		# Déterminez la direction du tir en fonction de l'orientation du canon
		var direction_to_target = $MeshInstance3D.global_transform.basis.y.normalized()
		
		# Définissez la direction du projectile
		new_projectile.set_direction(direction_to_target)
		# Rendez le projectile visible
		new_projectile.show()
		$AudioStreamPlayer3D_Tir.play() # Jouer le son de tir
		# Ajoutez le projectile à la scène
		#get_tree().root.
		is_shooting = true
		$OmniLight3D.show()
		await get_tree().create_timer(0.1).timeout
		$OmniLight3D.hide()
		await get_tree().create_timer(cooldown_time).timeout
		is_shooting = false
		


func _on_audio_stream_player_3d_vide_finished():
	is_shooting = false
	$AudioStreamPlayer3D_Tir.stop()
