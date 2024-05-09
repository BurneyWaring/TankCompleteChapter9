extends Node2D
# All variables declared are to be computed from other scripts and imported for plotting
var Tank
var Water
var Splash
var FlowLines

func _draw():
	# Drawing Tank
	plot(Tank.Xt1, Tank.Yt1, Color.black, 3)
	plot(Tank.Xt2, Tank.Yt2, Color.black, 3)
	# Drawing Water
	fill(Water.Xw, Water.Yw, Color.blue, 0.7)
	fill(Water.Xout, Water.Yout, Color.blue, 0.7)
	# Drawing Splash
	fill(Splash.Xf, Splash.Yf, Color.blue, 0.7)
	# Drawing Flowlines
	for j in range(len(FlowLines.lengths)-1):
		var x = []
		var y = []
		for i in range(FlowLines.lengths[j], FlowLines.lengths[j+1]):
			x.append(FlowLines.flowX[i])
			y.append(FlowLines.flowY[i])
		var c = Color(0.5,0.5,0.7,0.5) #created a bluish gray that has some transparency
		plot(x, y, c, 2)

#this is called to update whatever the _draw function has drawn previously with any new data changes
func plotupdate():
	update()
	
# this function plots lines given a vector
# the v vector here is the output of the _scale function with the X and Y arrays describing the line
func plot(X, Y, color, thickness):
	if X == null:
		return
	# Plotting function
	var v = PoolVector2Array()
	for i in range(len(X)):
		v.append(scale(X[i], Y[i]))
	if len(v)>=2:
		draw_polyline(v, color, thickness)
	
# this is used to convert from nominal decimal units to the user's desired screen size
func scale(x, y):
	# Scaling
	return Vector2(250 * (x + 1), 450 - 250 * y)

func fill(X, Y, color, alpha):
	if X == null:
		return
	# fills a colour polygon
	var lightcolor = color.lightened(alpha)
	var v = PoolVector2Array()
	for i in range(len(X)):
		v.append(scale(X[i], Y[i]))
	if len(v)>3:
		draw_colored_polygon(v, lightcolor)
