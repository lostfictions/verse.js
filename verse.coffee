'use strict'

notes = [
	"e", "f", "f#", "g", "g#"
	"a", "a#", "b", "c", "c#"
	"d", "d#", "e", "f", "f#"
	"g", "g#", "a", "a#", "b"
	"c", "c#", "d", "d#", "e"
	"f", "f#", "g", "g#", "a"
	"a#", "b", "c", "c#", "d"
	"d#", "e"
]

config =
	# a multiplier on the canvas size to determine the max number of points.
	maxDotFactor: 60 / 500000
	# max distance for the mouse to exert an influence on a dot.
	maxMouseDistance: 100
	# max distance within which a dot will contact another.
	maxContactDistance: 50
	# minimum time before a dot can contact another.
	contactTimeout: 400
	# multiplier for the velocity we confer when dots make contact.
	contactVelocityFactor: 0.5

	dotSpeedThreshold: 10
	dotDeceleration: 0.99

	fadeFactor: 0.05

	chordChangeTimeout: 5000
	
	chordList: [
		"e, c, g"
		"e, b, g"
	]

# we'll set this in init() based on the canvas size.
maxDotCount = 1

dots = []

lastMouse = { x: 0, y: 0 }

scale = []
chordChangeTimeout = 0
chordIndex = 0

canvas = stage = drawingCanvas = null

@init = () ->
	canvas = document.getElementById("mainCanvas")

	stage = new createjs.Stage(canvas)
	stage.autoClear = false
	stage.enableDOMEvents(true)

	createjs.Touch.enable(stage)
	createjs.Ticker.setFPS(24)

	canvas.setAttribute("style", "background-color: #000000")

	fadeRect = new createjs.Shape()

	drawingCanvas = new createjs.Shape()
	stage.addChild(drawingCanvas)

	#TODO: this needs to be reset if we rescale the canvas.
	fadeRect.graphics
		.beginFill("rgba(0,0,0,#{ config.fadeFactor })")
		.rect(0, 0, canvas.width, canvas.height)
	stage.addChild(fadeRect)

	#TODO: this also needs to be reset if we rescale the canvas.
	# (rescaling should also remove points if needed.)
	maxDotCount = Math.round(config.maxDotFactor * canvas.width * canvas.height)
	# console.log("maxDotCount: " + maxDotCount)

	setChord(chordIndex)

	stage.addEventListener("stagemousemove", onMouseMove)
	createjs.Ticker.addEventListener("tick", onTick)

onTick = (event) ->

	chordChangeTimeout -= event.delta
	dMouseX = stage.mouseX - lastMouse.x
	dMouseY = stage.mouseY - lastMouse.y
	
	if(dots.length < maxDotCount and Math.random() < 0.2)
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

		wrapToStage(dot)

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

					if(wasNotePlayed is false)
						wasNotePlayed = true

						# (only the first terms are halved here, yeah. that's how it is in the actionscript!)
						dvx = 0.5 * Math.abs(dot.velocity.x) + Math.abs(otherDot.velocity.x)
						dvy = 0.5 * Math.abs(dot.velocity.y) + Math.abs(otherDot.velocity.y)

						relativeSpeed = Math.sqrt(dvx * dvx + dvy * dvy)


						indScale = Math.round(Math.random() * 2 ) * 2 - 1 + scale.length - 1 - Math.round(scale.length * dvy / canvas.height)
						indScale = clamp(indScale, 0, scale.length - 1)

						noteToPlay = scale[indScale]

						# this is probably pan. in which case using dxv here maybe doesn't make much sense?
						MYSTERY_FACTOR = dvx / (canvas.width * 0.5) - 1

						# these numbers might not make sense for the SoundJS API.
						volume = 0.2 + 0.8 * d / config.dotSpeedThreshold

						#TODO: here we will play a beautiful sound.
		
		# done iterating through other dots.

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
	if(chordChangeTimeout < 0)
		chordIndex = (chordIndex + 1) % config.chordList.length
		setChord(chordIndex)

	chordChangeTimeout = config.chordChangeTimeout

setChord = (index) ->
	chordNotes = config.chordList[index]

	scale = []

	for note, i in notes
		if(chordNotes.indexOf(note) isnt -1)
			scale.push(i)

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

clamp = (val, min, max) ->
	Math.max(min, Math.min(max, val))