extends Camera3D
var max_gauche = -37;
var max_droit = -150;
var max_haut = 75;
var max_bas = 15;
var light : OmniLight3D
var rotation_x_actuelle = get_rotation_degrees().x
var rotation_y_actuelle = get_rotation_degrees().y
var rotation_increment = 0.003
var is_shooting = false # Indique si le tir est en cours
var shooting_timer = 0 # Compteur pour la durée du tir
var cooldown_time = 0.5 # Temps de refroidissement de l'arme en secondes
var chargeur = 10
var recharge = false
var zepelin_tombe = false

func _ready():
	pass # Replace with function body.
	$OmniLight3D.hide()
	$Label2.text = str(chargeur)
	$Label3.hide()
	$TextureProgressBar.hide()
	$TextureProgressBar.value = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	rotation_x_actuelle = get_rotation_degrees().x
	rotation_y_actuelle = get_rotation_degrees().y
	if Input.is_action_pressed("ui_up") and is_shooting==false:
		if rotation_x_actuelle < max_haut:
			#rotate_x(rotation_increment)
			rotate_object_local(Vector3(1, 0, 0), rotation_increment)
			
	if Input.is_action_pressed("ui_down") and is_shooting==false:
		if rotation_x_actuelle > max_bas:
			rotate_object_local(Vector3(1, 0, 0), -rotation_increment)
			
	if Input.is_action_pressed("ui_left") and is_shooting==false:
		if rotation_y_actuelle < max_gauche:
			rotate_y(0.003)
			
	if Input.is_action_pressed("ui_right") and is_shooting==false:
		if rotation_y_actuelle > max_droit:
			rotate_y(-0.003)
			
	if Input.is_action_just_pressed("ui_select") and is_shooting==false:
		if chargeur == 0:
			$AudioStreamPlayer3D_vide.play()
			
		else:
			#print(rotation_y_actuelle)
			#print(rotation_x_actuelle)
			$AudioStreamPlayer3D_Tir.play() # Jouer le son de tir
			$AnimationPlayer.play("tir")
			is_shooting = true
			shoot()
			_camera_shake()
			chargeur -= 1
			$Label2.text = str(chargeur)
			$OmniLight3D.show()
			await get_tree().create_timer(0.1).timeout
			$OmniLight3D.hide()
	
	if Input.is_action_just_pressed("r") and recharge == false and chargeur < 10:
		is_shooting = true
		recharge = true
		$Label2.hide()
		$Label3.show()
		$TextureProgressBar.show()
		$AudioStreamPlayer3D_recharge.play()
		$TextureProgressBar.value = 0
		while $TextureProgressBar.value < 100:
			$TextureProgressBar.value += 10
			#print($TextureProgressBar.value)
			await get_tree().create_timer(0.3).timeout
		$TextureProgressBar.hide()
		$TextureProgressBar.value = 0
		$Label3.hide()
		$Label2.show()
		chargeur = 10
		$Label2.text = str(chargeur)
		is_shooting = false
		#print("recharge")
		
	
	
func _on_audio_stream_player_3d_tir_finished():
	is_shooting = false
	$AudioStreamPlayer3D_Tir.stop()

func _on_animation_player_animation_finished(tir):
	$AnimationPlayer.play("stope")

func _on_audio_stream_player_3d_recharge_finished():
	recharge = false
	$AudioStreamPlayer3D_recharge.stop()

# Dans votre fonction de tir
func shoot():
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
	# Ajoutez le projectile à la scène
	#get_tree().root.add_child(new_projectile)

#programme de https://www.reddit.com/r/godot/comments/174nfgo/i_couldnt_find_a_simple_and_easy_3d_camera_shake/
@export var period = 0.3
@export var magnitude = 0.1

func _camera_shake():
	var initial_transform = self.transform 
	var elapsed_time = 0.0
	
	while elapsed_time < period:
		var offset = Vector3(
			randf_range(-magnitude, magnitude),
			randf_range(-magnitude, magnitude),
			0.0
		)
	
		self.transform.origin = initial_transform.origin + offset
		elapsed_time += get_process_delta_time()
		await get_tree().process_frame
	
	self.transform = initial_transform
