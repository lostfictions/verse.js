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

audio =
	actives: []
	pool: []

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
	dotAddRemoveTimeout: 100
	noteTriggerTimeout: 50

	chordList: [
		"e, c, g"
		"e, b, g"
	]

# we'll set this in init() based on the canvas size.
maxDotCount = 1

dots = []

lastMouse = { x: 0, y: 0 }

chordChangeTimeout = 0
dotAddRemoveTimeout = 0
noteTriggerTimeout = 0

chordIndex = 0
scale = []

fadeRect = canvas = stage = drawingCanvas = null

@init = () ->
	canvas = document.getElementById("mainCanvas")

	stage = new createjs.Stage(canvas)
	stage.autoClear = false
	stage.enableDOMEvents(true)

	createjs.Touch.enable(stage)

	createjs.Ticker.timingMode = createjs.Ticker.RAF_SYNCHED
	createjs.Ticker.setFPS(60)

	canvas.setAttribute("style", "background-color: #000000")

	drawingCanvas = new createjs.Shape()
	stage.addChild(drawingCanvas)

	fadeRect = new createjs.Shape()
	stage.addChild(fadeRect)
	
	setChord(chordIndex)



	# audio stuff.
	window.AudioContext = window.AudioContext || window.webkitAudioContext
	if(not window.AudioContext?)
		console.log("audio api not available!")
		# TODO: do something smart to handle the api not being available.
	else
		audio.ctx = new AudioContext()

	window.addEventListener('resize', onResize)
	onResize()
	stage.addEventListener("stagemousemove", onMouseMove)
	createjs.Ticker.addEventListener("tick", onTick)

onResize = () ->
	canvas.width = window.innerWidth
	canvas.height = window.innerHeight
	fadeRect.graphics
		.clear()
		.beginFill("rgba(0,0,0,#{ config.fadeFactor })")
		.rect(0, 0, canvas.width, canvas.height)

	maxDotCount = Math.round(config.maxDotFactor * canvas.width * canvas.height)
	console.log("maxDotCount: " + maxDotCount)

# TODO: should be okay to not use our delta time everywhere because our ticker
# mode is RAF_SYNCHED, but we should do it anyway.
onTick = (event) ->
	tickTones(event.delta)
	chordChangeTimeout -= event.delta
	dotAddRemoveTimeout -= event.delta
	noteTriggerTimeout -= event.delta

	dMouseX = stage.mouseX - lastMouse.x
	dMouseY = stage.mouseY - lastMouse.y
	
	if(dotAddRemoveTimeout < 0)
		dotAddRemoveTimeout = config.dotAddRemoveTimeout
		if(dots.length < maxDotCount)
			addDot()
			console.log "adding... " + dots.length
		else if(dots.length > maxDotCount)
			dots.pop()
			console.log "removing... " + dots.length


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

					if(not wasNotePlayed and noteTriggerTimeout < 0)
						wasNotePlayed = true
						noteTriggerTimeout = config.noteTriggerTimeout

						avgYPos = (dot.y + otherDot.y) / 2
						indScale = Math.round(Math.random() * 2 ) * 2 - 1 + scale.length - 1 - Math.round(scale.length * avgYPos / canvas.height)
						indScale = clamp(indScale, 0, scale.length - 1)

						avgXPos = (dot.x + otherDot.x) / 2
						pan = avgXPos / (canvas.width * 0.5) - 1

						avgXVel = (Math.abs(dot.velocity.x) + Math.abs(otherDot.velocity.x)) / 2
						avgYVel = (Math.abs(dot.velocity.y) + Math.abs(otherDot.velocity.y)) / 2
						avgVelocity = Math.sqrt(avgXVel * avgXVel + avgYVel * avgYVel)
						avgVelocity = clamp(avgVelocity, 0, config.dotSpeedThreshold)

						volume = 0.2 + 0.8 * (avgVelocity / config.dotSpeedThreshold)

						note = scale[indScale]

						addTone(note, pan, volume)

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

tickTones = (delta) ->
	toDequeue = 0

	for tone in audio.actives
		tone.duration -= delta

		if(tone.duration < 0)
			# see hack below -- if we stop the oscillator, it seems to get GC'd in Firefox right now.
			# tone.osc.stop(0)
			tone.gain.gain.value = 0
			toDequeue++
		else
			frac = (tone.duration / tone.initDuration) * tone.volume
			# let's use exponential instead of linear gain.
			tone.gain.gain.value = frac * frac

	while(toDequeue > 0)
		# actives should be ordered by duration, so we can just shift from the front to dequeue them.
		audio.pool.push(audio.actives.shift())
		toDequeue--

# TODO: handle pan using a PannerNode
addTone = (note, pan, volume) ->
	tone = audio.pool.pop()
	if(not tone?)
		osc = audio.ctx.createOscillator()
		osc.type = "sine"
		gain = audio.ctx.createGain()
		osc.connect(gain)
		gain.connect(audio.ctx.destination)
		tone = 
			osc: osc
			gain: gain
		# HACK: start the oscillator on initialization and never stop it,
		# since it seems to get erroneously GC'd or messed up otherwise?
		tone.osc.start(0)
		
	tone.duration = 1000
	tone.initDuration = tone.duration
	
	tone.volume = volume
	tone.gain.gain.value = tone.volume

	tone.osc.frequency.value = 440 * Math.pow(2, (note / 12) - 1)

	# HACK: see above
	# tone.osc.start(0)	

	audio.actives.push(tone)


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