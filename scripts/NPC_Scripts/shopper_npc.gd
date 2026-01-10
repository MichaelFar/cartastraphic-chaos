extends CharacterBody3D


var currentDirection : Vector3

@export var rayCast : RayCast3D

@export var speed : float = 5.0

@export var rigidBody : RigidBody3D

@export var percentChanceToSpawnCart : int = 20

@export var cartPackedScene : PackedScene

@export var cartMarker : Marker3D

var spawnedCart : NPCCart

signal fallen_over

func _ready() -> void:
	currentDirection = -basis.z
	spawn_cart_at_random()
func _physics_process(delta: float) -> void:
	
	velocity = currentDirection * speed
	if(currentDirection != Vector3.ZERO):
		
		var target: Basis = Basis.looking_at(currentDirection)
		
		basis = basis.slerp(target.orthonormalized(), delta).orthonormalized()
		
	if(rayCast.is_colliding()):
		switch_direction()
	move_and_slide()

func fall_over():
	rigidBody.freeze = false
	
	rigidBody.top_level = true
	if(spawnedCart != null):
		spawnedCart.top_level = true
	call_deferred("set_process_to_disabled")
	fallen_over.emit()

func _on_collision_detection_volume_body_entered(body: Node3D) -> void:
	if(body is Player):
		if(body.isRamming):
			fall_over()

func set_process_to_disabled():
	process_mode = Node.PROCESS_MODE_DISABLED

func spawn_cart_at_random():
	var rand_obj := RandomNumberGenerator.new()
	if(rand_obj.randi_range(0, 100) < percentChanceToSpawnCart):
		var cart_instance := cartPackedScene.instantiate()
		cartMarker.add_child(cart_instance)
		cart_instance.global_position = cartMarker.global_position
		cart_instance.process_mode = Node.PROCESS_MODE_ALWAYS
		spawnedCart = cart_instance
		spawnedCart.front_volume_entered.connect(switch_direction)
		spawnedCart.cartManager.has_ejected.connect(fall_over)

func switch_direction():
	currentDirection = rayCast.get_collision_normal()
	if(!rayCast.is_colliding()):
		currentDirection *= -1
