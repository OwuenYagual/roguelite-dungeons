extends CharacterBody2D

var ataque_en_proceso = false
var speed = 200


func _ready():
	$AnimationPlayer.play("movimiento")
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)
	$AttackArea.body_entered.connect(_on_attack_area_body_entered)


func _physics_process(delta):
	if not ataque_en_proceso:
		var direction = Input.get_vector("izquierda", "derecha", "arriba", "abajo")
		velocity = direction * speed
		
	move_and_slide()
	
	if Input.is_action_just_pressed("ataque") and not ataque_en_proceso:
		atacar()

func atacar():
	ataque_en_proceso = true
	$AttackArea.monitoring = true
	velocity = Vector2.ZERO
	$AnimationPlayer.play("ataque")
	
func _on_animation_finished(anime_name: String) -> void:
	
	if anime_name == "ataque":
		ataque_en_proceso = false
		$AttackArea.monitoring = false
		print("Ataque terminado: ", ataque_en_proceso)
		$AnimationPlayer.play("movimiento")
		
func _on_attack_area_body_entered(body):
	if  ataque_en_proceso and body.is_in_group("enemies"):
		print("entro al if")
		body.queue_free()
	if body.is_in_group("recompensa"):
		body.play_cofre_animation()
		
