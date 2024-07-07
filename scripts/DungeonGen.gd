extends Node

enum Tiles{EMPTY , SOLID }

class Room:
	var position : Vector2
	var dimensions : Vector2
	var centerpoint : Vector2

var dugRooms = []
var rng = RandomNumberGenerator.new()

var mapWidth
var mapHeight

func _ready():
	rng.randomize()
