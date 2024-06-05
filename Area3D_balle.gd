extends Area3D

var speed = 160
var direction = Vector3.ZERO
var time_elapsed = 0
const MAX_LIFETIME = 2  # Durée de vie maximale de la balle en secondes
var explosion = preload("res://explosion.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_elapsed += delta  # Incrémenter le temps écoulé
	global_transform.origin += direction * speed * delta
	# Vérifier si la balle existe depuis plus de 3 secondes
	if time_elapsed >= MAX_LIFETIME:
		var explosion_instance = explosion.instantiate()
		explosion_instance.position = $".".position
		get_parent().add_child(explosion_instance)
		queue_free()  # Supprimer la balle de la scène


func _on_area_entered(body):
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = $".".position
	get_parent().add_child(explosion_instance)
	queue_free()  #Supprimer la balle de la scène

func set_direction(new_direction: Vector3):
	if (direction == Vector3.ZERO):
		direction = new_direction
