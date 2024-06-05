extends Node2D

#var taille = get_viewport
#var largeur = taille[0]
#var hauteur = taille[1]


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	#get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#taille = get_viewport().size
	#largeur = taille[0]
	#hauteur = taille[1]
	#$Sprite2D.scale = Vector2(largeur*1.27, hauteur*1.411)
	#$VBoxContainer.size = taille
	#$VBoxContainer.position.x = largeur/2
	#$VBoxContainer.position.y = hauteur/2


func _on_button_pressed():
	get_tree().change_scene_to_file("res://niveau1.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://niveau2.tscn")


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://niveau3.tscn")


func _on_button_4_pressed():
	get_tree().change_scene_to_file("res://niveau4.tscn")


func _on_button_5_pressed():
	get_tree().change_scene_to_file("res://credits.tscn")


func _on_button_6_pressed():
	get_tree().quit()


func _on_button_7_pressed():
	get_tree().change_scene_to_file("res://survie.tscn")
