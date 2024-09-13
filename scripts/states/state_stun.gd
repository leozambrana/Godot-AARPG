class_name State_Stun extends State

#exports
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0
@export var invulnerable_duration: float = 1.0

var hurt_box: HurtBox
var direction: Vector2

var next_state: State = null;

#onreadys
@onready var idle: State = $"../Idle"

func init() -> void:
	player.player_damaged.connect(_player_damaged)
	pass

# when player enters in state
func enter() -> void: 
	player.animation_player.animation_finished.connect(_animation_finished)
	
	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity = direction * -knockback_speed
	player.setDirection()
	
	player.updateAnimation("stun")
	player.make_invulnerable(invulnerable_duration)
	player.effect_animation_player.play("damaged")
	pass

# when player exit state
func exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect(_animation_finished)
	pass
	
#procces when player update the state
func process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta;
	return next_state

#what happens during the physics_process update in this state
func physics(_delta: float) -> State:
	return null

#what happens with input events in this state
func handleInput(_event: InputEvent) -> State: 
	return null

func _player_damaged(_hurt_box: HurtBox) -> void:
	hurt_box = _hurt_box
	state_machine.changeState(self);
	pass

func _animation_finished(_animation: String) -> void:
	next_state = idle;
