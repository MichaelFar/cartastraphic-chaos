extends RigidBody3D

class_name ShoppingObject

@export var weight : float = 1.0
@export var price : float = 10.0
@export var attractionForceMagnitude : float = 10.0
@export var distanceThreshold : float = 0.5

@export var collisionShape : CollisionShape3D
@export var freezeThreshold : float = 0.1

@export var soundEffectPlayer : AudioStreamPlayer3D

@export_flags("Technology", "Entertainment", "Kids", "Food", "Furniture") var itemCategory

@export var itemName : String


var soundEffectArea : Area3D

var cartParent : Node3D

var targetNode : Node3D

signal object_secured_in_cart

var globalTimer : SceneTreeTimer

var isInCart : bool = false :
	set(value):
		isInCart = value
		print("Value is " + str(value))
		check_if_should_freeze()
	get():
	
		return isInCart
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.add_name_to_list(itemName)
	

func _physics_process(delta: float) -> void:
	
	if(freeze && targetNode != null):
		
		global_transform = targetNode.global_transform
		#rotation = GlobalValues.player.cartMeshContainer.rotation

func apply_force_towards_global_point(point : Node3D, should_stop : bool = false, speed_mod : float = 0.1, impulse_limit : int = -1):
	
	should_stop = global_position.distance_to(point.global_position) <= distanceThreshold
	
	if(should_stop):
		linear_velocity = Vector3.ZERO
		print("Reached destination")
		return
	else:
		if(impulse_limit == -1):
			var timer = get_tree().create_timer(speed_mod)
			timer.timeout.connect(apply_force_towards_global_point.bind(point, should_stop, speed_mod))
		else:
			if(impulse_limit <= 0):
				return
			else:
				
				var timer = get_tree().create_timer(speed_mod)
				timer.timeout.connect(apply_force_towards_global_point.bind(point, should_stop, speed_mod, impulse_limit - 1 ))
	var dynamic_magnitude =  clampf(attractionForceMagnitude * global_position.distance_to(point.global_position), 0.0, attractionForceMagnitude)
	dynamic_magnitude = attractionForceMagnitude
	
	var direction = global_position.direction_to(point.global_position)
	apply_impulse(direction * dynamic_magnitude)

func check_if_should_freeze():
	
	if(freeze):
		print("Freezing")
		return
	else:
		globalTimer = get_tree().create_timer(0.1)
		globalTimer.timeout.connect(check_if_should_freeze)
		if(linear_velocity.length() < freezeThreshold && linear_velocity.length() != 0.0 && isInCart):
			freeze = true
			lock_rotation = true
			#reparent(GlobalValues.player.cartMeshContainer)
			instance_target_node()
			object_secured_in_cart.emit(self)

func instance_target_node():
	
	var target_node = Node3D.new()
	cartParent.add_child(target_node)
	target_node.global_transform = global_transform
	targetNode = target_node

func play_sound_effect():
	print("Playing sound effect")
	soundEffectPlayer.play()
