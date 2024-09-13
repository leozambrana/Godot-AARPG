class_name HurtBox extends Area2D

@export var damage: int = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(areaEntered);
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func areaEntered(area: Area2D) -> void:
	if area is HitBox:
		area.takeDamage(self)
