extends TileMapLayer

var height = FastNoiseLite.new()
var seed = randi()
var width = 500
var rng


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	height.seed = seed
	rng = RandomNumberGenerator.new()
	rng.randomize() 
	var val = rng.randfn(5, 1.5) 
	var result = int(clamp(val, 0, 10))

	
	generate_curve()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func generate_curve() -> void:
	var heights = []
	heights.resize(width)
	heights.fill(30)
	for i in range(width-1):
		if i % 2 == 0:
			heights[i] = 30 + int(rng.randfn(10, 5))
		else:
			heights[i] = (heights[i-1] + heights[i+1])/2
			
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
