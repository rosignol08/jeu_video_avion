extends Node3D

var vie = 200
var speed = 0.02
var direction = Vector3(0, 0, 1)
var joue = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	$AudioStreamPlayer3.stop()
	$AudioStreamPlayer2.play()
	$AnimationPlayer.pause()
	$petit_feu.hide()
	$petit_feu2.hide()
	$petit_feu3.hide()
	$petit_feu4.hide()
	$petit_feu5.hide()
	$petit_feu6.hide()
	$petit_feu7.hide()
	$explosion.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = position.x - speed
	#print(position.x)
	#if (position.x < 120 and $AudioStreamPlayer2.is_playing() == false and joue == 0):
	#	$AudioStreamPlayer2.play()
	#	joue = 1


func _on_area_3d_area_entered(area):
	self.vie -= 10  # Appliquez des dégâts à l'objet touché
	print("vie:",self.vie)
	$AudioStreamPlayer3.play()
	if self.vie == 160:
		$petit_feu.show()
	elif self.vie == 130:
		$petit_feu2.show()
	elif self.vie == 100:
		$petit_feu3.show()
	elif self.vie == 60:
		$petit_feu4.show()
	elif self.vie == 40:
		$petit_feu5.show()
	elif self.vie == 20:
		$petit_feu6.show()
	elif self.vie == 10:
		$petit_feu7.show()
	elif self.vie <= 0:  # Si la vie de l'avion est maintenant à 0 ou moins
		$AnimationPlayer.play("mort")
		$explosion.show()
		#queue_free()
		#await get_tree().create_timer(0.8).timeout


func _on_audio_stream_player_2_finished():
	$AudioStreamPlayer2.stop()
