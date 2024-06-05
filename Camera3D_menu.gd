extends Camera3D

var cooldown_time = 2
var unite = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$SpotLight3D.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cooldown_time -= delta
	if (cooldown_time <= 0):
		unite = randi()
		cooldown_time = 2
	if (unite % 5 == 0 or unite % 6 == 0):
		_camera_shake()
		_clinginote()
		unite = 1

#code de https://www.reddit.com/r/godot/comments/174nfgo/i_couldnt_find_a_simple_and_easy_3d_camera_shake/
@export var period = 0.9
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

func _clinginote():
	for i in range (4):
		$SpotLight3D.hide()
		await get_tree().create_timer(0.1).timeout
		$SpotLight3D.show()
		await get_tree().create_timer(0.1).timeout
