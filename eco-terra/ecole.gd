extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("C'est notre joueur, on change de scène")
		get_tree().change_scene_to_file("res://Scenes/interieur_ecole.tscn")
