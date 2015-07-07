/* @flow weak */

//verse.js
//2014 - 2015

/*global createjs */

const notes = [
  'e', 'f', 'f#', 'g', 'g#',
  'a', 'a#', 'b', 'c', 'c#',
  'd', 'd#', 'e', 'f', 'f#',
  'g', 'g#', 'a', 'a#', 'b',
  'c', 'c#', 'd', 'd#', 'e',
  'f', 'f#', 'g', 'g#', 'a',
  'a#', 'b', 'c', 'c#', 'd',
  'd#', 'e'
];

const config = {
  bufferSize: 2048,
  maxDotFactor: 60 / 500000,
  maxMouseDistance: 100,
  maxContactDistance: 50,
  contactTimeout: 400,
  contactVelocityFactor: 0.5,
  dotSpeedThreshold: 10,
  dotDeceleration: 0.99,
  fadeFactor: 0.05,
  chordChangeTimeout: 5000,
  dotAddRemoveTimeout: 100,
  noteTriggerTimeout: 50,
  chordList: ['e, c, g', 'e, b, g']
};

const audio = {
  actives: [],
  pool: [],
  ctx: null,
  generator: null
};

let maxDotCount = 1;

let dots = [];

let lastMouse = {
  x: 0,
  y: 0
};

let chordChangeTimeout = 0;
let dotAddRemoveTimeout = 0;
let noteTriggerTimeout = 0;
let chordIndex = 0;
let scale = [];

let fadeRect;
let canvas;
let stage;
let drawingCanvas;

function init() {
  canvas = document.getElementById('mainCanvas');

  stage = new createjs.Stage(canvas);
  stage.autoClear = false;
  stage.enableDOMEvents(true);

  createjs.Touch.enable(stage);

  createjs.Ticker.timingMode = createjs.Ticker.RAF_SYNCHED;
  createjs.Ticker.setFPS(60);

  canvas.setAttribute('style', 'background-color: #000000');

  drawingCanvas = new createjs.Shape();
  stage.addChild(drawingCanvas);

  fadeRect = new createjs.Shape();
  stage.addChild(fadeRect);

  setChord(chordIndex);

  //audio stuff.
  const AudioContext = window.AudioContext || window.webkitAudioContext;
  if(!AudioContext) {
    console.log('audio api not available!');
    //TODO: do something smart to handle the api not being available.
    return;
  }
  
  audio.ctx = new AudioContext();
  audio.generator = audio.ctx.createScriptProcessor(config.bufferSize, 0, 2);
  audio.generator.onaudioprocess = processAudio;
  audio.generator.connect(audio.ctx.destination);

  window.addEventListener('resize', onResize);
  onResize();
  stage.addEventListener('stagemousemove', onMouseMove);
  createjs.Ticker.addEventListener('tick', onTick);
}

function onResize() {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  fadeRect.graphics
    .clear()
    .beginFill(`rgba(0,0,0,${ config.fadeFactor })`)
    .rect(0, 0, canvas.width, canvas.height);

  maxDotCount = Math.round(config.maxDotFactor * canvas.width * canvas.height);
  console.log('maxDotCount: ' + maxDotCount);
}

