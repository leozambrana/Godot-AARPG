class_name PlayerStateMachine extends Node

var states: Array[State];
var prev_state: State;
var current_state: State;

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	changeState(current_state.process(delta));
	pass
	
	
func _physics_process(delta):
	changeState(current_state.physics(delta));
	pass


func _unhandled_input(event):
	changeState(current_state.handleInput(event));
	pass


func initialize(player: Player) -> void:
	states = [];
	
	for c in get_children():
		if c is State:
			states.append(c);
			
	if states.size() == 0:
		return
	
	states[0].player = player;
	states[0].state_machine = self;
	
	for state in states:
		state.init();
	
	changeState(states[0]);
	process_mode = Node.PROCESS_MODE_INHERIT;


func changeState(newState: State) -> void :
	if newState == null || newState == current_state:
		return;
	
	if current_state:
		current_state.exit()
	
	prev_state = current_state;
	current_state = newState;
	current_state.enter();
