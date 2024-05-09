extends Node2D

var Water_Level
var density
var gravity
var floorheight # floor neight
var Xout # Combined X coordinates of water fall
var Yout # Combined X coordinates of water fall
var Xw # Combined X coordinates of water fall
var Yw # Combined X coordinates of water fall
var v_out # Velocity of water fall
var xu # top X coordinates of water fall
var xd # base X coordinates of water fall
var yu # top Y coordinates of water fall
var yd # base Y coordinates of water fall


# Called when the node enters the scene tree for the first time.
func _ready():
	Water_Level = 0.7
	density = 1000 # Replace with function body.
	gravity = 9.8
	floorheight = -0.505


# This creates the shape of the water flowing from the pipe
func waterdata():
	var delta = 1.0/60.0
	var h = Water_Level
	var dt = delta

	#the tank
	v_out = sqrt(2*gravity*(h - 0.08))
	h = max(0.08, h - 0.02*v_out*dt)
	Water_Level = h
	var hp = min(0.12, h) # Depth of water in the orifice
	Xw = [0,0,1,1,1.1, 1.1,1, 1]
	Yw = [h,0,0,0.08,0.08, hp, hp, h]
	
	#the falling water
	if(h > 0.08):
		var dyu = (hp - floorheight)/100   # height step
		var dyd = (0.08 - floorheight)/100 # height step
		#this is where the top of the water stream starts
		#xu, yu is the upper starting point
		#xd, yd is the bottom starting point
		#these are the coordinates of the right side of the small box, the outlet of the pipe
		xu = [1.1] 
		yu = [hp] 
		xd = [1.1] 
		yd = [0.08]

		for i in range(100):
			yu.append(yu[i] - dyu)
			yd.append(yd[i] - dyd)
			xu.append(1.1 + 1.0*v_out*sqrt(2*(hp-yu[-1])/gravity))
			xd.append(1.1 + 1.0*v_out*sqrt(2*(0.08-yd[-1])/gravity))

	#create the outline of the water by making making one polygon
	Yout = []
	Xout = []
	for i in range(100):
		Yout = [yd[i]] + Yout + [yu[i]]
		Xout = [xd[i]] + Xout + [xu[i]]
			
	


