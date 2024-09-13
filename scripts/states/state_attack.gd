class_name State_Attack extends State

var attacking: bool = false;

@export var attack_sound : AudioStream;
@export_range(1, 20, 0.5) var decelerate_speed: float = 5.0;

#onreadys
@onready var walk: State = $"../Walk"
@onready var idle: State = $"../Idle"
@onready var hurt_box: HurtBox = %AttackHurtBox

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var animation_player_attacks: AnimationPlayer = $"../../Sprite2D/AttackEffect/AnimationPlayerAttacks"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

# when player enters in state
func enter() -> void: 
	#animation
	player.updateAnimation('attack');
	animation_player_attacks.play("attack_" + player.animDirection());
	animation_player.animation_finished.connect(endAttack);
	
	#audio
	audio.stream = attack_sound;
	audio.pitch_scale = randf_range(0.9, 1.1);
	audio.play();
	
	#attackingCode
	attacking = true;
	await get_tree().create_timer(0.075).timeout;
	hurt_box.monitoring = true;
	pass

# when player exit state
func exit() -> void:
	animation_player.animation_finished.disconnect(endAttack);
	
	attacking = false;
	hurt_box.monitoring = false;
	pass
	
#procces when player update the state
func process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta;
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle;
		else:
			return walk;
	return null

#what happens during the physics_process update in this state
func physics(_delta: float) -> State:
	return null

#what happens with input events in this state
func handleInput(_event: InputEvent) -> State: 
	return null

func endAttack(_newAnimation: String) -> void:
	attacking = false;
