extends Node3D


var planes = []  # Liste pour stocker les instances des avions
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is Node3D:  # Vérifiez si le nœud enfant est un bombardier
			planes.append(child)  # Ajoutez le bombardier à la listee

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(planes) == 0:
		return planes
