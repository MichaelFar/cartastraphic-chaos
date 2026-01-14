extends CharacterBody3D

class_name NPC

var currentDirection : Vector3

@export var rayCast : RayCast3D

@export var speed : float = 5.0

@export var rigidBody : RigidBody3D

@export var percentChanceToSpawnCart : int = 20

@export var cartPackedScene : PackedScene

@export var cartMarker : Marker3D

@export var isSecurity : bool = false

@export var walletPackedScene : PackedScene

@export var grenadePackedScene : PackedScene

var timerIsRunning : bool = true

var spawnedCart : NPCCart

signal fallen_over

func _ready() -> void:
	
	var timer := get_tree().create_timer(3.0)
	timer.timeout.connect(set_timer_to_false)
	var switch_direction_check_timer := get_tree().create_timer(5.0)
	switch_direction_check_timer.timeout.connect(check_velocity_interval)
	currentDirection = -basis.z
	spawn_cart_at_random()
	
func _physics_process(delta: float) -> void:
	
	if(!timerIsRunning || spawnedCart == null):
		currentDirection.y = 0.0
		velocity = currentDirection * speed
		if(currentDirection != Vector3.ZERO && currentDirection.y <= 0.0):
			
			var target: Basis =  Basis.looking_at(currentDirection)
			
			global_basis = global_basis.slerp(target.orthonormalized(), delta).orthonormalized()
			
		elif(currentDirection.y >= 0.0):
			
			switch_direction()
			
			
		if(rayCast.is_colliding()):
			if(rayCast.get_collider() != spawnedCart):
				switch_direction()
	
	if(spawnedCart != null):
		if(spawnedCart.global_position.distance_to(global_position) >= 5):
			spawnedCart.top_level = true
			spawnedCart = null
	
	move_and_slide()

func fall_over():
	rigidBody.freeze = false
	
	rigidBody.top_level = true
	if(spawnedCart != null):
		spawnedCart.top_level = true
	call_deferred("set_process_to_disabled")
	create_item_on_knockout()
	fallen_over.emit()

func _on_collision_detection_volume_body_entered(body: Node3D) -> void:
	if(body is Player):
		if(body.isRamming):
			
			fall_over()
	#if(body is not ShoppingObject && body != spawnedCart):
		#switch_direction()

func set_process_to_disabled():
	#print("Setting process mode to disabled")
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
	if(currentDirection == Vector3.ZERO):
		currentDirection = -basis.z
	if(!rayCast.is_colliding()):
		currentDirection *= -1

func set_timer_to_false():
	timerIsRunning = false
	currentDirection = -basis.z

func check_velocity_interval():
	var switch_direction_check_timer := get_tree().create_timer(5.0)
	switch_direction_check_timer.timeout.connect(check_velocity_interval)
	if(velocity == Vector3.ZERO):
		switch_direction()

func create_item_on_knockout():
	var rand_obj := RandomNumberGenerator.new()
	var object_instance : RigidBody3D
	if(rand_obj.randi_range(0, 100) <= 90):
		object_instance = walletPackedScene.instantiate()
	else:
		object_instance = grenadePackedScene.instantiate()
		
	GlobalValues.currentLevel.add_child(object_instance)
	object_instance.global_position = global_position
