'use strict'

canvas = stage = drawingCanvas = null

config =
	# max distance for the mouse to exert an influence on a dot.
	maxMouseDistance: 100
	# max distance within which a dot will contact another.
	maxContactDistance: 50
	# minimum time before a dot can contact another.
	contactTimeout: 400

	contactVelocityFactor: 0.5
	dotSpeedThreshold: 10
	dotDeceleration: 0.99
	fadeFactor: 0.05
	mouseMoveTimeout: 300
	# maxDotCount: 1 # set in init(), since it's based on the canvas size

dots = []

lastMouse = { x: 0, y: 0 }

mouseMoveTimeout = 0

@init = () ->
	canvas = document.getElementById("mainCanvas")

	stage = new createjs.Stage(canvas)
	stage.autoClear = false
	stage.enableDOMEvents(true)

	createjs.Touch.enable(stage)
	createjs.Ticker.setFPS(24)

	canvas.setAttribute("style", "background-color: #000000")

	fadeRect = new createjs.Shape()

	#TODO: this needs to be reset if we rescale the canvas.
	fadeRect.graphics
		.beginFill("rgba(0,0,0,#{ config.fadeFactor })")
		.rect(0, 0, canvas.width, canvas.height)
	stage.addChild(fadeRect)

	drawingCanvas = new createjs.Shape()
	stage.addChild(drawingCanvas)

	config.maxDotCount = Math.round(60 * canvas.width / 700)
	console.log("maxDotCount: " + config.maxDotCount)

	stage.addEventListener("stagemousemove", onMouseMove)
	createjs.Ticker.addEventListener("tick", onTick)

onTick = (event) ->

	mouseMoveTimeout -= event.delta
	dMouseX = stage.mouseX - lastMouse.x
	dMouseY = stage.mouseY - lastMouse.y
	
	if(dots.length < config.maxDotCount and Math.random() < 0.2)
		addDot()


	g = drawingCanvas.graphics

	g
		.clear()
		.setStrokeStyle(1)
		.beginStroke('#ffffff')


	wasNotePlayed = false

	for dot in dots
		drawingCanvas.graphics.moveTo(dot.x, dot.y)
		dot.x += dot.velocity.x
		dot.y += dot.velocity.y
		drawingCanvas.graphics.lineTo(dot.x, dot.y)

		wrapToStage dot

		dot.contactTimeout -= event.delta

		for otherDot in dots when otherDot isnt dot
			dx = dot.x - otherDot.x
			dy = dot.y - otherDot.y
			dist = Math.sqrt(dx * dx + dy * dy)

			if(dist < config.maxContactDistance)

				if(dist > 0)
					vf = config.contactVelocityFactor
					dot.velocity.x += vf * dx / dist
					dot.velocity.y += vf * dy / dist
					otherDot.velocity.x -= vf * dx / dist
					otherDot.velocity.y -= vf * dy / dist

				if(dot.contactTimeout < 0)
					dot.contactTimeout = config.contactTimeout

					g
						.moveTo(dot.x, dot.y)
						.lineTo(otherDot.x, otherDot.y)

					if(not wasNotePlayed)
						wasNotePlayed = true

						# (only the first terms are halved here. that's how it was in the original.)
						dvx = 0.5 * Math.abs(dot.velocity.x) + Math.abs(otherDot.velocity.x)
						dvy = 0.5 * Math.abs(dot.velocity.y) + Math.abs(otherDot.velocity.y)

						relativeSpeed = Math.sqrt(dvx * dvx + dvy * dvy)

						# _s._sound.addTone(
						# 	440,
						# 	scale_verse[
						# 		Math.max(
						# 			0,
						# 			int(Math.random() * 2 ) * 2 - 1 + Math.min(
						# 				scale_verse.length - 1 - uint(scale_verse.length * yd / sH),
						# 				scale_verse.length - 1
						# 			)
						# 		)
						# 	],
						# 	-1,
						# 	xd / (sW * .5) - 1,
						# 	1,
						# 	(.2 + .8 * (d / s)) * VOLUME //s = 10.
						# );
		
		# end iterating through other dots.

		dX = dot.x - stage.mouseX
		dY = dot.y - stage.mouseY

		distMouse = Math.sqrt(dX * dX + dY * dY)

		if(distMouse < config.maxMouseDistance)
			dot.velocity.x += 0.001 * (config.maxMouseDistance - distMouse) * dMouseX
			dot.velocity.y += 0.001 * (config.maxMouseDistance - distMouse) * dMouseY
		
		speed = Math.sqrt(dot.velocity.x * dot.velocity.x + dot.velocity.y * dot.velocity.y)
		if(speed > config.dotSpeedThreshold)
			dot.velocity.x = config.dotSpeedThreshold * dot.velocity.x / speed
			dot.velocity.y = config.dotSpeedThreshold * dot.velocity.y / speed

		dot.velocity.x *= config.dotDeceleration
		dot.velocity.y *= config.dotDeceleration

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


addDot = () ->
	dot = new createjs.Point(
		Math.random() * canvas.width,
		Math.random() * canvas.height
	)
	dot.velocity = new createjs.Point(0, 0)
	dot.contactTimeout = config.contactTimeout

	dots.push(dot)

wrapToStage = (dot) ->
	if (dot.x < 0)
		dot.x += canvas.width
	else if (dot.x > canvas.width)
		dot.x -= canvas.width
	if (dot.y < 0)
		dot.y += canvas.height
	else if (dot.y > canvas.height)
		dot.y -= canvas.height
