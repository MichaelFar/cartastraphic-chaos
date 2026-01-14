extends RigidBody3D

class_name Grenade

@export var explosionParticleScene : PackedScene
@export var timeToExplode : float = 5.0

@export var explosionArea : Area3D
signal exploded
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = get_tree().create_timer(timeToExplode)
	timer.timeout.connect(explode)
	exploded.connect(GlobalValues.shake_player_camera)
	explosionParticleScene = preload("res://resources/ExplosionParticle.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.


func explode():
	exploded.emit()
	hide()
	var explosion_instance : GPUParticles3D = explosionParticleScene.instantiate()
	GlobalValues.currentLevel.add_child(explosion_instance)
	explosion_instance.global_position = global_position
	explosion_instance.emitting = true
	explosionArea.monitoring = true
	explosion_instance.finished.connect(end_explosion)

func end_explosion():
	
	queue_free()


func _on_explosion_area_body_entered(body: Node3D) -> void:
	if(body is Player || body is NPCCart):
		body.cartManager.eject_all_items()
	if(body is ShoppingObject):
		body.apply_central_impulse(global_position.direction_to(body.global_position) * 5)
	if(body is NPC):
		if(!body.isSecurity):
			body.fall_over()
			body.rigidBody.apply_central_impulse(global_position.direction_to(body.global_position) * 30)
