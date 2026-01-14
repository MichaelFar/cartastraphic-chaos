extends Node3D

@export var grenadeScene : PackedScene

var playerInVolume : bool = false

@export var grenadeThrowInterval : float = 1.0

var target : Vector3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if(playerInVolume):
		target = GlobalValues.player.global_position
		target.y = 0
		look_at(target)
func _on_security_volume_body_entered(body: Node3D) -> void:
	if(body is Player):
		playerInVolume = true
		#throw_grenade()
		body.player_has_won_against_npc.connect(throw_grenade)
		

func _on_security_volume_body_exited(body: Node3D) -> void:
	if(body is Player):
		playerInVolume = false
		body.player_has_won_against_npc.disconnect(throw_grenade)

func throw_grenade():
	if(!playerInVolume):
		return
	print("Throwing grenade")
	var timer = get_tree().create_timer(grenadeThrowInterval)
	timer.timeout.connect(throw_grenade)
	
	var grenade_instance :Grenade = grenadeScene.instantiate()
	GlobalValues.currentLevel.add_child(grenade_instance)
	grenade_instance.global_position = global_position
	grenade_instance.global_rotation = global_rotation
	
	grenade_instance.call_deferred("apply_central_impulse", grenade_instance.global_position.direction_to(target) * 10)
