extends Node2D

var flowX # X coordinate of flow lines
var flowY # Y coordinate of flow lines
var lengths = [0] # number of points in each flow lines
var L # radnom legnths of flow lines
var fX # random x position of flow line on curvilinear domain
var fY # random y position of flow line on curvilinear domain
var Water

func flowlinesdata():
	var dt = 0.01 #controls the speed of the falling flowlines, smaller = slower
	flowUpdate(Water.xu, Water.xd, Water.yu, Water.yd, dt)
	for k in range(20):
		#randomizing the staring position and lenght of the flow lines
		var fx = randf()
		var fy = randf()
		var fl = 0.1*randf()
		flowMaker(Water.xu, Water.xd, Water.yu, Water.yd, fx, fy, fl)

func flowMaker(xu, xd, yu, yd, fx, fy, fl):
	# makes flow using the addflow function
	var l = floor(fl*len(xu))
	addFlow(xu, xd, yu, yd, l, fx, fy)
	
func flowUpdate(xu, xd, yu, yd, dt):
	# updates flow using the addflow function
	#setup temporary variables
	var fXtemp = fX; var fYtemp = fY; var Ltemp = L
	var lengthstemp = lengths
	#resets the variables
	flowX = []; flowY = []; fX = []; fY = []; lengths = [0]; L = [];
	#for every existing flow line
	#creates a new fx, fy, l
	for j in range(len(lengthstemp)-1):
		var fy = fYtemp[j] + 2*dt
		if(fy < 1):
			var l = Ltemp[j]
			var fx = fXtemp[j]
			#calls addflow with all the data
			addFlow(xu, xd, yu, yd, l, fx, fy)

func addFlow(xu, xd, yu, yd, l, fx, fy):
	# Conformal mapping of a rectangular 
	# coordinate to a curvilinear coordinate
	#xu, xd, yu, yd, are the bounds of the curvilinear coordinates
	# fx, fy and the coordinates to be mapped
	var c = floor(fy*len(xu)) 
	var indx = range(max(0, c - floor(l/2)), min(len(xu)-1, c+floor(l/2)))
	for i in indx:
		flowX.append(xd[i] + fx*(xu[i]-xd[i]))
		flowY.append(yd[i] + fx*(yu[i]-yd[i]))
	lengths.append(lengths[-1] + len(indx))
	fX.append(fx)
	fY.append(fy)
	L.append(l)
