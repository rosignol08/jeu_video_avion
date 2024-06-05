extends Node3D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fire_tree_entered():
	for child in get_children():
		child.set_emitting(true)
