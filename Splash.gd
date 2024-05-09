extends Node2D

var wavenumber # Wave number
var wavevel # Wave Velocity
var Xf #Splash coordinates
var Yf 
#Variables from other scripts that define shape of the water
var Water
var time # time
# Called when the node enters the scene tree for the first time.
func _ready():
	time = 0
	wavenumber = 30

func splashdata():
	var delta = 1.0/60.0 #every 1/60 of a second at least
	time = time + delta
	var dxf = 0.005
	# the index [-1] is the last of the array, so in this case the bottom of water
	var xff = 0.5*(Water.xu[-1] + Water.xd[-1])
	var yff = 0.5*(Water.yu[-1] + Water.yd[-1])  
	var xplus = Water.xu[-1]+8*dxf
	var xminus = Water.xd[-1]-8*dxf 
	var yplus = yff
	var yminus = yff
	Xf = [xff]
	Yf = [yff]
	wavevel = 5*Water.v_out
	Xf = [xminus] + Xf + [xplus]
	Yf = [yminus] + Yf + [yplus]
	for i in range(1, 200):
		xplus += dxf 
		xminus -= dxf
		Xf = [xminus] + Xf + [xplus]
		#Gaussian Damping of Wave Equation
		#  below using '\' to break a long line of code
		yplus = yff + exp(-2*(xplus - xff)*(xplus - xff)) \
			*max(0, 0.01*Water.v_out*sin(wavenumber*xplus - wavevel*time)) 
		yminus = yff + exp(-2*(xminus - xff)*(xminus - xff)) \
			*max(0, 0.01*Water.v_out *sin(wavenumber*xminus + wavevel*time)) 
		Yf = [yminus] + Yf + [yplus]

	#make sure the ends are not zero
	Yf[0] -= 0.03
	Yf[-1] -= 0.03
