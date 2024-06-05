extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("RESET")

func pausee():
	get_tree().paused = true
	$AnimationPlayer.play("flou")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("flou")

func testEsc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pausee()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	testEsc()


func _on_resume_pressed():
	resume()


func _on_recommencer_pressed():
	resume()
	get_tree().reload_current_scene()


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://menu_2d.tscn")
