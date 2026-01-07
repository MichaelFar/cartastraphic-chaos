extends CharacterBody3D

@export var speed : float = 5.0

@export var rotationRate : float = 3.0

@export var rotationDirectionNode : Node3D

@export var rotationParent : Node3D

@export var head : Node3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	var rotation_direction : Vector3 = (rotationDirectionNode.global_position - rotationParent.global_position).normalized()
	
	var forward_back_input_strength = Input.get_action_strength("forward") - Input.get_action_strength("back")
	
	velocity = velocity.move_toward(rotation_direction * speed * forward_back_input_strength, delta)
	
	#rotation.move_toward(rotationDirectionNode.global_position)
	
	var rotation_input_strength = Input.get_action_strength("turn_right") - Input.get_action_strength("turn_left")
	
	rotationParent.rotation_degrees.y -= delta * rotationRate * rotation_input_strength
	
	move_and_slide()
