extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	$RichTextLabel.hide()
	$Sprite3D.hide()
	$VBoxContainer/Button4.hide()
	$VBoxContainer/Button.show()
	$VBoxContainer/Button2.show()
	#self.get_pause()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu_2d.tscn")


func _on_button_2_pressed():
	get_tree().quit()


func _on_button_3_pressed():
	$RichTextLabel.show()
	$Sprite3D.show()
	$VBoxContainer/Button.hide()
	$VBoxContainer/Button2.hide()
	$VBoxContainer/Button3.hide()
	$VBoxContainer/Button4.show()
	#get_tree().change_scene_to_file("res://tuto.tscn")


func _on_button_4_pressed():
	$RichTextLabel.hide()
	$Sprite3D.hide()
	$VBoxContainer/Button.show()
	$VBoxContainer/Button2.show()
	$VBoxContainer/Button3.show()
	$VBoxContainer/Button4.hide()
