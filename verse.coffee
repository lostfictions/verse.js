'use strict'

canvas = stage = drawingCanvas = null

config =
	distanceScale: 10
	# maxDotCount

dots = []

lastMouse = { x: 0, y: 0 }

# this is in milliseconds instead of ticks now.
mouseMoveTimeout = 300
curMouseMoveTimeout = 0


@init = () ->
	canvas = document.getElementById("main")

	stage = new createjs.Stage(canvas)
	stage.autoClear = false
	stage.enableDOMEvents(true)

	createjs.Touch.enable(stage)
	createjs.Ticker.setFPS(24)

	drawingCanvas = new createjs.Shape()
	stage.addChild(drawingCanvas)

	# console.log(stage.canvas)

	config.maxDotCount = Math.round(60 * stage.canvas.width / 700)

	stage.addEventListener("stagemousemove", onMouseMove)
	createjs.Ticker.addEventListener("tick", onTick)

	# stage.update()


stop = () ->
	return

addDot = () ->
	dot = new createjs.Point(
		Math.random() * stage.canvas.width,
		Math.random() * stage.canvas.height
	)

	dots.push(dot)

onTick = (event) ->
	if(dots.length < config.maxDotCount and Math.random() < 0.2)
		addDot()

	mouseMoveTimeout -= event.delta

	drawingCanvas.graphics
		.clear()
		.setStrokeStyle(1)
		.beginStroke('#000000')
		# .beginStroke('#ffffff')

	for dot in dots
		drawingCanvas.graphics.moveTo(dot.x, dot.y)
		dot.x += Math.random() * 5 - 2.5
		dot.y += Math.random() * 5 - 2.5
		drawingCanvas.graphics.lineTo(dot.x, dot.y)

		# .moveTo(midPt.x, midPt.y)
		# .curveTo(oldPt.x, oldPt.y, oldMidPt.x, oldMidPt.y)


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
