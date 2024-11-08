extends TileMapLayer

var height = FastNoiseLite.new()
var seed = randi()
var width = 10
var rng
var part_size = 100



func _ready() -> void:
	width *= part_size
	height.seed = seed
	rng = RandomNumberGenerator.new()
	rng.randomize() 
	var val = rng.randfn(5, 1.5) 
	var result = int(clamp(val, 0, 10))

	
	generate_curve()


func _process(delta: float) -> void:
	pass
	
func generate_curve() -> void:
	var heights = []
	heights.resize(width)
	heights.fill(30)
	for i in range(0,width,part_size):
		var rnd_value = int(rng.randfn(0, 10))
		for j in range(part_size):
			heights[i+j] = 30 + rnd_value

			
	for x in range(width):
			for y in range(heights[x]):
				set_cell(Vector2i(x,-y),0,Vector2i(2,1))
	await get_tree().create_timer(2.0).timeout
	
	
	##2
	#for i in range(width-1):
		#heights[i] = (heights[i-1]+heights[i+1])/2
		#
	#clear()
	#for x in range(width):
		#for y in range(heights[x]):
			#set_cell(Vector2i(x,-y),0,Vector2i(2,1))
	#await get_tree().create_timer(2.0).timeout
	
	print("done")
