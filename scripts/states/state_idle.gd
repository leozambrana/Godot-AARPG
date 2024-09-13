class_name State_Idle extends State

#onreadys
@onready var walk: State = $"../Walk"
@onready var attack = $"../Attack"

# when player enters in state
func enter() -> void: 
	player.updateAnimation('idle');
	pass

# when player exit state
func exit() -> void:
	pass
	
#procces when player update the state
func process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO;
	return null

#what happens during the physics_process update in this state
func physics(_delta: float) -> State:
	return null

#what happens with input events in this state
func handleInput(_event: InputEvent) -> State: 
	if _event.is_action_pressed("attack"):
		return attack
	return null
