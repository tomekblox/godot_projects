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
		
		
func generate_tree(start_x,start_y) -> void:
	var top
	for y in range(randi_range(5,9)):
		set_cell(Vector2i(start_x , start_y - y),0,Vector2i(1,0)) # dodać gałęzie
		top = start_y - y
		
	for i in range(-1,2,1):
		for j in range(-1,2,1):
			set_cell(Vector2i(start_x+i , top+j),0,Vector2i(3,1)) #leaves

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
	var rnd_value = 0 
	for i in range(0,width,part_size):
		for j in range(part_size):
			if randf() < 0.96:
				heights[i+j] += rnd_value
			else:
				rnd_value += int(rng.randfn(0,10)) # random change - standard deviation
				heights[i+j] += rnd_value
				
	for x in range(width):
			for y in range(heights[x]):
				set_cell(Vector2i(x,-y),0,Vector2i(0,0))  #creating tiles
	await get_tree().create_timer(1.0).timeout                                # stop to see results


	var temp_heights = heights.duplicate(true)
	
	for i in range(width):
		heights[i] = gaus.call(temp_heights,i,linear,1,[0.1]) # tab,start_index,type,start_weight,change
	temp_heights.clear()
		
	var nature = []
	nature.resize(len(heights))
	nature.fill(0)

	clear()
	for x in range(1,width-1):
		if not(heights[x] - heights[x-1] < 1 or heights[x] - heights[x+1] < 1): #pojedyńcze wystające
			heights[x] -=1
		if  not(heights[x] - heights[x-1] < 1 and heights[x] - heights[x+1] < 1): # zmiana wysokości
			pass
		if heights[x] < heights[x-1] and heights[x] < heights[x+1]: # pojedyńcza dziura
			heights[x] += 1
			
			
			
		if  heights[x] - heights[x-1] < 1 and heights[x] - heights[x+1] < 1:
			if randf() > 0.93:
					nature[x] = 1
					set_cell(Vector2i(x,-heights[x]),0,Vector2i(1,0))
					generate_tree(x,-heights[x])
		for y in range(heights[x]):
			if  heights[x] - heights[x-1] < 1 and heights[x] - heights[x+1] < 1:
				set_cell(Vector2i(x,-y),0,Vector2i(0,0))
			else:
				set_cell(Vector2i(x,-y),0,Vector2i(3,0))

	print("done")
