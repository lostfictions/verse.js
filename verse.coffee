'use strict'

canvas = stage = drawingCanvas = null

config =
	maxMouseDistance: 100
	distanceFactor: 10
	contactTimeout: 400 # time in ms before a line can jump to another and try to play a sound.
	fadeFactor: 0.05
	# maxDotCount  # set in init(), since it's based on the canvas size

dots = []

lastMouse = { x: 0, y: 0 }

# this is in milliseconds instead of ticks now.
mouseMoveTimeout = 300
curMouseMoveTimeout = 0

@init = () ->
	canvas = document.getElementById("mainCanvas")

	stage = new createjs.Stage(canvas)
	stage.autoClear = false
	stage.enableDOMEvents(true)

	createjs.Touch.enable(stage)
	createjs.Ticker.setFPS(24)

	canvas.setAttribute("style", "background-color: #000000")

	fadeRect = new createjs.Shape()
	fadeRect.graphics
		.beginFill("rgba(0,0,0,#{ config.fadeFactor })")
		.rect(0, 0, canvas.width, canvas.height)
	stage.addChild(fadeRect)

	drawingCanvas = new createjs.Shape()
	stage.addChild(drawingCanvas)

	config.maxDotCount = Math.round(60 * canvas.width / 700)

	stage.addEventListener("stagemousemove", onMouseMove)
	createjs.Ticker.addEventListener("tick", onTick)


addDot = () ->
	dot = new createjs.Point(
		Math.random() * canvas.width,
		Math.random() * canvas.height
	)
	dot.velocity = new createjs.Point(0, 0)
	dot.contactTimeout = config.contactTimeout

	dots.push(dot)

onTick = (event) ->
	if(dots.length < config.maxDotCount and Math.random() < 0.2)
		addDot()

	mouseMoveTimeout -= event.delta

	drawingCanvas.graphics
		.clear()
		.setStrokeStyle(1)
		.beginStroke('#ffffff')

	for dot in dots
		drawingCanvas.graphics.moveTo(dot.x, dot.y)
		dot.x += Math.random() * 5 - 2.5
		dot.y += Math.random() * 5 - 2.5
		drawingCanvas.graphics.lineTo(dot.x, dot.y)

		# wrap dots around the screen.
		if (dot.x < 0)
			dot.x += canvas.width
		else if (dot.x > canvas.width)
			dot.x -= canvas.width
		if (dot.y < 0)
			dot.y += canvas.height
		else if (dot.y > canvas.height)
			dot.y -= canvas.height

	lastMouse.x = stage.mouseX
	lastMouse.y = stage.mouseY

	stage.update()

onMouseMove = (event) ->
	# midPt = new createjs.Point(oldPt.x + stage.mouseX >> 1, oldPt.y + stage.mouseY >> 1)

	# drawingCanvas.graphics
	# 	.clear()
	# 	.setStrokeStyle(stroke, 'round', 'round')
	# 	.beginStroke(color)
	# 	.moveTo(midPt.x, midPt.y)
	# 	.curveTo(oldPt.x, oldPt.y, oldMidPt.x, oldMidPt.y)

	# oldPt.x = stage.mouseX
	# oldPt.y = stage.mouseY

	# oldMidPt.x = midPt.x
	# oldMidPt.y = midPt.y
