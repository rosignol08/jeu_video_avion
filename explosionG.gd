extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_tree_entered():
	$sparks.set_emitting(true)
	$flash.set_emitting(true)
	$fire.set_emitting(true)
	$smoke.set_emitting(true)
