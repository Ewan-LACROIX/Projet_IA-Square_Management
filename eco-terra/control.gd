extends Control

@onready var http := $HTTPRequest
@onready var text_edit := $TextEdit
@onready var label := $Label
@onready var button := $Button
@onready var back_button := $BackButton  # Le bouton pour revenir à la scène précédente

func _ready():
	http.request_completed.connect(_on_request_completed)
	button.pressed.connect(_on_button_pressed)
	back_button.pressed.connect(_on_back_button_pressed)  # Connexion du bouton Retour

func _on_button_pressed():
	var question = text_edit.text.strip_edges()
	if question == "":
		label.text = "Écris une question !"
		return

	var url = "http://localhost:5000/chat"
	var headers = ["Content-Type: application/json"]
	var body = JSON.stringify({"question": question})

	var err = http.request(url, headers, HTTPClient.METHOD_POST, body)
	if err != OK:
		label.text = "Erreur lors de l'envoi de la requête."

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		label.text = json["answer"]
	else:
		label.text = "Erreur du serveur : code " + str(response_code)

# Cette fonction est appelée lorsque l'utilisateur appuie sur le bouton Retour
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/interieur_ecole.tscn")  # Remplace par le chemin de ta scène précédente
