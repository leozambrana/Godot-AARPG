class_name EnemyState extends Node


var enemy: Enemy
var state_machine: EnemyStateMachine

func init() -> void:
	pass
	
func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func process(_delta: float) -> EnemyState:
	
	return null

#what happens during the physics_process update in this state
func physics(_delta: float) -> EnemyState:
	return null
