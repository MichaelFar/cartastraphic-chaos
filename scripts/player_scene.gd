extends CharacterBody3D

class_name Player

@export var speed : float = 5.0

@export var rotationRate : float = 5.0

@export var head : Node3D
@export var headContainer : Node3D
@export var headMarker : Marker3D

@export var cartMeshContainer : Node3D

@export var cartManager : CartManager

@export var look_speed : float = 0.002

@export var camera : Camera3D

@export var objectSpawnMarker : Marker3D

@export var ramSpeedThreshold : float = 0.8

@export var ejectPointContainer : Node3D

var ejectPointArray : Array[Node]

var look_rotation : Vector2

var mouse_captured : bool = false

var originalRotationRate : float = 0.0

var deltaCounter : float = 0.0

func _ready():
	GlobalValues.player = self
	originalRotationRate = rotationRate
	ejectPointArray = ejectPointContainer.get_children()

func _physics_process(delta: float) -> void:
	
	
	deltaCounter = clampf(deltaCounter, 0.0, 1.0)
	var forward_back_input_strength = Input.get_action_strength("forward") - Input.get_action_strength("back")
	
	velocity = velocity.move_toward(-basis.z * speed * forward_back_input_strength, delta)
	
	if(velocity.length() >= 0.0):
		deltaCounter += delta
	else:
		deltaCounter = 0.0
	
	if(velocity.length() <= (-basis.z * speed * forward_back_input_strength).length() / 4.0):
		
		rotationRate = lerpf(originalRotationRate, originalRotationRate * 3, deltaCounter)
		
	else:
		
		rotationRate = lerpf(rotationRate, originalRotationRate, deltaCounter)
		
	var rotation_input_strength = Input.get_action_strength("turn_right") - Input.get_action_strength("turn_left")
	
	rotation_degrees.y -= delta * rotationRate * rotation_input_strength
	
	headContainer.global_position = headMarker.global_position
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	# Mouse capturing
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		capture_mouse()
	if Input.is_key_pressed(KEY_ESCAPE):
		release_mouse()
	
	# Look around
	if mouse_captured and event is InputEventMouseMotion:
		rotate_look(event.relative)

func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true
	
func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false
	
func rotate_look(rot_input : Vector2):
	
	look_rotation.x -= rot_input.y * look_speed
	look_rotation.x = clamp(look_rotation.x, deg_to_rad(-85), deg_to_rad(85))
	look_rotation.y -= rot_input.x * look_speed
	headContainer.transform.basis = Basis()
	headContainer.rotate_y(look_rotation.y)
	head.transform.basis = Basis()
	head.rotate_x(look_rotation.x)


func _on_object_collector_body_entered(body: Node3D) -> void:
	if(body is ShoppingObject):
		print("Encountered shopping object")
		var shopping_object : ShoppingObject = body
		shopping_object.apply_force_towards_global_point(objectSpawnMarker, false)


func _on_object_container_body_entered(body: Node3D) -> void:
	if(body is ShoppingObject):
		var shopping_object : ShoppingObject = body
		shopping_object.object_secured_in_cart.connect(cartManager.add_object_to_list)
		shopping_object.isInCart = true


func _on_object_container_body_exited(body: Node3D) -> void:
	
	if(body is ShoppingObject):	
		var shopping_object : ShoppingObject = body
		shopping_object.object_secured_in_cart.disconnect(cartManager.add_object_to_list)
		if(!body.freeze):
			cartManager.pop_from_list(body)
			#body.targetNode.queue_free()
			#reparent(GlobalValues.currentLevel)
		shopping_object.isInCart = false