//TODO: should be okay to not use our delta time everywhere because our ticker
//mode is RAF_SYNCHED, but we should do it anyway.
function onTick(event) {
  chordChangeTimeout -= event.delta;
  dotAddRemoveTimeout -= event.delta;
  noteTriggerTimeout -= event.delta;

  const dMouseX = stage.mouseX - lastMouse.x;
  const dMouseY = stage.mouseY - lastMouse.y;

  if(dotAddRemoveTimeout < 0) {
    dotAddRemoveTimeout = config.dotAddRemoveTimeout;
    if(dots.length < maxDotCount) {
      addDot();
    }
    else if(dots.length > maxDotCount) {
      dots.pop();
    }
  }

  const g = drawingCanvas.graphics;

  g
    .clear()
    .setStrokeStyle(1)
    .beginStroke('#ffffff');


  let wasNotePlayed = false;

  for(const dot of dots) {
    g.moveTo(dot.x, dot.y);
    dot.x += dot.velocity.x;
    dot.y += dot.velocity.y;
    g.lineTo(dot.x, dot.y);

    wrapToStage(dot);

    dot.contactTimeout -= event.delta;

    for(const otherDot of dots) {
      if(otherDot === dot) {
        continue;
      }

      const dx = dot.x - otherDot.x;
      const dy = dot.y - otherDot.y;
      const dist = Math.sqrt(dx * dx + dy * dy);

      if(dist > config.maxContactDistance) {
        continue;
      }

      if(dist > 0) {
        const vf = config.contactVelocityFactor;
        dot.velocity.x += vf * dx / dist;
        dot.velocity.y += vf * dy / dist;
        otherDot.velocity.x -= vf * dx / dist;
        otherDot.velocity.y -= vf * dy / dist;
      }

      if(dot.contactTimeout < 0) {
        dot.contactTimeout = config.contactTimeout;

        g
          .moveTo(dot.x, dot.y)
          .lineTo(otherDot.x, otherDot.y);

        if(!wasNotePlayed && noteTriggerTimeout < 0) {
          wasNotePlayed = true;
          noteTriggerTimeout = config.noteTriggerTimeout;

          const avgYPos = (dot.y + otherDot.y) / 2;
          let indScale = Math.round(Math.random() * 2 ) * 2 - 1 +
            scale.length - 1 - Math.round(scale.length * avgYPos / canvas.height);
          indScale = clamp(indScale, 0, scale.length - 1);

          const avgXPos = (dot.x + otherDot.x) / 2;
          const pan = avgXPos / (canvas.width * 0.5) - 1;

          const avgXVel = (Math.abs(dot.velocity.x) + Math.abs(otherDot.velocity.x)) / 2;
          const avgYVel = (Math.abs(dot.velocity.y) + Math.abs(otherDot.velocity.y)) / 2;

          let avgVelocity = Math.sqrt(avgXVel * avgXVel + avgYVel * avgYVel);
          avgVelocity = clamp(avgVelocity, 0, config.dotSpeedThreshold);

          const volume = 0.2 + 0.8 * (avgVelocity / config.dotSpeedThreshold);

          const note = scale[indScale];

          addTone(note, pan, volume);
        }
      }
    } //done iterating through other dots.

    const dX = dot.x - stage.mouseX;
    const dY = dot.y - stage.mouseY;

    const distMouse = Math.sqrt(dX * dX + dY * dY);

    if(distMouse < config.maxMouseDistance) {
      dot.velocity.x += 0.001 * (config.maxMouseDistance - distMouse) * dMouseX;
      dot.velocity.y += 0.001 * (config.maxMouseDistance - distMouse) * dMouseY;
    }

    const speed = Math.sqrt(dot.velocity.x * dot.velocity.x + dot.velocity.y * dot.velocity.y);
    if(speed > config.dotSpeedThreshold) {
      dot.velocity.x = config.dotSpeedThreshold * dot.velocity.x / speed;
      dot.velocity.y = config.dotSpeedThreshold * dot.velocity.y / speed;
    }

    dot.velocity.x *= config.dotDeceleration;
    dot.velocity.y *= config.dotDeceleration;

  }

  lastMouse.x = stage.mouseX;
  lastMouse.y = stage.mouseY;

  stage.update();
}

function processAudio(e) {
  const left = e.outputBuffer.getChannelData(0);
  const right = e.outputBuffer.getChannelData(1);

  //these buffers ain't clean!
  for(let i = 0; i < config.bufferSize; i++) {
    left[i] = 0;
    right[i] = 0;
  }

  for(let j = audio.actives.length - 1; j >= 0; j--) {
    const tone = audio.actives[j];
    for(let i = 0; i < config.bufferSize; i++) {
      if(tone.duration <= 0) {
        continue;
      }

      //i don't really get what these next few values mean. they basically look like magic numbers to me.
      const env = tone.duration / 20000;

      let amp;
      if(tone.phase < 0.5) {
        const tmp = (tone.phase * 4 - 1);
        amp = (1 - tmp * tmp) * env * env * 0.5;
      }
      else {
        const tmp = (tone.phase * 4 - 3);
        amp = (tmp * tmp - 1) * env * env * 0.5;
      }

      tone.phase += tone.freq;

      if(tone.phase >= 1) {
        tone.phase--;
      }

      left[i] += amp * tone.gainL;
      right[i] += amp * tone.gainR;

      tone.duration--;
    }
    if(tone.duration <= 0) {
      audio.actives.splice(j, 1);
    }
  }

  //console.log('left: ' + (left.reduce((p, c) => p + c) / left.length));
}

function addTone(note, pan, volume) {
  const tone = {
    duration: 1 * 44100,
    freq: 440 * Math.pow(2, (note / 12) - 1) / 44100,
    phase: 0,
    gainL: (1 - pan) * volume,
    gainR: (pan + 1) * volume
  };

  audio.actives.push(tone);
}

function onMouseMove(event) {
  if(chordChangeTimeout < 0) {
    chordIndex = (chordIndex + 1) % config.chordList.length;
    setChord(chordIndex);
  }

  chordChangeTimeout = config.chordChangeTimeout;
}

function setChord(index) {
  const chordNotes = config.chordList[index];

  scale = [];

  notes.forEach((note, i) => {
    if(chordNotes.indexOf(note) !== -1) {
      scale.push(i);
    }
  });
}

function addDot() {
  const dot = new createjs.Point(
    Math.random() * canvas.width,
    Math.random() * canvas.height
  );

  dot.velocity = new createjs.Point(0, 0);
  dot.contactTimeout = config.contactTimeout;

  dots.push(dot);
}

function wrapToStage(dot) {
  if(dot.x < 0) {
    dot.x += canvas.width;
  }
  else if(dot.x > canvas.width) {
    dot.x -= canvas.width;
  }
  if(dot.y < 0) {
    dot.y += canvas.height;
  }
  else if(dot.y > canvas.height) {
    dot.y -= canvas.height;
  }
}

function clamp(val, min, max) {
  return Math.max(min, Math.min(max, val));
}

