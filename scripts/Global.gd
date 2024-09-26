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
var started = false
var power = 80
@export var power_snap_consump :int
@export var power_consumtion : int
var battery_setup = [[8,30],[7,20],[6,10],[5,5] ]
@export_range(0.0 , 1.0) var monster_room_chance : float
@export_range(0.0 , 1.0) var treasure_room_chances : float
@export var max_treasures : int
@export var max_power : int
@export var candle_inc : int
