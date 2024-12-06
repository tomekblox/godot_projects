extends Node2D

@export var image_path : String = "res://sources/jeden.png" # Ścieżka do obrazu
@export var tilemap_node : TileMapLayer
@export var layer_id : int = 0 # Warstwa TileMap
@export var source_ids : Dictionary = { 0: 1, 85: 2, 170: 3, 255: 4 } # Mapowanie kolorów na source_id
var width = 4
var height = 4

func _ready():
	var image = Image.new()
	image.load(image_path) # Wczytaj obraz
	var tilemap = tilemap_node as TileMapLayer
	tilemap = tilemap_node
	#image.lock()
	
	for x in range(image.get_width()):
		for y in range(image.get_height()):
			var color = image.get_pixel(x, y)
			var grayscale = int(color.r * 4) # Odcień szarości
			var source_id = find_source_id(grayscale,grayscale)
			
			if source_id != null:
				var coords = Vector2i(x, y)
				tilemap.set_cell(coords,layer_id, source_id)
				
	

func find_source_id(value: int,value2: int) -> Vector2i:
	#return Vector2i(round(value),round(value2))
	return Vector2i(3,round(value2))
