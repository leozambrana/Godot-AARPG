class_name State extends Node
	
static var player: Player;
static var state_machine: PlayerStateMachine

func _ready():
	pass 
	
func init() -> void:
	pass

# when player enters in state
func enter() -> void: 
	pass

# when player exit state
func exit() -> void:
	pass
	
#procces when player update the state
func process(_delta: float) -> State:
	return null

#what happens during the physics_process update in this state
func physics(_delta: float) -> State:
	return null

#what happens with input events in this state
func handleInput(_event: InputEvent) -> State: 
	return null
