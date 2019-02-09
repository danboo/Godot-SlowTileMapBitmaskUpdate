extends Node2D

onready var tilemap               = get_node("tilemap")
onready var region_button_default = get_node("ui/margins/vbox/region_button_default")
onready var region_button         = get_node("ui/margins/vbox/region_button")
onready var area_button           = get_node("ui/margins/vbox/area_button")
onready var millis_value          = get_node("ui/margins/vbox/center/hbox/millis_value")

export var dimensions : Vector2 = Vector2(1000, 1000)

func _ready():
	region_button_default.connect("button_up", self, "region_button_default_pressed")
	region_button.connect("button_up", self, "region_button_pressed")
	area_button.connect("button_up", self, "area_button_pressed")

func fill_tilemap():
	for i in range(dimensions.y):
		for j in range(dimensions.x):
			tilemap.set_cell(j, i, 0)

func region_button_default_pressed():
	tilemap.clear()
	fill_tilemap()
	var start = OS.get_ticks_msec()

	## slower to do a full update
	tilemap.update_bitmask_region()

	var finish = OS.get_ticks_msec()
	millis_value.text = str(finish - start)

func region_button_pressed():
	tilemap.clear()
	fill_tilemap()
	var start = OS.get_ticks_msec()

	## slower to do a full update
	tilemap.update_bitmask_region(Vector2(0,0), Vector2(dimensions.x - 1, dimensions.y - 1))

	var finish = OS.get_ticks_msec()
	millis_value.text = str(finish - start)

func area_button_pressed():
	tilemap.clear()
	fill_tilemap()
	var start = OS.get_ticks_msec()

	## faster to iterate of every 3rd cell
	for i in range(0, dimensions.y+1, 3):
		for j in range(0, dimensions.x+1, 3):
			tilemap.update_bitmask_area(Vector2(j,i))

	var finish = OS.get_ticks_msec()
	millis_value.text = str(finish - start)
