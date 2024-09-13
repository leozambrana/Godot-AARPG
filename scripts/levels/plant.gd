extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$HitBox.Damage.connect(takeDamage);
	pass # Replace with function body.

func takeDamage(_hurt_box: HurtBox) -> void:
	print('entrou aqui no hit plant')
	queue_free();
	pass
	
