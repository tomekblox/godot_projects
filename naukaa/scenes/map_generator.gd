extends Node2D

@export var image_path : String = "res://heightmap.png" # Ścieżka do obrazu
@export var tilemap_node : Node
@export var layer_id : int = 0 # Warstwa TileMap
@export var source_ids : Dictionary = { 0: 1, 85: 2, 170: 3, 255: 4 } # Mapowanie kolorów na source_id

func _ready():
	var image = Image.new()
	image.load(image_path) # Wczytaj obraz
	var tilemap = $tilemap_node as TileMapLayer
	tilemap = tilemap_node
	#image.lock()
	
	for x in range(image.get_width()):
		for y in range(image.get_height()):
			var color = image.get_pixel(x, y)
			var grayscale = int(color.r * 255) # Odcień szarości
			var source_id = find_source_id(grayscale)
			
			if source_id != null:
				var coords = Vector2i(x, y)
				tilemap.set_cell(coords,source_id, ne)
				
	
	image.unlock()

func find_source_id(value: int) -> int:
	for threshold in source_ids.keys():
		if value <= threshold:
			return source_ids[threshold]
	return -1 
