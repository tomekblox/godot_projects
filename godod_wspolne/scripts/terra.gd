extends TileMapLayer

var height = FastNoiseLite.new()
var seed = randi()
var width = 10 #number of parts
var rng
var part_size = 100
var sea_level = 300

var linear = func linear_change(number,change=[]):  # working i think
	return number - change[0]
var root = func root_change(number,change):
	return sqrt(number+change[0])

var gaus = func calc_gaus(tab,start_index,type,start_weight,change=[]):
	var result = 0
	var weight = start_weight
	var i = 0
	#result += tab[start_index+i]*weight
	while weight > 0.1 and start_index-i > 0 and start_index+i < len(tab):
		weight = type.call(weight,change)
		result += tab[start_index+i]*(1-weight)
		result += tab[start_index-i]*(1-weight)
		i+=1
	if i != 0:
		return int(result/(i+1))
	else:
		return 0

func _ready() -> void:
	width *= part_size
	height.seed = seed
	rng = RandomNumberGenerator.new()
	rng.randomize() 
	generate_curve()


func _process(delta: float) -> void:
	pass

func generate_curve() -> void:
	var heights = []
	heights.resize(width)
	heights.fill(sea_level)
	for i in range(0,width,part_size):
		var rnd_value = int(rng.randfn(0, 10))  # random change - standard deviation
		for j in range(part_size):
			if randf() < 0.95:
				heights[i+j] += rnd_value
			else:
				rnd_value += int(rng.randfn(0,10))
				
	for x in range(width):
			for y in range(heights[x]):
				set_cell(Vector2i(x,-y),0,Vector2i(2,1))  #creating tiles
	await get_tree().create_timer(2.0).timeout


	var temp_heights = heights.duplicate(true)
	
	for i in range(width):
		heights[i] = gaus.call(temp_heights,i,linear,1,[0.1]) # tab,start_index,type,start_weight,change

	clear()
	for x in range(width):
		for y in range(heights[x]):
			set_cell(Vector2i(x,-y),0,Vector2i(2,1))

	print("done")
