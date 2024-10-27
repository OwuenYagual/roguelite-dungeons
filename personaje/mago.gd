extends StaticBody2D

var texto_dialogo = "Hola, aventurero. ¡Cuidado con los ciclopes!"  

func _ready():
	$Area2D.body_entered.connect(_on_area_body_entered)
	$Area2D.body_exited.connect(_on_area_body_exited)
	$Label.visible = false

func _on_area_body_entered(body):
	if body.is_in_group("jugador"):
		mostrar_dialogo()

func _on_area_body_exited(body):
	if body.is_in_group("jugador"):
		ocultar_dialogo()

func mostrar_dialogo():
	$Label.text = texto_dialogo 

func ocultar_dialogo():
	$Label.visible = false
