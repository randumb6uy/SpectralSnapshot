extends Node

@export var player_speed : int
@export var initial_light_brightness : int
var player : CharacterBody2D
@export var enemy_speed : int 
var rooms_pos : Array[Vector2]
var floor = -1
var enemy_no : int
var is_sneaking = false
var enemy_pool : Array[CharacterBody2D]
