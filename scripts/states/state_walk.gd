class_name State_Walk extends State

#exports
@export var move_speed: float = 150.0;

#onreadys
@onready var idle: State = $"../Idle"
@onready var attack = $"../Attack"

# when player enters in state
func enter() -> void: 
	player.updateAnimation('walk');
	pass

# when player exit state
func exit() -> void:
	pass
	
#procces when player update the state
func process(_delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * move_speed;
	
	if player.setDirection():
		player.updateAnimation('walk')
	return null

#what happens during the physics_process update in this state
func physics(_delta: float) -> State:
	return null

#what happens with input events in this state
func handleInput(_event: InputEvent) -> State: 
	if _event.is_action_pressed("attack"):
		return attack
	return null
