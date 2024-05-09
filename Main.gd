#From the Book:
#Create Compelling Science and Engineering Simulations Using the Godot Engine, Copyright 2024 Burney Waring, ThankGod Egbe, Lateef Kareem 
#Chapter 9

extends Node2D

#This project is simulating water falling from a pipe.
#The project is also demonstrating how to break code up into more easily understood pieces
#All the animations are drawn.  All the drawing happens in the Plotfunctions node.
#The other nodes describe the shapes that are sent to the Plotfunctions node.
#This Main script facilitates communications between the nodes that create the shapes and 
#   the Plotfunctions node.  There are other ways to pass data (e.g. an autoloaded Global.gd) 
#   but this way nicely exposes all the data that is being passed.

#Set an initial value for the main input variable
#onready forces nodes to be loaded before anything starts trying to plot	
#Renaming isn't necessary, but it makes typing variables easier
onready var Tank = get_node("Tank")
onready var Plotfunc = get_node("Plotfunctions")
onready var Water = get_node("Water")
onready var Splash = get_node("Splash")
onready var Flowlines = get_node("FlowLines")

func _ready():
	#These statments load the data from Tanks, Water, Splash into the Plotfunctions.gd variables
	#E.g. This next statement forces the reference of 'Tank' in Plotfunction.gd to the same at 'Tank' in Tank.gd
	Plotfunc.Tank = Tank 
	Plotfunc.Water = Water
	Plotfunc.Splash = Splash
	Plotfunc.FlowLines = Flowlines
	#This statment loads the data from Water into the Splash.gd values.
	Splash.Water = Water
	#This statment loads the data from Water into the Flowlines.gd values.
	Flowlines.Water = Water

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#catch any input change and update drawing
	if Input.is_action_pressed("ui_up"):
		Water.Water_Level += 0.05
	if Input.is_action_pressed("ui_down"):
		Water.Water_Level -= 0.05
	$water_level_label.text = str(Water.Water_Level)
	
	#get all the new water data
	Water.waterdata()
	#get all splash area data
	Splash.splashdata()
	#get all the Flowlines data
	Flowlines.flowlinesdata()
	#all the data is ready to be plotted, so call Plotfunctions to do the drawing
	Plotfunc.plotupdate() #the draw commands are here, called to update every frame


func _on_plus_water_level_pressed():
	Water.Water_Level += 0.05  #multiplies pressure by 5

func _on_minus_water_level_pressed():
	Water.Water_Level -= 0.05 #divides pressure by 5



