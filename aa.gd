extends Node3D

var scene_names = ["res://raid_bomb.tscn", "res://raid_stuka.tscn", "res://raid_messer.tscn", "res://zepelin.tscn"]

# Indice de la scène actuelle
var current_scene_index = 0

# Liste des instances de scènes
var scene_instances = []
var plane_counter_label

func instance_scene():
	# Vérifier si nous avons atteint la fin de la liste des scènes
	if current_scene_index >= len(scene_names):
		# Fin du jeu
		return
	
	# Charger la prochaine scène
	var scene_instance = load(scene_names[current_scene_index]).instantiate()
	# Connecter le signal de mort de l'avion à la fonction _on_plane_destroyed
	scene_instance.connect("plane_destroyed",_on_plane_destroyed)
	# Modifier la position initiale de la scène
	var initial_position = Vector3(-10, 0, 0)  # Définir la position initiale souhaitée
	scene_instance.global_transform.origin = initial_position
	# Ajouter l'instance de scène à la liste
	scene_instances.append(scene_instance)
	# Ajouter l'instance de scène à la scène principale
	add_child(scene_instance)

func _on_plane_destroyed():
	# Décrémenter le nombre d'avions restants
	plane_counter_label.text = str(int(plane_counter_label.text) - 1)
	# Vérifier s'il reste des avions
	if int(plane_counter_label.text) <= 0:
		# Passer à la scène suivante
		next_scene()

func next_scene():
	# Supprimer les instances de scène actuelles
	for instance in scene_instances:
		instance.queue_free()
	# Vider la liste des instances
	scene_instances = []
	# Passer à la scène suivante
	current_scene_index += 1
	# Instancier la scène suivante
	instance_scene()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Instancier la première scène
	#instance_scene()
	# Récupérer la référence au label
	plane_counter_label = $CanvasLayer/Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("k"):
		current_scene_index = current_scene_index + 1
