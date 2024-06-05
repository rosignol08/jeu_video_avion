extends Node3D

var speed = 60
var max_turn_speed = 5  # Vitesse maximale à laquelle l'avion peut tourner
var max_height_variation = 7  # Variation maximale de la position Y
var base_height = 0  # Hauteur de base de l'avion
var direction = Vector3(10, 0, 0)  # Par défaut, l'avion avance vers l'avant
var vie = 10
# Variables pour la modulation sinusoidale de la variation de la position Y
var amplitude = 2  # Amplitude de la variation sinusoidale
var frequency = 0.25  # Fréquence de la variation sinusoidale
var time_elapsed = 0  # Temps écoulé depuis le début de la scène
var amplitude_z = 2  # Amplitude de la variation sinusoidale pour la position Z
var frequency_z = 0.15  # Fréquence de la variation sinusoidale pour la position Z

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("FakeFly")
	base_height = global_transform.origin.y  # Enregistrez la hauteur de base de l'avion
	$AudioStreamPlayer3D.play()
	$petit_feu.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Mise à jour du temps écoulé
	time_elapsed += delta
	
	# Variation sinusoidale de la position Y
	var target_height = base_height + amplitude * sin(2 * PI * frequency * time_elapsed)
	direction.y = target_height - global_transform.origin.y
	
	# Variation sinusoidale de la position Z
	var target_depth = amplitude_z * sin(2 * PI * frequency_z * time_elapsed)
	direction.z = target_depth
	# Déplacer l'avion selon la direction et la vitesse
	translate(direction * speed * delta)
	


func _on_animation_player_animation_finished(_FakeFly):
	$AnimationPlayer.play("FakeFly")


func _on_area_3d_area_entered(area):
	# Vérifiez si l'objet entrant est capable d'appliquer des dégâts
	self.vie -= 10  # Appliquez des dégâts à l'objet touché
	$petit_feu.show()
	if self.vie <= 0:  # Si la vie de l'avion est maintenant à 0 ou moins
		$AudioStreamPlayer3D.stop()
		queue_free()
