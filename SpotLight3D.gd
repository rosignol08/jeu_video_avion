extends SpotLight3D

var rotation_x = 0
var rotation_increment = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_x = get_rotation_degrees()
	
	# Changez la direction de l'incrément si on atteint les limites
	if rotation_x.x > 140 or rotation_x.x < 50:
		rotation_increment *= -1
	
	# Effectuez la rotation
	rotate_x(rotation_increment*0.001)
	
	#print(rotation_x.x)
