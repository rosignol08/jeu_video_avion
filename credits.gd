extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label3D.position.y += 0.005
	if Input.is_action_pressed("ui_select"):
		$Label3D.position.y -= 0.005


func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu_2d.tscn")
