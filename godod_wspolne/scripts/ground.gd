extends TileMapLayer

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moisture.seed = randi()
	temperature.seed = randi()
	generate_chunk()#TODO add generating based on player postiton
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
	
func generate_chunk():
	for x in range(100):
		for y in range(100):
			var moist = moisture.get_noise_2d(x,y)
			var temp = temperature.get_noise_2d(x,y)
			set_cell(Vector2i(x,y),0,Vector2i(calc_noise(moist,4),calc_noise(temp,4)))
			print(calc_noise(moist,3))
			
func calc_noise(value,offset) -> int:
	var a = round(value*offset)
	if a > 0:
		return a
	else:
		return -a
