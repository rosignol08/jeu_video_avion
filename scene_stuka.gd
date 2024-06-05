extends Node3D


var vie = 20
var speed = 0.30
var max_height_variation = 15  # Variation maximale de la position Y
var base_height = 0  # Hauteur de base de l'avion
var direction = Vector3(0, 0, 10)  # Par défaut, l'avion avance vers l'avant
# Variables pour la modulation sinusoidale de la variation de la position Y
var amplitude = 1  # Amplitude de la variation sinusoidale
var frequency = 0.10  # Fréquence de la variation sinusoidale
var time_elapsed = 0  # Temps écoulé depuis le début de la scène
var maxi = 4
var amplitude_y = 5  # Amplitude de la variation sinusoidale pour la position Y
var frequency_y = 0.05  # Fréquence de la variation sinusoidale pour la position Y

# Called when the node enters the scene tree for the first time.
func _ready():
	base_height = global_transform.origin.y
	$AudioStreamPlayer3D.play()
	$petit_feu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Mise à jour du temps écoulé
	#time_elapsed += 0.1*delta
	
	# Variation sinusoidale de la position Y
	var target_height = base_height + amplitude_y * sin(0.2 * PI * frequency_y * time_elapsed)
	direction.y = target_height - global_transform.origin.y
	
	# Variation sinusoidale de la position Z
	var target_depth = amplitude * sin(2 * PI * frequency * time_elapsed)
	direction.x = target_depth
	# Déplacer l'avion selon la direction et la vitesse
	translate(direction * speed * delta)
	#if (time_elapsed <= maxi):
		#time_elapsed += delta  # Incrémenter le temps écoulé
		#$AudioStreamPlayer3D.set_pitch_scale(time_elapsed)
	if (position.z < 40 and position.z > 0):
		$AudioStreamPlayer3D.set_pitch_scale(0.1*position.z)#((-1*(3/40))*position.z)+4
	#print("son:",$AudioStreamPlayer3D.get_pitch_scale())

func _on_area_3d_area_entered(area):
	# Vérifiez si l'objet entrant est capable d'appliquer des dégâts
	self.vie -= 10  # Appliquez des dégâts à l'objet touché
	$petit_feu.show()
	if self.vie <= 0:  # Si la vie de l'avion est maintenant à 0 ou moins
		$AudioStreamPlayer3D.stop()
		queue_free()
