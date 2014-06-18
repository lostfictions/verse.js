// **************************************************************
//  Copyright (c) 2013, Leshy Labs LLC
//  All rights reserved
//
//  Not for distribution
//
//  This may not be reproduced or distributed in any form
//  without express permission from Leshy Labs LLC
// **************************************************************
var d = !0,
    f = null,
    j = !1;
window.La = d;
"use strict";
var k = new function () {
        var a = document.getElementsByTagName("script"),
            b = this,
            c;
        for (c = 0; c < a.length; c++)
            if (a[c].src && a[c].src.match(/eju.js$/)) {
                this.U = a[c].src.match(/^(.*\/)eju.js$/)[1];
                break
            }
        this.U || (this.U = "");
        this.ta = 1;
        this.r = {};
        this.ba = [];
        this.$ = j;
        window.onload = function () {
            b.T()
        }
    };
k.wb = -1 != navigator.userAgent.indexOf("Firefox");
k.Ta = -1 != navigator.userAgent.indexOf("MSIE");
k.yb = -1 != navigator.userAgent.indexOf("Opera");
k.zb = -1 != navigator.userAgent.indexOf("AppleWebKit");
k.vb = -1 != navigator.userAgent.indexOf("Chrome");
k.xb = -1 != navigator.userAgent.indexOf("midori");
k.sb = void 0 !== window.ontouchstart;
k.a = {};
k.a.Rb = {};
k.a.canvas = {};
k.b = {};
k.data = {};
k.Gb = {};
k.Jb = {};
k.Eb = {};
k.ib = {};
k.extend = function (a, b) {
    for (var c in b.prototype) a[c] = b.prototype[c];
    a.Lb = b
};
k.addListener = function (a, b, c) {
    a.addEventListener ? a.addEventListener(b, c, d) : a.attachEvent(b)
};
k.removeListener = function (a, b, c) {
    a.removeEventListener ? a.removeEventListener(b, c, d) : a.detachEvent(b)
};
k.ob = function (a, b, c, e, g, h) {
    b = a.clientX + (window.pageXOffset || 0) - b;
    a = a.clientY + (window.pageYOffset || 0) - c;
    e && (0 > b && (b = 0), 0 > a && (a = 0));
    g && b > g - 1 && (b = g - 1);
    h && a > h - 1 && (a = h - 1);
    return [b, a]
};
k.T = function (a) {
    var b;
    if (0 == --this.ta && !this.$) {
        this.$ = d;
        for (b = 0; b < this.ba.length; b++) this.ba[b]()
    }
    a && a()
};
k.Xa = function (a) {
    this.$ ? a() : this.ba.push(a)
};
k.nb = function (a) {
    a = a.button;
    k.Ta && (1 == a ? a = 0 : 4 == a && (a = 1));
    return a
};
k.Q = function (a) {
    a = a || window.event;
    a.cancelBubble = d;
    a.returnValue = j;
    a.stopPropagation && a.stopPropagation();
    a.preventDefault && a.preventDefault();
    return j
};
k.ea = function (a) {
    a = a || window.event;
    var b = a.changedTouches[0],
        c = document.createEvent("MouseEvents");
    c.initMouseEvent(a.type.replace("touch", "mouse").replace(/end$/, "up").replace(/start$/, "down"), d, d, a.target, 1, b.screenX, b.screenY, b.clientX, b.clientY, j, j, j, j, 0, f);
    a.target.dispatchEvent(c);
    return k.Q(a)
};
k.gb = function (a) {
    k.addListener(a, "touchstart", k.ea);
    k.addListener(a, "touchend", k.ea);
    k.addListener(a, "touchmove", k.ea)
};
k.fb = function (a, b, c, e) {
    a.m ? a.m[b] || (a.m[b] = []) : (a.m = {}, a.m[b] = []);
    a.m[b].push({
        ma: c,
        data: e,
        object: a
    })
};
k.Qb = function (a, b, c) {
    if (a.m && a.m[b]) {
        a = a.m[b];
        for (b = 0; b < a.length; b++) a[b].ma == c && a.splice(b, 1)
    }
};
k.fireEvent = function (a, b) {
    var c, e;
    if (a.m && a.m[b]) {
        c = a.m[b];
        for (e = 0; e < c.length; e++) {
            var g = c[e];
            if (g.ma.call(g.object, g.data) === j) break
        }
    }
};
k.Qa = function () {
    var a = window.location.href,
        b = {}, c, a = a.match(/^[^\?]*\?([^#]*)$/);
    if (!a) return b;
    c = decodeURI(a[1]).split("&");
    for (a = 0; a < c.length; a++) {
        var e = c[a].match(/^([^=]*)/)[1],
            g = c[a].match(/^[^=]*=(.*$)/)[1];
        b[e] = parseFloat(g) == g ? parseFloat(g) : g
    }
    return b
};
k.eb = function (a, b) {
    if (a.className) {
        var c = a.className.split(/ /),
            e;
        for (e = 0; e < c.length; e++)
            if (c[e] == b) return;
        a.className += " " + b
    } else a.className += b
};
k.Ib = function (a, b) {
    var c = a.className.split(/ /),
        e;
    for (e = 0; e < c.length; e++) c[e] == b && c.splice(e--, 1);
    a.className = c.join(" ")
};
k.rb = function (a, b) {
    var c = a.className.split(/ /),
        e;
    for (e = 0; e < c.length; e++)
        if (c[e] == b) return d;
    return j
};
k.pb = function (a) {
    return window.pageXOffset + a.getBoundingClientRect().left
};
k.qb = function (a) {
    return window.pageYOffset + a.getBoundingClientRect().top
};
k.Ba = function (a, b, c) {
    var e = window.XMLHttpRequest && new XMLHttpRequest || new ActiveXObject("Microsoft.XMLHTTP");
    "GET" == a && c && (b += "?" + c);
    e.open(a, b, j);
    "POST" == a ? (e.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"), e.send(c)) : e.send();
    return e.responseText
};
k.Za = function (a, b) {
    var c, e;
    document.createEvent ? (c = document.createEvent("MouseEvents"), e = document.createElement("a"), e.download = b, e.href = a, c.initMouseEvent("click", d, d, window, 0, 0, 0, 0, 0, j, j, j, j, 0, f), e.dispatchEvent(c) || (location.href = a)) : location.href = a
};
k.Sb = function () {
    return window.innerHeight || documentElement.clientHeight || document.body.clientHeight
};
k.Tb = function () {
    return window.innerWidth || documentElement.clientWidth || document.body.clientWidth
};
k.lb = function () {
    var a = document.body.scrollHeight;
    document.body.clientHeight > a && (a = document.body.clientHeight);
    document.body.offsetHeight > a && (a = document.body.offsetHeight);
    document.body.scrollHeight > a && (a = document.body.scrollHeight);
    document.documentElement.clientHeight > a && (a = document.documentElement.clientHeight);
    document.documentElement.offsetHeight > a && (a = document.documentElement.offsetHeight);
    document.documentElement.scrollHeight > a && (a = document.documentElement.scrollHeight);
    return a
};
k.mb = function () {
    var a = document.body.scrollWidth;
    document.body.clientWidth > a && (a = document.body.clientWidth);
    document.body.offsetWidth > a && (a = document.body.offsetWidth);
    document.body.scrollWidth > a && (a = document.body.scrollWidth);
    document.documentElement.clientWidth > a && (a = document.documentElement.clientWidth);
    document.documentElement.offsetWidth > a && (a = document.documentElement.offsetWidth);
    document.documentElement.scrollWidth > a && (a = document.documentElement.scrollWidth);
    return a
};
k.offsetHeight = function () {
    return window.pageYOffset || document.body.scrollTop
};
k.offsetWidth = function () {
    return window.pageXOffset || document.body.scrollLeft
};
k.Ab = function (a) {
    var b = document.createElement("link");
    b.rel = "stylesheet";
    b.type = "text/css";
    b.href = a;
    document.getElementsByTagName("head")[0].appendChild(b)
};
k.cb = function (a) {
    var b = document.createElement("style");
    b.type = "text/css";
    b.innerHTML = a;
    document.getElementsByTagName("head")[0].appendChild(b)
};
k.Bb = function (a, b) {
    var c = document.createElement("script"),
        e = this;
    this.ta++;
    c.type = "text/javascript";
    c.src = a;
    c.onload = function () {
        e.T(b)
    };
    document.getElementsByTagName("head")[0].appendChild(c)
};
k.Va = function (a) {
    var b = document.createElement("script");
    a = this.Ba("GET", a);
    b.type = "text/javascript";
    b.innerHTML = a;
    document.getElementsByTagName("head")[0].appendChild(b)
};
k.D = function (a) {
    !window.La && !this.r[a] && (a = a.match(/^eju.([\.\w]+)$/)[1], a = a.replace(/\./g, "/"), this.Va(this.U + a + ".js"))
};
k.addListener(window, "load", function () {
    k.T()
});
"use strict";
k.r["eju.util.WaveFile"] = d;
k.b.F = function (a) {
    l(this, 8E3, 8);
    this.data = [];
    this.file = [];
    if (a)
        for (var b in a) this[b] = a[b]
};

function l(a, b, c) {
    a.q = b;
    a.n = c;
    a.aa = 1;
    a.Ya = Math.pow(2, a.n) / 2 - 1
}

function q(a, b, c, e) {
    var g;
    if (isNaN(e))
        for (g = 0; g < c; g++) a.file[b + g] = e.length < g ? String.fromCharCode(0) : e.charCodeAt(g);
    else
        for (g = 0; g < c; g++) a.file[b + g] = (e & 255 << 8 * g) >> 8 * g
}
k.b.F.prototype.w = function () {
    var a = this.data,
        b = a.length,
        c, e;
    this.file = [];
    q(this, 0, 4, "RIFF");
    q(this, 4, 4, b + 36);
    q(this, 8, 4, "WAVE");
    q(this, 12, 4, "fmt ");
    q(this, 16, 4, 16);
    q(this, 20, 2, 1);
    q(this, 22, 2, this.aa);
    q(this, 24, 4, this.q);
    q(this, 28, 4, this.q * this.aa * this.n / 8);
    q(this, 32, 2, this.aa * this.n / 8);
    q(this, 34, 2, this.n);
    q(this, 36, 4, "data");
    q(this, 40, 4, b);
    c = this.file;
    for (e = 0; e < b; e++) c[44 + e] = a[e];
    b = "";
    c = this.file;
    e = c.length;
    if (window.btoa) {
        for (a = 0; a < e; a++) b += String.fromCharCode(c[a]);
        a = "data:audio/wav;base64," + btoa(b)
    } else {
        for (a =
            0; a < e; a += 3) {
            b += "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt((c[a] & 252) >> 2);
            if (a + 1 < e) b += "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt((c[a] & 3) << 4 | (c[a + 1] & 240) >> 4);
            else {
                b += "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt((c[a] & 3) << 4) + "==";
                break
            } if (a + 2 < e) b += "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt((c[a + 1] & 15) << 2 | (c[a + 2] & 192) >> 6), b += "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(c[a +
                2] & 63);
            else {
                b += "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt((c[a + 1] & 15) << 2) + "=";
                break
            }
        }
        a = "data:audio/wav;base64," + b
    }
    return a
};
k.b.F.prototype.N = function () {
    var a = document.createElement("audio");
    a.src = this.w();
    a.load();
    return a
};
k.b.F.prototype.play = function () {
    var a = this.N();
    a.play();
    return a
};
"use strict";
k.r["eju.util.SFDesigner"] = d;
k.D("eju.ui");
k.D("eju.util.sfMaker");
k.D("eju.util.HTML");
k.b.S = function (a, b) {
    var c;
    this.parentNode = a || document.body;
    this.Ma = d;
    this.J = j;
    if (b)
        for (c in b) this[c] = b[c];
    this.a = {};
    this.qa = {};
    this.history = [];
    this.Ra = 100;
    this.u = d;
    this.ia = f;
    this.images = {};
    this.Sa = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAwAAAAQCAYAAAAiYZ4HAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9wGCAAXB3g7uo4AAAAZdEVYdENvbW1lbnQAQ3JlYXRlZCB3aXRoIEdJTVBXgQ4XAAAAXklEQVQoz2NkQAIXL178z4AF6OvrM8LYjIQUo2tiJEYxsiYMDcjWYzOMEZ9ibJqYGEgEJGtg7O3t/U+xDf39/Qz9/f3EaUBWiE0T5Z4uLCzEyqaeDYT8wILPSVSJOAA4YyuuOhKc5AAAAABJRU5ErkJggg==";
    this.na = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAwAAAAQCAYAAAAiYZ4HAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9wGCAAcJDmoEjcAAAAZdEVYdENvbW1lbnQAQ3JlYXRlZCB3aXRoIEdJTVBXgQ4XAAAAf0lEQVQoz62QQQqAMAwE01LwAT4kz/Lch5QcevJZ+58KXlSCxjaCewplJ9ltICUACxli5vWcw8h8h4LHrKFUa53fzt+XAVh0pMTMzdqsoajeN0+sBGAionb0aSMglFJcha1Il0SERMQHaKMFRfqoB5BzNuf/Low6pF4k97f2tAOqCTEns9V6JAAAAABJRU5ErkJggg==";
    this.G = document.createElement("audio");
    this.I = "Sine";
    this.s = {};
    setTimeout(function () {
            var a =
                document.createElement("input");
            a.type = "range";
            "range" != a.type && alert("NOTICE: Your browser does not support range inputs.  For the best user experience please use a browser that does, such as Chrome or Safari.  While some functionality will work, the user experience will be poor.   Also, range constraints will not work which will make sounds (such as various noise sounds) generate incorrectly.  Google Chrome is the recommended browser for SFDesigner.   The SFDesigner utility does require range inputs, but the SFMaker library will properly generate sounds in most browsers.")
        },
        0);
    this.B = document.createElement("table");
    this.B.className = "SFDesigner";
    var e;
    this.C = this.B.insertRow(0);
    this.C.className = "titleRow";
    c = this.C.insertCell(-1);
    c.innerHTML = "Leshy SFDesigner";
    c.colSpan = 3;
    e = this.B.insertRow(1);
    e.className = "titleRow2";
    c = e.insertCell(-1);
    c.innerHTML = "Presets";
    c = e.insertCell(-1);
    c.innerHTML = "Settings";
    c = e.insertCell(-1);
    c.innerHTML = "Controls";
    this.C = this.B.insertRow(2);
    var g = this;
    this.j = this.C.insertCell(-1);
    this.j.className = "presetsSection";
    r(this.j, "Blip", function () {
        s(g)
    }, {
        k: d,
        width: "100px",
        title: "shortcut: ALT+B"
    });
    r(this.j, "Chirp", function () {
        u(g)
    }, {
        k: d,
        width: "100px",
        title: "shortcut: ALT+C"
    });
    r(this.j, "Jump", function () {
        w(g)
    }, {
        k: d,
        width: "100px",
        title: "shortcut: ALT+J"
    });
    r(this.j, "Loss", function () {
        y(g)
    }, {
        k: d,
        width: "100px",
        title: "shortcut: ALT+L"
    });
    r(this.j, "Pickup", function () {
        z(g)
    }, {
        k: d,
        width: "100px",
        title: "shortcut: ALT+P"
    });
    r(this.j, "Power Up", function () {
        A(g)
    }, {
        k: d,
        width: "100px",
        title: "shortcut: ALT+U"
    });
    r(this.j, "Hit", function () {
        B(g)
    }, {
        k: d,
        width: "100px",
        title: "shortcut: ALT+H"
    });
    r(this.j, "Zap", function () {
        C(g)
    }, {
        k: d,
        width: "100px",
        title: "shortcut: ALT+Z"
    });
    r(this.j, "Explosion", function () {
        D(g)
    }, {
        k: d,
        width: "100px",
        title: "shortcut: ALT+E"
    });
    r(this.j, "Noise", function () {
        E(g)
    }, {
        k: d,
        width: "100px",
        title: "shortcut: ALT+N"
    });
    this.j.appendChild(document.createElement("hr"));
    r(this.j, "Random", function () {
        F(g)
    }, {
        k: d,
        width: "100px",
        title: "shortcut: ALT+R"
    });
    r(this.j, "Mutate", function () {
        G(g)
    }, {
        k: d,
        width: "100px",
        title: "shortcut: ALT+M"
    });
    var h = this;
    this.c = this.C.insertCell(-1);
    this.c.className =
        "parametersSection";
    H(this, this.c, {
        type: "inputBox",
        name: "song",
        label: "Song",
        size: 56
    });
    H(this, this.c, {
        type: "radio",
        name: "waveType",
        label: "Wave Type",
        options: ["Sine", "Square", "Sawtooth", "Noise", "Foo"],
        ra: function () {
            I(h)
        }
    });
    H(this, this.c, {
        type: "radio",
        name: "sampleRate",
        label: "Sample Rate",
        options: ["8000", "11025", "22050", "44100", "48000"]
    });
    H(this, this.c, {
        type: "range",
        name: "frequency",
        label: "Start Frequency",
        f: [50, 1E4]
    });
    H(this, this.c, {
        type: "range",
        name: "vibratoFrequency",
        label: "Vibrato Frequency",
        f: [0,
            250
        ]
    });
    H(this, this.c, {
        type: "range",
        name: "vibratoDepth",
        label: "Vibrato Depth",
        f: [0, 1E3]
    });
    H(this, this.c, {
        type: "range",
        name: "tremeloFrequency",
        label: "Tremelo Frequency",
        f: [0, 250]
    });
    H(this, this.c, {
        type: "range",
        name: "tremeloDepth",
        label: "Tremelo Depth",
        f: [0, 1]
    });
    H(this, this.c, {
        type: "range",
        name: "duty",
        label: "Square/Saw Duty",
        f: [-0.9, 0.9]
    });
    H(this, this.c, {
        type: "range",
        name: "dutySweepFrequency",
        label: "Duty Sweep Frequency",
        f: [0, 300]
    });
    H(this, this.c, {
        type: "range",
        name: "dutySweepDepth",
        label: "Duty Sweep Depth",
        f: [0.1, 0.9]
    });
    this.c.appendChild(document.createElement("hr"));
    c = this.c;
    H(this, c, {
        type: "range",
        name: "peak",
        label: "Peak",
        f: [1, 2]
    });
    H(this, c, {
        type: "range",
        name: "attack",
        label: "A",
        f: [0, 3],
        step: 0.1,
        z: d
    });
    H(this, c, {
        type: "range",
        name: "decay",
        label: "D",
        f: [0, 3],
        step: 0.1,
        z: d
    });
    this.c.appendChild(document.createElement("br"));
    H(this, c, {
        type: "range",
        name: "sustain",
        label: "S",
        f: [0, 3],
        step: 0.1,
        z: d
    });
    H(this, c, {
        type: "range",
        name: "release",
        label: "R",
        f: [0, 3],
        step: 0.1,
        z: d
    });
    this.c.appendChild(document.createElement("hr"));
    H(this, this.c, {
        type: "range",
        name: "frequencyChange",
        label: "Frequency Change",
        f: [-5E3, 5E3],
        step: 1
    });
    H(this, this.c, {
        type: "range",
        name: "frequencyChangeTime",
        label: "Frequency Change Time",
        f: [0, 100]
    });
    this.c.appendChild(document.createElement("hr"));
    H(this, this.c, {
        type: "range",
        name: "steps",
        label: "Steps",
        f: [1, 1E3],
        step: 1
    });
    H(this, this.c, {
        type: "range",
        name: "stepDelta",
        label: "Step Delta",
        f: [1, 500]
    });
    H(this, this.c, {
        type: "radio",
        name: "stepDirection",
        label: "Step Direction",
        options: ["Up", "Down"]
    });
    this.c.appendChild(document.createElement("hr"));
    H(this, this.c, {
        type: "range",
        name: "lowPassAlpha",
        label: "Low Pass Alpha",
        f: [0, 0.999]
    });
    this.c.appendChild(document.createElement("hr"));
    H(this, this.c, {
        type: "range",
        name: "length",
        label: "Length",
        f: [0.01, 5]
    });
    H(this, this.c, {
        type: "range",
        name: "volume",
        label: "Volume",
        f: [0.01, 2]
    });
    this.c.appendChild(document.createElement("hr"));
    H(this, this.c, {
        type: "radio",
        name: "noiseWaveType",
        label: "Noise Wave Type",
        options: ["Sine", "Square", "Sawtooth", "Foo"],
        mode: "Noise"
    });
    H(this, this.c, {
        type: "range",
        name: "noiseChangeTime",
        label: "Noise Change Time",
        f: [1, 2E3],
        step: 1,
        mode: "Noise"
    });
    H(this, this.c, {
        type: "range",
        name: "noiseChangeRange",
        label: "Noise Change Range",
        f: [2, 5E3],
        mode: "Noise"
    });
    H(this, this.c, {
        type: "radio",
        name: "noiseChangeStyle",
        label: "Noise Change Style",
        options: ["Fixed", "Random"],
        mode: "Noise"
    });
    H(this, this.c, {
        type: "range",
        name: "randomSeed",
        label: "Random Seed",
        f: [0, 65536],
        step: 1,
        mode: "Noise"
    });
    H(this, this.c, {
        type: "radio",
        name: "noiseNoteReset",
        label: "Reset Seed for Notes",
        options: ["Off", "On"],
        mode: "Noise"
    });
    var m =
        this;
    this.e = this.C.insertCell(-1);
    this.e.className = "saveSection";
    r(this.e, "Play", function () {
        m.play()
    }, {
        title: "shortcut: SPACE BAR"
    });
    r(this.e, "Stop", function () {
        m.G.pause()
    });
    c = this.e;
    this.H = document.createElement("span");
    this.H.className = "clipSpan";
    this.H.innerHTML = "CLIP";
    this.H.style.display = "none";
    c.appendChild(this.H);
    this.e.appendChild(document.createElement("br"));
    var p = this;
    c = this.e;
    var t = document.createElement("input");
    t.type = "checkbox";
    t.checked = d;
    t.onchange = function () {
        p.u = t.checked
    };
    c.appendChild(document.createTextNode("Auto Play: "));
    c.appendChild(t);
    this.e.appendChild(document.createElement("hr"));
    this.e.appendChild(document.createTextNode("Sound Text"));
    this.fa = document.createElement("span");
    this.e.appendChild(this.fa);
    this.e.appendChild(document.createElement("br"));
    var x = this;
    c = this.e;
    e = document.createElement("textarea");
    e.rows = 15;
    e.id = "soundText";
    e.style.width = "99%";
    e.onfocus = function () {
        x.J = d
    };
    e.onblur = function () {
        x.J = j
    };
    c.appendChild(e);
    this.A = e;
    r(this.e, "Load Text", function () {
        J(m)
    });
    this.e.appendChild(document.createElement("br"));
    this.wa = r(this.e, "Previous Sound", function () {
        K(m)
    }, {
        title: "shortcut: CTRL+P",
        disabled: d
    });
    this.e.appendChild(document.createElement("hr"));
    r(this.e, "Reset All Parameters", function () {
        L(m)
    }, {
        title: "shortcut: CTRL+Z"
    });
    this.e.appendChild(document.createElement("hr"));
    this.fileName = document.createElement("input");
    this.fileName.type = "text";
    this.fileName.value = "sound.wav";
    this.e.appendChild(document.createTextNode("File Name"));
    this.e.appendChild(document.createElement("br"));
    this.e.appendChild(this.fileName);
    r(this.e, "Save Wave", function () {
        M(m)
    }, {
        title: "shortcut: CTRL+S"
    });
    this.e.appendChild(document.createElement("hr"));
    this.e.appendChild(document.createTextNode("Create a Link to this Sound"));
    this.e.appendChild(document.createElement("br"));
    r(this.e, "Share", function () {
        var a;
        a = N(m);
        a = k.b.d.ka(a);
        var b = document.location.href.replace(/[\?\#].*$/, "");
        a && (b += "?sound=" + encodeURIComponent(a));
        a = b;
        var b = k.b.g,
            c = [document.createElement("span"), document.createElement("span"), document.createElement("span"), document.createElement("span"),
                document.createElement("span"), document.createElement("span")
            ];
        k.a.W(b.ja({
            style: {
                fontSize: "16px",
                textAlign: "center"
            }
        }, b.Ha([b.text("Share a link directly to this sound:"), b.V(), b.ja({
            style: {
                height: "12px"
            }
        }, " "), b.Ea({
            href: a
        }), b.V(), b.V(), c[0], c[1], c[2], c[3], c[4], c[5]])), 400, 200, j, {
            title: "Link to this Sound",
            keys: m.keys
        });
        O(c[0], "facebook", a);
        O(c[1], "twitter", a);
        O(c[2], "googleplus", a);
        O(c[3], "reddit", a);
        O(c[4], "pinterest", a);
        O(c[5], "sharethis", a);
        k.Q(window.event)
    });
    var n = this;
    this.Ma && document.addEventListener("keydown",
        function (a) {
            a: {
                var b = a.keyCode || a.which || a.charCode;
                if (32 == b && !n.J) n.play();
                else if (83 == b && a.ctrlKey) M(n);
                else if (90 == b && a.ctrlKey) L(n);
                else if (80 == b && a.ctrlKey) K(n);
                else if (!a.ctrlKey && a.altKey)
                    if (66 == b && s(n), 67 == b) u(n);
                    else if (74 == b) w(n);
                else if (76 == b) y(n);
                else if (80 == b) z(n);
                else if (85 == b) A(n);
                else if (72 == b) B(n);
                else if (90 == b) C(n);
                else if (69 == b) D(n);
                else if (78 == b) E(n);
                else if (82 == b) F(n);
                else if (77 == b) G(n);
                else {
                    a = void 0;
                    break a
                } else {
                    a = void 0;
                    break a
                }
                a = n.Q(a)
            }
            return a
        }, j);
    for (var v in this.s)
        if (v !=
            this.I) {
            c = this.s[v];
            for (e = 0; e < c.length; e++) P(c[e])
        }
    v = k.Qa();
    void 0 !== v.sound && v.sound && J(this, d, decodeURIComponent(v.sound), d);
    this.parentNode.appendChild(this.B)
};

function P(a) {
    "SPAN" == a.tagName ? a.style.color = "gray" : a.disabled = d
}
k.b.S.prototype.Q = function (a) {
    a = a || window.event;
    a.cancelBubble = d;
    a.returnValue = j;
    a.stopPropagation && a.stopPropagation();
    a.preventDefault && a.preventDefault();
    return j
};

function I(a) {
    var b, c;
    if (c = a.s[a.I])
        for (b = 0; b < c.length; b++) P(c[b]);
    a.I = Q(a.a.waveType);
    if (c = a.s[a.I])
        for (b = 0; b < c.length; b++) a = c[b], "SPAN" == a.tagName ? a.style.color = "black" : a.disabled = j
}

function L(a) {
    var b, c;
    for (b in a.a)
        if (a.a[b].constructor == Array) {
            var e;
            for (e = 0; e < a.a[b].length; e++) c = a.a[b][e], c.checked = c.value == k.b.d.l[b].defaultValue ? d : j, "true" == c.getAttribute("locked") && R(a, c)
        } else if (c = a.a[b], c.value = k.b.d.l[b].defaultValue, "true" == c.getAttribute("locked") && R(a, c), c.onchange) c.onchange()
}

function O(a, b, c) {
    window.stWidget && window.stWidget.addEntry({
        service: b,
        element: a,
        url: c,
        title: "Leshy SFMaker",
        type: "large",
        text: b,
        image: "http://www.leshylabs.com/images/apps/sfmaker.png"
    })
}

function M(a) {
    k.Za(k.b.d.h.w(), a.fileName.value || "wave.wav")
}

function S(a) {
    a.u && (a.M && clearTimeout(a.M), a.ia = Date.now() + 100, a.M = setTimeout(function () {
        a.play()
    }, 100))
}
k.b.S.prototype.play = function (a) {
    var b = N(this);
    this.M && (this.ia = f, clearTimeout(this.M));
    T(this, b, a);
    k.b.d.Y(b);
    this.H.style.display = k.b.d.clip ? "" : "none";
    this.G.pause();
    this.G.src = k.b.d.h.w();
    this.G.load();
    this.G.play()
};

function U(a, b) {
    if ("true" != a[a.length - 1].getAttribute("locked") && (b ? a[b[Math.floor(Math.random() * b.length)]].checked = d : a[Math.floor(Math.random() * a.length)].checked = d, a[0] && a[0].onchange)) a[0].onchange()
}

function V(a, b, c) {
    b = "number" == typeof b ? b : a.min;
    c = "number" == typeof c ? c : a.max;
    "true" != a.getAttribute("locked") && (a.value = Math.random() * (c - b) + b, a.onchange())
}

function W(a) {
    var b = 0.02 * (a.max - a.min),
        b = Math.random() * b - b / 2;
    "true" != a.getAttribute("locked") && (a.value = parseFloat(a.value) + b, a.onchange())
}

function G(a) {
    W(a.a.frequency);
    W(a.a.vibratoFrequency);
    W(a.a.vibratoDepth);
    W(a.a.tremeloFrequency);
    W(a.a.tremeloDepth);
    W(a.a.peak);
    W(a.a.attack);
    W(a.a.decay);
    W(a.a.sustain);
    W(a.a.release);
    W(a.a.steps);
    W(a.a.stepDelta);
    W(a.a.lowPassAlpha);
    W(a.a.duty);
    W(a.a.dutySweepFrequency);
    W(a.a.dutySweepDepth);
    W(a.a.frequencyChange);
    W(a.a.frequencyChangeTime);
    W(a.a.noiseChangeTime);
    W(a.a.noiseChangeRange);
    W(a.a.randomSeed);
    a.play()
}

function F(a) {
    U(a.a.waveType);
    U(a.a.sampleRate, [0, 1, 2, 3]);
    V(a.a.frequency, 100, 4E3);
    V(a.a.vibratoFrequency, 0, 250);
    V(a.a.vibratoDepth, 0, 1E3);
    V(a.a.tremeloFrequency);
    V(a.a.tremeloDepth, 0, 0.42);
    V(a.a.peak, 1, 1.8);
    V(a.a.attack);
    V(a.a.decay);
    V(a.a.sustain);
    V(a.a.release);
    V(a.a.steps, 1, 100);
    V(a.a.stepDelta);
    U(a.a.stepDirection);
    V(a.a.lowPassAlpha, 0, 0.9);
    V(a.a.duty, -0.25, 0.25);
    V(a.a.dutySweepFrequency);
    V(a.a.dutySweepDepth, 0.1, 0.3);
    V(a.a.frequencyChange);
    V(a.a.frequencyChangeTime);
    U(a.a.noiseWaveType);
    V(a.a.noiseChangeTime);
    W(a.a.noiseChangeRange);
    U(a.a.noiseChangeStyle);
    V(a.a.randomSeed);
    U(a.a.noiseNoteReset);
    a.a.song.value ? (V(a.a.length, 0.3, 0.4), V(a.a.vibratoFrequency, 0, 250), V(a.a.vibratoDepth, 0, 20), V(a.a.tremeloFrequency, 0, 10), V(a.a.tremeloDepth, 0, 0.6)) : V(a.a.length, 0.5, f);
    a.play()
}

function s(a) {
    U(a.a.waveType, [0, 1, 2]);
    U(a.a.sampleRate, [0, 1, 2, 3]);
    V(a.a.frequency, 600, 4E3);
    V(a.a.vibratoFrequency, f, 250);
    V(a.a.vibratoDepth, 0, 3);
    V(a.a.tremeloFrequency, f, 3);
    V(a.a.tremeloDepth, f, 0.25);
    V(a.a.peak, 1, 1.8);
    V(a.a.attack);
    V(a.a.decay);
    V(a.a.sustain, 2, 4);
    V(a.a.release);
    V(a.a.steps, 1, 1);
    V(a.a.lowPassAlpha, 0, 0.8);
    V(a.a.duty, -0.25, 0.25);
    V(a.a.dutySweepFrequency);
    V(a.a.dutySweepDepth, 0.1, 0.3);
    V(a.a.frequencyChange);
    V(a.a.frequencyChangeTime);
    a.a.song.value ? V(a.a.length, 0.3, 0.4) : V(a.a.length,
        0.2, 0.4);
    a.play()
}

function u(a) {
    U(a.a.waveType, [3]);
    U(a.a.sampleRate, [0, 1, 2, 3]);
    V(a.a.frequency, 50, 3E3);
    V(a.a.vibratoFrequency, 0, 250);
    V(a.a.vibratoDepth, 0, 1E3);
    V(a.a.tremeloFrequency);
    V(a.a.tremeloDepth, 0, 0.42);
    V(a.a.peak, 1, 1.8);
    V(a.a.attack);
    V(a.a.decay);
    V(a.a.sustain);
    V(a.a.release);
    V(a.a.steps, 1, 50);
    V(a.a.stepDelta, 1, 5);
    U(a.a.stepDirection);
    V(a.a.lowPassAlpha, 0, 0.8);
    V(a.a.duty, -0.25, 0.25);
    V(a.a.dutySweepFrequency);
    V(a.a.dutySweepDepth, 0.1, 0.3);
    V(a.a.frequencyChange);
    V(a.a.frequencyChangeTime);
    U(a.a.noiseWaveType);
    V(a.a.noiseChangeTime);
    W(a.a.noiseChangeRange);
    U(a.a.noiseChangeStyle);
    V(a.a.randomSeed);
    U(a.a.noiseNoteReset);
    a.a.song.value ? (V(a.a.length, 0.1, 0.3), V(a.a.vibratoFrequency, 0, 250), V(a.a.vibratoDepth, 0, 1E3), V(a.a.tremeloFrequency, 0, 10), V(a.a.tremeloDepth, 0, 0.6)) : V(a.a.length, 0.1, 0.3);
    a.play()
}

function w(a) {
    U(a.a.waveType, [0, 1]);
    U(a.a.sampleRate, [0, 1, 2, 3]);
    V(a.a.frequency, 100, 2E3);
    V(a.a.vibratoFrequency, 0, 250);
    V(a.a.vibratoDepth, 0, 20);
    V(a.a.tremeloFrequency, f, 2);
    V(a.a.tremeloDepth, f, 0.15);
    V(a.a.peak, 1, 1.8);
    V(a.a.attack, 0, 0);
    V(a.a.decay, 0, 0);
    V(a.a.sustain, 3, 0.2);
    V(a.a.release, 0.3, 0.8);
    V(a.a.steps, 30, 150);
    V(a.a.stepDelta, 1, 40);
    U(a.a.stepDirection, [0]);
    V(a.a.lowPassAlpha, 0, 0.8);
    V(a.a.duty, -0.2, 0.2);
    V(a.a.dutySweepFrequency);
    V(a.a.dutySweepDepth, 0.1, 0.35);
    V(a.a.frequencyChange, 0, 0);
    a.a.song.value ?
        V(a.a.length, 0.3, 0.4) : V(a.a.length, 0.3, 0.5);
    a.play()
}

function y(a) {
    U(a.a.waveType, [0, 1]);
    U(a.a.sampleRate, [0, 1, 2, 3]);
    V(a.a.frequency, 100, 2E3);
    V(a.a.vibratoFrequency, 0, 250);
    V(a.a.vibratoDepth, 0, 20);
    V(a.a.tremeloFrequency, f, 2);
    V(a.a.tremeloDepth, f, 0.15);
    V(a.a.peak, 1, 1.8);
    V(a.a.attack, 0, 0);
    V(a.a.decay, 0, 0);
    V(a.a.sustain, 3, 0.2);
    V(a.a.release, 0.3, 0.8);
    V(a.a.steps, 30, 150);
    V(a.a.stepDelta, 1, a.a.frequency.value / a.a.steps.value);
    U(a.a.stepDirection, [1]);
    V(a.a.lowPassAlpha, 0, 0.8);
    V(a.a.duty, -0.2, 0.2);
    V(a.a.dutySweepFrequency);
    V(a.a.dutySweepDepth, 0.1, 0.35);
    V(a.a.frequencyChange,
        0, 0);
    a.a.song.value ? V(a.a.length, 0.3, 0.4) : V(a.a.length, 0.3, 0.5);
    a.play()
}

function A(a) {
    U(a.a.waveType, [0, 1, 2, 4]);
    U(a.a.sampleRate, [0, 1, 2, 3]);
    V(a.a.frequency, 100, 4E3);
    V(a.a.vibratoFrequency, 0, 250);
    V(a.a.vibratoDepth, 0, 20);
    V(a.a.tremeloFrequency, f, 50);
    V(a.a.tremeloDepth, f, 0.3);
    V(a.a.peak, 1, 1.8);
    V(a.a.attack);
    V(a.a.decay);
    V(a.a.sustain);
    V(a.a.release);
    V(a.a.steps, 5, 100);
    V(a.a.stepDelta, 0, 250);
    U(a.a.stepDirection, [0]);
    V(a.a.lowPassAlpha, 0, 0.8);
    V(a.a.duty, -0.25, 0.25);
    V(a.a.dutySweepFrequency);
    V(a.a.dutySweepDepth, 0.1, 0.3);
    V(a.a.frequencyChange);
    V(a.a.frequencyChangeTime);
    a.a.song.value ?
        V(a.a.length, 0.1, 0.4) : V(a.a.length, 0.2, 0.9);
    a.play()
}

function z(a) {
    U(a.a.waveType, [0, 1, 2, 4]);
    U(a.a.sampleRate, [0, 1, 2, 3]);
    V(a.a.frequency, 900, 4E3);
    V(a.a.vibratoFrequency, 0, 250);
    V(a.a.vibratoDepth, 0, 50);
    V(a.a.tremeloFrequency);
    V(a.a.tremeloDepth, f, 0.5);
    V(a.a.peak, 1, 1.8);
    V(a.a.attack, 0, 0.2);
    V(a.a.decay, 0, 0.2);
    V(a.a.sustain, 0.2, 0.4);
    V(a.a.release, 0.3, 0.5);
    V(a.a.steps, 1, 1);
    V(a.a.lowPassAlpha, 0, 0.8);
    V(a.a.duty, -0.15, 0.15);
    V(a.a.dutySweepFrequency, f, 150);
    V(a.a.dutySweepDepth, 0.1, 0.3);
    V(a.a.frequencyChange, -300, -500);
    V(a.a.frequencyChangeTime, 10, 60);
    a.a.song.value ?
        V(a.a.length, 0.3, 0.4) : V(a.a.length, 0.3, 0.7);
    a.play()
}

function B(a) {
    U(a.a.waveType, [3]);
    U(a.a.sampleRate, [0, 1, 2, 3]);
    V(a.a.frequency, 50, 150);
    V(a.a.vibratoFrequency, 0, 250);
    V(a.a.vibratoDepth, 0, 30);
    V(a.a.tremeloFrequency);
    V(a.a.tremeloDepth, f, 0.6);
    V(a.a.peak, 1, 2);
    V(a.a.attack, 0, 0);
    V(a.a.decay, 0, 0.3);
    V(a.a.sustain, 0, 0.2);
    V(a.a.release, 0.1, 0.6);
    V(a.a.steps, 1, 20);
    V(a.a.stepDelta, 1, 10);
    U(a.a.stepDirection);
    V(a.a.lowPassAlpha, 0, 0.9);
    V(a.a.duty, -0.25, 0.25);
    V(a.a.dutySweepFrequency);
    V(a.a.dutySweepDepth, 0.1, 0.3);
    V(a.a.frequencyChange);
    V(a.a.frequencyChangeTime);
    U(a.a.noiseWaveType);
    V(a.a.noiseChangeTime, 1, 35);
    W(a.a.noiseChangeRange);
    U(a.a.noiseChangeStyle);
    V(a.a.randomSeed);
    U(a.a.noiseNoteReset);
    a.a.song.value ? V(a.a.length, 0.3, 0.4) : V(a.a.length, 0.38, 0.5);
    a.play()
}

function C(a) {
    U(a.a.waveType, [1]);
    U(a.a.sampleRate, [0, 1, 2, 3]);
    V(a.a.frequency, 100, 4E3);
    V(a.a.vibratoFrequency, 0, 0);
    V(a.a.vibratoDepth, 0, 30);
    V(a.a.tremeloFrequency);
    V(a.a.tremeloDepth, f, 0.6);
    V(a.a.peak, 1, 1.8);
    V(a.a.attack, 0, 0);
    V(a.a.decay, 0, 0);
    V(a.a.sustain, 0, 0);
    V(a.a.release, 0.1, f);
    V(a.a.steps, 1, 200);
    V(a.a.stepDelta);
    U(a.a.stepDirection);
    V(a.a.lowPassAlpha, 0, 0.8);
    V(a.a.duty, -0.25, 0.25);
    V(a.a.dutySweepFrequency);
    V(a.a.dutySweepDepth, 0.1, 0.3);
    V(a.a.frequencyChange);
    V(a.a.frequencyChangeTime);
    a.a.song.value ?
        V(a.a.length, 0.3, 0.4) : V(a.a.length, 0.38, 0.5);
    a.play()
}

function D(a) {
    U(a.a.waveType, [3]);
    U(a.a.sampleRate, [0, 1, 2, 3]);
    V(a.a.frequency, 50, 150);
    V(a.a.vibratoFrequency, 0, 250);
    V(a.a.vibratoDepth, 0, 30);
    V(a.a.tremeloFrequency);
    V(a.a.tremeloDepth, f, 0.6);
    V(a.a.peak, 1, 2);
    V(a.a.attack, 0, 0.2);
    V(a.a.decay, 0, 0.3);
    V(a.a.sustain, 0, 0.2);
    V(a.a.release, 0.1, 0.6);
    V(a.a.steps, 1, 20);
    V(a.a.stepDelta, 1, 10);
    U(a.a.stepDirection);
    V(a.a.lowPassAlpha, 0, 0.9);
    V(a.a.duty, -0.25, 0.25);
    V(a.a.dutySweepFrequency);
    V(a.a.dutySweepDepth, 0.1, 0.3);
    V(a.a.frequencyChange);
    V(a.a.frequencyChangeTime);
    U(a.a.noiseWaveType);
    V(a.a.noiseChangeTime, 1, 66);
    W(a.a.noiseChangeRange);
    U(a.a.noiseChangeStyle);
    V(a.a.randomSeed);
    U(a.a.noiseNoteReset);
    a.a.song.value ? V(a.a.length, 0.3, 0.4) : V(a.a.length, 0.5, 1.4);
    a.play()
}

function E(a) {
    U(a.a.waveType, [3]);
    U(a.a.sampleRate, [0, 1, 2, 3]);
    V(a.a.frequency, 50, 3E3);
    V(a.a.vibratoFrequency, 0, 250);
    V(a.a.vibratoDepth, 0, 1E3);
    V(a.a.tremeloFrequency);
    V(a.a.tremeloDepth, 0, 0.42);
    V(a.a.peak, 1, 1.8);
    V(a.a.attack);
    V(a.a.decay);
    V(a.a.sustain);
    V(a.a.release);
    V(a.a.steps, 1, 50);
    V(a.a.stepDelta, 1, 5);
    U(a.a.stepDirection);
    V(a.a.lowPassAlpha, 0, 0.8);
    V(a.a.duty, -0.25, 0.25);
    V(a.a.dutySweepFrequency);
    V(a.a.dutySweepDepth, 0.1, 0.3);
    V(a.a.frequencyChange);
    V(a.a.frequencyChangeTime);
    U(a.a.noiseWaveType);
    V(a.a.noiseChangeTime);
    W(a.a.noiseChangeRange);
    U(a.a.noiseChangeStyle);
    V(a.a.randomSeed);
    U(a.a.noiseNoteReset);
    a.a.song.value ? (V(a.a.length, 0.3, 0.4), V(a.a.vibratoFrequency, 0, 250), V(a.a.vibratoDepth, 0, 1E3), V(a.a.tremeloFrequency, 0, 10), V(a.a.tremeloDepth, 0, 0.6)) : V(a.a.length, 0.5, f);
    a.play()
}

function r(a, b, c, e) {
    var g = document.createElement("input");
    g.type = "button";
    g.value = b;
    g.onclick = c;
    e && (e.k && a.appendChild(document.createElement("br")), e.width && (g.style.width = e.width), e.title && (g.title = e.title), e.disabled && (g.disabled = d));
    a.appendChild(g);
    return g
}

function X(a, b, c) {
    b && (a.s[b] ? a.s[b].push(c) : a.s[b] = [c])
}

function R(a, b) {
    var c = a.qa[b.name];
    "true" == b.getAttribute("locked") ? (b.setAttribute("locked", "false"), c.src = a.na) : (b.setAttribute("locked", "true"), c.src = a.Sa)
}

function Y(a, b) {
    var c = document.createElement("img");
    c.style.cursor = "pointer";
    c.src = a.na;
    b.setAttribute("locked", "false");
    a.qa[b.name] = c;
    c.onclick = function () {
        R(a, b)
    };
    return c
}

function H(a, b, c) {
    var e = document.createElement("span"),
        g = document.createElement("span"),
        h = document.createElement("br"),
        m;
    e.className = c.z ? "labelSmall" : "label";
    e.appendChild(document.createTextNode(c.label));
    switch (c.type) {
    case "inputBox":
        var p = document.createElement("input");
        p.type = "text";
        p.size = c.size || 16;
        p.value = k.b.d.l[c.name].defaultValue || "";
        p.Ua = d;
        a.a[c.name] = p;
        g.appendChild(p);
        p.onfocus = function () {
            a.J = d
        };
        p.onblur = function () {
            a.J = j
        };
        X(a, c.mode, p);
        m = p;
        break;
    case "radio":
        var t = 0,
            x;
        a.a[c.name] = [];
        for (x = 0; x < c.options.length; x++) c.options[x] === f ? (g.appendChild(document.createElement("br")), m = document.createElement("span"), m.className = "radioLabel", g.appendChild(m)) : (p = document.createElement("input"), p.type = "radio", p.name = "radio_" + c.name, p.value = c.options[x], p.onchange = function () {
            S(a);
            c.ra && c.ra()
        }, a.a[c.name][t] = p, t++, k.b.d.l[c.name].defaultValue == c.options[x] && (p.checked = d), g.appendChild(p), g.appendChild(document.createTextNode(c.options[x] + " ")), X(a, c.mode, p));
        a.a[c.name].defaultValue = c.value;
        m = p;
        break;
    case "range":
        var n = document.createElement("input"),
            v = document.createElement("input");
        n.type = "range";
        n.min = c.f[0];
        n.max = c.f[1];
        n.step = c.step || 0.001;
        n.value = k.b.d.l[c.name].defaultValue;
        n.name = c.name;
        n.defaultValue = c.value;
        n.onchange = function () {
            v.value = parseInt(1E3 * n.value) / 1E3;
            S(a)
        };
        v.size = 3.5;
        c.z ? (n.className = "rangeSmall", v.className = "rangeTextSmall") : (n.className = "range", v.className = "rangeText");
        v.value = n.value;
        v.onchange = function () {
            n.value = parseFloat(v.value);
            v.value = n.value;
            S(a)
        };
        a.a[c.name] =
            n;
        g.appendChild(v);
        g.appendChild(n);
        X(a, c.mode, v);
        X(a, c.mode, n);
        m = n
    }
    b.appendChild(e);
    "inputBox" != c.type && b.appendChild(Y(a, m));
    c.mode && X(a, c.mode, e);
    b.appendChild(g);
    c.z || b.appendChild(h)
}

function Q(a) {
    var b;
    for (b = 0; b < a.length; b++)
        if (a[b].checked) return a[b].value
}

function N(a) {
    var b, c = {};
    for (b in a.a) a.a[b].disabled || (c[b] = a.a[b].constructor == Array ? Q(a.a[b]) : "range" == a.a[b].type || "text" == a.a[b].type && !a.a[b].Ua ? parseFloat(a.a[b].value) : a.a[b].value);
    c.mode = c.song.match(/^\s*$/) ? "w" : "s";
    "s" == c.mode ? delete c.frequency : delete c.noiseNoteReset;
    "Noise" != c.waveType && (delete c.noiseWaveType, delete c.noiseChangeStyle);
    c.vibratoFrequency || delete c.vibratoDepth;
    c.vibratoDepth || delete c.vibratoFrequency;
    c.tremeloFrequency || delete c.tremeloDepth;
    c.tremeloDepth || delete c.tremeloFrequency;
    c.dutySweepFrequency || delete c.dutySweepDepth;
    c.frequencyChange || delete c.frequencyChangeTime;
    1 == c.steps && (delete c.stepDelta, delete c.stepDirection);
    return c
}

function J(a, b, c, e) {
    c = k.b.d.Z(c || a.A.value);
    var g = a.u,
        h;
    e && a.u && (a.u = j);
    for (h in c) {
        var m = h,
            p = c[h];
        if (a.a[m])
            if (a.a[m].constructor == Array)
                for (h = 0; h < a.a[m].length; h++) a.a[m][h].checked = a.a[m][h].value == p ? d : j;
            else if (a.a[m].value = p, a.a[m].onchange) a.a[m].onchange()
    }
    I(a);
    a.u = g;
    e ? T(a, c) : a.play(b)
}

function K(a) {
    a.history.length && (a.A.value = a.history.pop(), J(a, d), 0 == a.history.length && (a.wa.disabled = d))
}

function T(a, b, c) {
    a.A.value = k.b.d.ka(b);
    a.fa.innerHTML = " (" + a.A.value.length + " bytes)";
    if (!c && (0 == a.history.length || a.history[a.history.length - 1] != a.A.value)) a.history.push(a.A.value), a.history.length > a.Ra && a.history.splice(0, 1), a.wa.disabled = j
}
"use strict";
k.r["eju.ui"] = d;
k.a.Na = function () {
    var a = document.createElement("div");
    a.id = "eju_overlay";
    a.style.position = "fixed";
    a.style.top = 0;
    a.style.left = 0;
    a.style.height = "100%";
    a.style.width = "100%";
    a.style.zIndex = 1E6;
    a.style.opacity = 0.5;
    a.style.backgroundColor = "black";
    a.style.filter = "alpha(Opacity=50)";
    document.body.appendChild(a)
};
k.a.Ja = function () {
    var a = document.getElementById("eju_overlay");
    a && a.parentNode.removeChild(a)
};
k.a.W = function (a, b, c, e, g) {
    var h = document.createElement("div"),
        m = document.createElement("div"),
        p = document.createElement("div"),
        t = document.createElement("input"),
        x;
    g = g || {};
    k.a.ga();
    b = b || 320;
    c = c || 200;
    h.style.position = "absolute";
    h.style.height = c + "px";
    h.style.width = b + "px";
    h.style.backgroundColor = g.backgroundColor || "#c4c4c4";
    h.style.overflow = "hidden";
    h.style.zIndex = 1000001;
    h.id = "eju_dialog";
    h.style.top = (window.innerHeight - c) / 2 + k.offsetHeight() + "px";
    h.style.left = (window.innerWidth - b) / 2 + k.offsetWidth() + "px";
    m.innerHTML = g.title || "Notification";
    m.style.textAlign = "center";
    m.style.color = "#ffffff";
    m.style.backgroundColor = "#5669c9";
    m.style.borderTop = "1px solid #7582c1";
    m.style.borderRight = "1px solid #7582c1";
    m.style.width = "100%";
    m.style.overflow = "hidden";
    m.style.Cb = "none";
    m.style.webkitUserSelect = "none";
    "string" == typeof a ? p.innerHTML = a : p.appendChild(a);
    p.style.overflow = "auto";
    p.id = "eju_dialogContent";
    p.style.height = c - 60 + "px";
    p.style.marginLeft = "5px";
    h.appendChild(m);
    h.appendChild(p);
    e || (t.type = "button", t.style.display =
        "block", t.style.marginLeft = "auto", t.style.marginRight = "auto", t.value = "Close", t.onclick = function () {
            k.a.ga();
            g.keys && g.keys.$a(x)
        }, h.appendChild(t), g.keys && (x = g.keys.I, g.keys.Db("_dialog_"), g.keys.$a("_dialog_")));
    k.a.Na();
    document.body.appendChild(h);
    return h
};
k.a.kb = function (a, b, c, e, g, h) {
    e = k.a.W("Please wait...", e, g, h, c);
    a = k.Ba(a, b, c);
    document.getElementById("eju_dialogContent").innerHTML = a;
    return e
};
k.a.jb = function (a, b, c, e, g) {
    var h = document.createElement("iframe");
    h.src = a;
    h.width = c - 4;
    h.height = e - 80;
    h.style.overflow = "hidden";
    return k.a.W(h, c, e, g, b)
};
k.a.ga = function () {
    var a = document.getElementById("eju_dialog");
    a && (a.parentNode.removeChild(a), k.a.Ja())
};
"use strict";
k.r["eju.util.sfMaker"] = d;
k.D("eju.util.WaveFile");
k.D("eju.util.random");
k.b.d = new function () {
    var a = this,
        b;
    k.Xa(function () {
        a.h = new k.b.F;
        a.random = k.b.random.xa;
        a.ya = k.b.random.za
    });
    this.clip = 0;
    this.n = 8;
    this.l = {
        song: {
            code: "n",
            defaultValue: ""
        },
        waveType: {
            code: "w",
            defaultValue: "Sine"
        },
        sampleRate: {
            code: "W",
            defaultValue: 11025
        },
        frequency: {
            code: "f",
            defaultValue: 440
        },
        vibratoFrequency: {
            code: "v",
            defaultValue: 0
        },
        vibratoDepth: {
            code: "V",
            defaultValue: 0.3
        },
        tremeloFrequency: {
            code: "t",
            defaultValue: 0
        },
        tremeloDepth: {
            code: "T",
            defaultValue: 0.3
        },
        duty: {
            code: "_",
            defaultValue: 0
        },
        dutySweepFrequency: {
            code: "d",
            defaultValue: 0
        },
        dutySweepDepth: {
            code: "D",
            defaultValue: 0.31
        },
        frequencyChange: {
            code: "c",
            defaultValue: 0
        },
        frequencyChangeTime: {
            code: "C",
            defaultValue: 50
        },
        steps: {
            code: "s",
            defaultValue: 1
        },
        stepDelta: {
            code: "S",
            defaultValue: 10
        },
        stepDirection: {
            code: "z",
            defaultValue: "Up"
        },
        length: {
            code: "l",
            defaultValue: 1
        },
        volume: {
            code: "L",
            defaultValue: 0.8
        },
        peak: {
            code: "p",
            defaultValue: 1
        },
        attack: {
            code: "a",
            defaultValue: 0
        },
        decay: {
            code: "A",
            defaultValue: 0
        },
        sustain: {
            code: "b",
            defaultValue: 0.2
        },
        release: {
            code: "r",
            defaultValue: 0
        },
        mode: {
            code: "M",
            defaultValue: "w"
        },
        randomSeed: {
            code: "E",
            defaultValue: 123
        },
        noiseWaveType: {
            code: "e",
            defaultValue: "Square"
        },
        noiseChangeTime: {
            code: "N",
            defaultValue: 50
        },
        noiseChangeRange: {
            code: "F",
            defaultValue: 256
        },
        noiseChangeStyle: {
            code: "B",
            defaultValue: "Random"
        },
        noiseNoteReset: {
            code: "R",
            defaultValue: "Off"
        },
        lowPassAlpha: {
            code: "g",
            defaultValue: 0
        }
    };
    this.sa = {};
    for (b in this.l) this.sa[this.l[b].code] = b
};
k.b.d.t = function (a, b, c) {
    var e;
    e = Math.sin(b.p * b.K);
    var g = 0 < e ? 1 : 0 > e ? -1 : 0,
        h = this.h.Ya;
    g != b.oa && 1 == g ? (b.P = d, b.ua++) : b.P = j;
    e = this.Da(a, b);
    b.Ga = e;
    b.oa = g;
    if (0 == a.frequency) e = b.O;
    else {
        switch (a.waveType) {
        case "Square":
            e = e > a.duty + b.v ? h : 0 - h;
            break;
        case "Sawtooth":
            g = 1 - Math.abs(a.duty + b.v);
            e > g ? b.i = -1 : (b.i += 2 * 1 / b.va * (1 + (1 - g)), 1 < b.i && (b.i = -1));
            e = b.i * h;
            break;
        case "Foo":
            e > a.duty + b.v ? b.i += b.p + b.v : b.i -= b.p + b.v;
            b.i * h < 0 - h && (b.i = -1);
            b.i * h > h && (b.i = 1);
            e = b.i * h;
            break;
        default:
            e *= h
        }
        e > h ? (e = h, this.clip++) : e < 0 - h && (e = 0 - h, this.clip++);
        e = Math.round(e * c * a.volume);
        e > h ? (e = h, this.clip++) : e < 0 - h && (e = 0 - h, this.clip++);
        8 == this.h.n && (e += h);
        b.O && a.lowPassAlpha && (e += a.lowPassAlpha * (b.O - e));
        b.O = e;
        b.pa = c
    }
    for (a = 0; a < this.h.n / 8; a++) this.h.data[b.ca + a] = (e & 255 << 8 * a) >> 8 * a;
    b.ca += this.h.n / 8;
    b.K++
};
k.b.d.Fa = function (a, b) {
    var c = Math.round(this.h.q / 20),
        e, g = b.pa,
        h = 3;
    for (e = b.x; b.x <= c + e; b.x++) this.t(a, b, (c - (b.x - e)) / c * g / Math.log(h)), h += 0.5
};
k.b.d.Pa = function (a, b) {
    var c = "AaBCcDdEFfGg".split(""),
        e;
    if (!a.match(/^[A-Gacdfg]$/)) return 0;
    for (e = 0; e < c.length && c[e] != a; e++);
    return 440 * Math.pow(2, (3 > e ? e + 12 * (b - 4) : e + 12 * (b - 5)) / 12)
};
k.b.d.Oa = function (a) {
    var b, c = a.song.length,
        e, g, h;
    this.ha = 4;
    for (h = 0; h < c; h++) "On" == a.noiseNoteReset && this.ya(a.randomSeed), e = a.song[h], g = h + 1 < c ? a.song[h + 1] : "", g.match(/^\d$/) ? h++ : g = this.ha, "O" == e ? this.ha = g : (a.frequency = this.Pa(e, g), b && (b.da = a.frequency, b.L = a.frequency, b.o = 0, b.step = 1, b.K = 0, b.p = 2 * Math.PI * a.frequency / this.h.q, b.P = d, b.ua = 0), b = this.la(a, b), b.X += this.h.q * a.length);
    return b
};
k.b.d.Da = function (a, b) {
    a.volume = b.Aa;
    a.noise && ("Random" == a.noiseChangeStyle ? 0 == Math.round(this.random() * a.noiseChangeTime) && (b.o = 0 - b.L + b.da + this.random() * a.noiseChangeRange) : 0 == b.x % a.noiseChangeTime && (b.o = 0 - b.L + b.da + this.random() * a.noiseChangeRange));
    a.vibratoFrequency && (b.o += Math.sin(b.Ca * (b.x + 1)) * a.vibratoDepth * b.Ca);
    a.tremeloFrequency && (a.volume += Math.sin(b.bb * b.x) * a.tremeloDepth * b.Aa);
    a.dutySweepFrequency && (b.v = Math.sin(b.Ka * b.x) * a.dutySweepDepth);
    a.frequencyChange && b.x == b.X && (b.o += a.frequencyChange);
    1 < a.steps && (b.x && 0 == b.x % b.ab) && (b.step++, b.o += a.stepDelta);
    if (b.P) {
        var c = b.p;
        a.frequency = b.L + b.o;
        b.p = 2 * Math.PI * a.frequency / this.h.q;
        b.va = this.h.q / a.frequency;
        c != b.p && (b.K = 1)
    }
    return Math.sin(b.p * b.K)
};
k.b.d.la = function (a, b) {
    var c, e, g = this.h.q;
    b || (b = {
        x: 0,
        K: 0,
        i: 0,
        p: 2 * Math.PI * a.frequency / g,
        va: g / a.frequency,
        ca: 0,
        O: 0,
        pa: 0,
        R: a.attack + a.decay + a.sustain + a.release,
        da: a.frequency,
        L: a.frequency,
        o: 0,
        Aa: a.volume,
        Ca: 2 * Math.PI * a.vibratoFrequency / g || 0,
        bb: 2 * Math.PI * a.tremeloFrequency / g || 0,
        Ka: 2 * Math.PI * a.dutySweepFrequency / g || 0,
        v: 0,
        step: 1,
        ab: Math.round(g * a.length / a.steps),
        X: Math.round(a.frequencyChangeTime * g * a.length / 100),
        P: d,
        ua: 0,
        oa: 1,
        Ga: 0
    });
    c = Math.round(g * a.attack / b.R * a.length);
    for (e = b.x; b.x < c + e; b.x++) this.t(a,
        b, (b.x - e) * (a.peak / c));
    c = Math.round(g * a.decay / b.R * a.length);
    for (e = b.x; b.x < c + e; b.x++) 1 < a.peak ? this.t(a, b, (c - (b.x - e)) * (a.peak - 1) / c + 1) : this.t(a, b, 1);
    c = Math.round(g * a.sustain / b.R * a.length);
    for (e = b.x; b.x < c + e; b.x++) this.t(a, b, 1);
    c = Math.round(g * a.release / b.R * a.length);
    for (e = b.x; b.x < c + e; b.x++) this.t(a, b, (c - (b.x - e)) / c);
    return b
};
k.b.d.Y = function (a) {
    var b;
    this.h.data = [];
    this.clip = 0;
    l(this.h, a.sampleRate, this.n);
    "Noise" == a.waveType && (a.noise = d, a.waveType = a.noiseWaveType);
    "Down" == a.stepDirection && (a.stepDelta = 0 - a.stepDelta);
    this.ya(a.randomSeed);
    b = "s" == a.mode ? this.Oa(a) : this.la(a);
    this.Fa(a, b)
};
k.b.d.N = function (a) {
    a = this.Z(a);
    this.Y(a);
    return this.h.N()
};
k.b.d.w = function (a) {
    a = this.Z(a);
    this.Y(a);
    return this.h.w()
};
k.b.d.ka = function (a) {
    var b, c = [];
    for (b in a)
        if (this.l[b] && a[b] != this.l[b].defaultValue) {
            var e = this.l[b].code;
            "number" == typeof a[b] ? c.push(e + "=" + Math.round(1E3 * a[b]) / 1E3) : c.push(e + "=" + a[b])
        }
    return c.join(",")
};
k.b.d.Ia = function () {
    var a, b = {};
    for (a in this.l) b[a] = this.l[a].defaultValue;
    return b
};
k.b.d.Z = function (a) {
    a = a.split(/,/);
    var b = this.Ia(),
        c;
    for (c = 0; c < a.length; c++) {
        var e = a[c].match(/^([\w<>])=(-?[\w\.\ ]*)\n?$/);
        if (e) {
            var g = this.sa[e[1]],
                e = e[2];
            g ? (parseFloat(e) == e && (e = parseFloat(e)), b[g] = e) : alert("ERROR: Unrecognized field in soundText '" + g + "'")
        }
    }
    return b
};
k.b.d.Kb = function (a) {
    this.n = 16 == a ? 16 : 8
};
"use strict";
k.r["eju.util.random"] = d;
k.b.random = new function () {
    var a, b, c, e;
    this.xa = function () {
        var g = a ^ a << 11;
        a = b;
        b = c;
        c = e;
        e = e ^ e >> 19 ^ g ^ g >> 8;
        return e / 2147483648
    };
    this.test = function () {
        var a, b, c = 0,
            e = 0,
            t = 0;
        for (a = 0; 1E7 > a; a++) b = this.xa(), b < e && (e = b), b > c && (c = b), t = ((a + 1) * t + b) / (a + 2);
        console.log("min=" + e + "  max=" + c + "  avg=" + t)
    };
    this.za = function (g) {
        a = g;
        b = 456;
        c = 789;
        e = 101112
    };
    this.za(123)
};
"use strict";
k.r["eju.uti.HTML"] = d;
k.b.g = {};
k.b.g.createElement = function (a, b, c) {
    a = document.createElement(a);
    if (b)
        for (var e in b)
            if ("object" == typeof b[e])
                if (a[e])
                    for (var g in b[e]) a[e][g] = b[e][g];
                else a[e] = b[e];
                else a[e] = b[e];
    c && ("string" == typeof c ? a.innerHTML = c : a.appendChild(c));
    return a
};
k.b.g.ja = function (a, b) {
    return this.createElement("div", a, b)
};
k.b.g.span = function (a, b) {
    return this.createElement("span", a, b)
};
k.b.g.ub = function (a, b) {
    return this.createElement("img", a, b)
};
k.b.g.Hb = function (a, b) {
    return this.createElement("pre", a, b)
};
k.b.g.B = function (a) {
    return this.createElement("table", a, f)
};
k.b.g.Pb = function (a) {
    return this.createElement("tr", a, f)
};
k.b.g.Nb = function (a) {
    return this.createElement("td", a, f)
};
k.b.g.tb = function () {
    return this.createElement("hr", f, f)
};
k.b.g.V = function () {
    return this.createElement("br", f, f)
};
k.b.g.Fb = function (a, b) {
    return this.createElement("p", a, b)
};
k.b.g.Ea = function (a) {
    return this.createElement("a", a, "Direct Link")
};
k.b.g.text = function (a) {
    return document.createTextNode(a)
};
k.b.g.Mb = function (a, b) {
    var c, e, g = this.createElement("table", b, f);
    for (c = 0; c < a.length; c++) {
        g.insertRow(c);
        for (e = 0; e < a[c].length; e++) g.rows[c].insertCell(e), "string" == typeof a[c][e] || "number" == typeof a[c][e] ? g.rows[c].cells[e].innerHTML = a[c][e] : g.rows[c].cells[e].appendChild(a[c][e])
    }
    return g
};
k.b.g.input = function (a) {
    return this.createElement("input", a, f)
};
k.b.g.Ob = function (a) {
    return this.createElement("textarea", a, f)
};
k.b.g.hb = function (a) {
    a || (a = {});
    a.type = "checkbox";
    return this.createElement("input", a, f)
};
k.b.g.button = function (a, b) {
    var c = this.input(a);
    c.value = b;
    c.type = "button";
    return c
};
k.b.g.Wa = function (a, b, c) {
    var e = this.createElement("option", f, f);
    e.value = a;
    e.text = b;
    e.selected = c;
    return e
};
k.b.g.select = function (a, b) {
    var c = this.createElement("select", a, f);
    if (b) {
        var e;
        for (e = 0; e < b.length; e++) c.add(this.Wa(b[e][1], b[e][0], a.defaultValue && a.defaultValue == b[e][1]), f)
    }
    return c
};
k.b.g.Ha = function (a) {
    var b = this.span(void 0, f),
        c;
    for (c in a) b.appendChild(a[c]);
    return b
};
k.D("eju.util.SFDesigner");
window.SFDesigner = k.b.S;
window.sfMaker = k.b.d;
window.WaveFile = k.b.F;
window.sfMaker.generateAudioTag = sfMaker.N;
window.sfMaker.generateBase64 = sfMaker.w;