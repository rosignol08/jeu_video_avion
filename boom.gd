extends Node3D

var cooldown_time = 3
var unite = 1
var peut_jouer = true
var fini = true
var hey = 0
var son_volume = 0
var son_ton = 0
var i = 0
var light_timer = 0.0
var is_light_fading = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer3D.volume_db = 0.0
	$AudioStreamPlayer3D.pitch_scale = 1.0
	$AudioStreamPlayer3D.stop()
	$DirectionalLight3D.hide()
	$DirectionalLight3D.light_energy = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cooldown_time -= delta
	if cooldown_time <= 0:
		if fini:
			peut_jouer = true
		unite = randi()
		cooldown_time = 2
	if (unite % 5 == 0 or unite % 6 == 0) and peut_jouer:
		etincelle()
		unite = 1

func etincelle():
	peut_jouer = false
	fini = false
	$DirectionalLight3D.show()
	hey = randf_range(2.0, 4.0)
	son_volume = randf_range(3.0, 13.0)
	son_ton = randf_range(0.30,2.0)
	$AudioStreamPlayer3D.volume_db = son_volume
	$AudioStreamPlayer3D.pitch_scale = son_ton
	$AudioStreamPlayer3D.play()
	# Graduellement augmenter l'intensité de la lumière
	#is_light_fading = true
	#while i < hey:
	#	i += 0.1 * hey
	#	$DirectionalLight3D.light_energy = i
	#	await get_tree().process_frame
	#
	## Graduellement diminuer l'intensité de la lumière
	#while i > 0:
	#	i -= 0.05 * hey
	#	$DirectionalLight3D.light_energy = i
	#	await get_tree().process_frame
	#is_light_fading = false
	fini = true
	await get_tree().create_timer(0.1).timeout
	$DirectionalLight3D.hide()


func _on_audio_stream_player_3d_finished():
	peut_jouer = true
