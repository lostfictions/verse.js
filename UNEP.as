package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	
	public class UNEP
	{


stop();
//h6nuHC2bYStCPceLqJTKvkFPczYutB2a
graphics.clear();
var STATE:int = 0;

stage.removeEventListener(Event.RESIZE,rsz);

function setScaleMP(B:Boolean):void {
	if (!B) {
		//felt
		scale2 = [0,3,5,8,10];
		scale = [0,0,0,1,0,2,0,0,3,0,4,0];
		//verse
		scale_verse = [0,2,4,5,7,9,11,12,14,16,17,19,21,23,24,26,28,29,31,33,35,36];
		noteIndex = ["e","f","f#","g","g#","a","a#","b","c","c#","d","d#","e","f","f#","g","g#","a","a#","b","c","c#","d","d#","e","f","f#","g","g#","a","a#","b","c","c#","d","d#","e"];
		chordList = [",e,c,g,", ",e,b,g,"];
		//cycle
		scale_cycle = [0, 2, 3, 5, 7, 8, 10,
					   12,14,15,17,19,20,22,
					   24,26,27,29,31,32,34];
		//veil
		scale_veil = [0, 2, 5, 7, 8, 10,
					  12,14,17,19,20,22,
					  24,26,29,31,32,34];
		wheelA = [2,  14, 26,
				  7,  19, 31,
				  5,  17, 29];
		wheelB = [0,  12, 24,
				  8,  20, 32,
				  10, 22, 34];
	} else {
		//felt
		scale2 = [0,3,5,8,10];
		scale = [0,0,0,1,0,2,0,0,3,0,4,0];
		// verse // a  b  c#  d  e  f#
		scale_verse = [0,2,4,5,7,9,11,12,14,16,17,19,21,23,24,26,28,29,31,33,35,36];
		noteIndex = ["e","f","f#","g","g#","a","a#","b","c","c#","d","d#","e","f","f#","g","g#","a","a#","b","c","c#","d","d#","e","f","f#","g","g#","a","a#","b","c","c#","d","d#","e"];
		chordList = [",a,b,c#,",",b,c#,e,",",c#,e,f#,",",e,f#,a,",",f#,a,b,",",a,b,d,",",b,d,e,",",d,e,f#,",",e,f#,a,",",f#,a,b,"];
		//cycle
		scale_cycle = [0, 2, 4, 7, 9, 11,
					   12,14,16,19,21,23,
					   24,26,28,31,33];
		//veil / 1 3 5 8 10 12
		scale_veil = [1, 3, 5, 8, 10,12,
					  13,15,17,20,22,24,
					  25,27,29,32,34];
		wheelA = [3,  15, 27,
				  5,  17, 29,
				  8,  20, 34];
		wheelB = [1,  13, 25,
				  10, 22, 34,
				  12, 24];
	}
}

stage.addEventListener(Event.RESIZE,rsz2);
function rsz2(e:Event):void {
	if (STATE == -1 || STATE == 0) {
		sW = stage.stageWidth;
		sH = stage.stageHeight;
	}
	
	/*if (STATE == 3) init_felt(true);
	else if (STATE == 1) init_verse(true);
	else if (STATE == 5) init_cycle(true);
	else if (STATE == 4) init_veil(true);
	else if (STATE == 2) init_form(true);
	else if (STATE == 0) init_menu(true);
	else if (STATE == -1) init_menu(true);*/
}

stage.addEventListener(KeyboardEvent.KEY_DOWN,esc_kd);
function esc_kd(e:KeyboardEvent):void {
	e.preventDefault();
	if (e.keyCode == Keyboard.ESCAPE) {
		if (STATE == 3) felt_fadeOut();
		else if (STATE == 1) verse_fade();
		else if (STATE == 5) cycle_fade();
		else if (STATE == 4) veil_fade();
		else if (STATE == 2) form_fade();
		else if (STATE == 0) btn_opt();
		else if (STATE == -1) goBack2();
	}
}

function init_menu(redo:Boolean=false):void {
	sW = stage.stageWidth;
	sH = stage.stageHeight;
	if (!redo) {
		STATE = 0;
		dotNum = 21;
		fade_tmr = 0;
		opt_a = 0;
		menu_opt.alpha = 0;
		select.length = p.length = 0;
		cM = lcM = -1;
		t_tmr = 0;
		for (n=0; n<tList.length; n++) tList[n].alpha = 0;
		tm = -20;
		menu_s = new Sound();
		menu_s.addEventListener(SampleDataEvent.SAMPLE_DATA,menu_sine);
		menu_s.play();
		stage.addEventListener(MouseEvent.CLICK, menu_ck);
		stage.addEventListener(Event.ENTER_FRAME,ef);
		addChild(L);
		for (n=0; n<tList.length; n++) addChild(tList[n]);
	} else {
		l.clear();
		l.beginFill(clr[0]);
		l.drawRect(0,0,sW,sH);
		l.endFill();
		for (n=0; n<p.length; n+=amt2) {
			if (n != cM && mnu[n/amt2] == 0) {
				l.beginFill(cTran(clr[1],clr[2],n/p.length));
				l.moveTo(.5*(p[n+amt2-4]+p[n+4]), .5*(p[n+amt2-3]+p[n+5]));
				for (n2=n+2; n2<n+amt2-6; n2+=6) {
					l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n2+8]),.5*(p[n2+3]+p[n2+9]));
				}
				l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n+4]),.5*(p[n2+3]+p[n+5]));
				l.endFill();
			}
		}
		//cTran(cTran(cSet[mnu[n/amt2]-1][1],cSet[mnu[n/amt2]-1][2],n/p.length),cSet[mnu[n/amt2]-1][3],0*select[n/amt2]));
		for (n=0; n<p.length; n+=amt2) {
			if (mnu[n/amt2] != 0) {
				l.lineStyle(2,clr[3]);
				l.beginFill(clr[0]);
				l.moveTo(.5*(p[n+amt2-4]+p[n+4]), .5*(p[n+amt2-3]+p[n+5]));
				for (n2=n+2; n2<n+amt2-6; n2+=6) {
					l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n2+8]),.5*(p[n2+3]+p[n2+9]));
				}
				l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n+4]),.5*(p[n2+3]+p[n+5]));
				l.endFill();
			}
		}
		if (cM != -1) {
			n = cM;
			l.lineStyle(1,clr[3],0);
			l.beginFill(cTran(cTran(clr[1],clr[2],n/p.length),clr[3],0*select[n/amt2]));
			l.moveTo(.5*(p[n+amt2-4]+p[n+4]), .5*(p[n+amt2-3]+p[n+5]));
			for (n2=n+2; n2<n+amt2-6; n2+=6) {
				l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n2+8]),.5*(p[n2+3]+p[n2+9]));
			}
			l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n+4]),.5*(p[n2+3]+p[n+5]));
			l.endFill();
		}
	}
}

function init_felt(redo:Boolean=false):void {
	if (!redo) {
		STATE = 3;
		fading = 0; END = 120;
		nts.length = v.length = xv.length = yv.length = rv.length = sv.length = lv.length = er.length = 0;
		temp = null;
		felt_amt = 60*(sW*sH)/(1280*800);
		lateSpawn = [];
		s = 1; rs = 3; limit = 45;
		kill = 1000; offset = 100;
		ttl = 0; ttl2 = 0;
		nList.length = nListr.length = 0;
		for (n=0; n<NM0.length; n++) NM0[n] = 0;
		for (n=0; n<NM1.length; n++) NM1[n] = 0;
		for (n=0; n<NM2.length; n++) NM2[n] = 0;
		for (n=0; n<NM3.length; n++) NM3[n] = 0;
		for (n=0; n<NM4.length; n++) NM4[n] = 0;
		nList.push(NM0,NM1,NM2,NM3,NM4);
		for (n=0; n<NM0r.length; n++) NM0r[n] = 0;
		for (n=0; n<NM1r.length; n++) NM1r[n] = 0;
		for (n=0; n<NM2r.length; n++) NM2r[n] = 0;
		for (n=0; n<NM3r.length; n++) NM3r[n] = 0;
		for (n=0; n<NM4r.length; n++) NM4r[n] = 0;
		nListr.push(NM0r,NM1r,NM2r,NM3r,NM4r);
		newSet();
		tempBitmap = new BitmapData(sW,sH,true,0);
		bitmapHolder = new Bitmap(tempBitmap);
		stage.addEventListener(Event.ENTER_FRAME,ef2);
		addChild(L);
		stage.addEventListener(MouseEvent.MOUSE_DOWN,md);
		addChild(bitmapHolder);
		stage.addEventListener(MouseEvent.MOUSE_DOWN,md2);
		mySound.addEventListener(SampleDataEvent.SAMPLE_DATA,sineWaveGenerator);
		mySound.play();
	} else {
		
	}
}

function init_cycle(redo:Boolean=false):void {
	if (!redo) {
		STATE = 5;
		OX = OX2 = sW*.5;
		OY = OY2 = sH*.5 - 200;
		ccl = [];
		rcd = [];
		MD = false;
		od = rX = rY = _i = 0;
		lns.length = myNote.length = 0;
		//for (n=0; n<5; n++) newNote();
		tempBitmap = new BitmapData(sW,sH,true,0x00000000);
		bitmapHolder = new Bitmap(tempBitmap);
		stage.addEventListener(MouseEvent.MOUSE_DOWN,md_cycle);
		stage.addEventListener(Event.ENTER_FRAME,ef_cycle);
		stage.addEventListener(MouseEvent.MOUSE_UP,mu);
		stage.addEventListener(Event.ENTER_FRAME,ef2_cycle);
		addChild(bitmapHolder);
		addChild(L);
		filter = new ColorMatrixFilter([1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,.9999999,0]);
		mySound2 = new Sound();
		mySound2.addEventListener(SampleDataEvent.SAMPLE_DATA, sine);
		mySound2.play();
	}
}

function init_veil(redo:Boolean=false):void {
	if (!redo) {
		STATE = 4;
		sz_tm = Math.min(sW/600, sH/600);
		echo = 44100*.1;
		memi = memi2 = 0;
		for (n=0; n<sineMemL.length; n++) sineMemL[n] = 0;
		for (n=0; n<sineMemR.length; n++) sineMemR[n] = 0;
		for (n=0; n<wia.length; n++) wia[n] = 0;
		for (n=0; n<wib.length; n++) wib[n] = 0;
		for (n=0; n<rs_veil.length; n++) rs_veil[n] = 0;
		for (n=0; n<rs2.length; n++) rs2[n] = 0;
		for (n=0; n<flws.length; n++) flws[n] = 0;
		dn = false;
		ptpt.length = ptx.length = pty.length = ptxs.length = ptys.length = ptt.length = pta.length = 0;
		n=0;
		while (n++ < rs_veil.length-1) {
			rs_veil[n] = 0;
			rs2[n] = 0;
			flws[n] = .2;
		}
		cs1 = .0017;
		cs2 = .0007;
		age = 1000000;
		dp1.length = dp2.length = dpc1.length = dpc2.length = 0;
		flmt = 3.5; flw_veil = .2; spawn = 0;
		fp = (flw_veil-.2)/(flmt-.2); wt = 0;
		AR = AR2 = v1 = v2 = 0;
		amt_veil = 0.015;
		cx = lx = mouseX;
		cy = ly = mouseY;
		MX = MY = 0;
		tempBitmap = new BitmapData(sW,sH,true,0x00000000);
		bitmapHolder = new Bitmap(tempBitmap);
		if (true || !MMODE) {
			snd1 = new Drone1();
			snd2 = new Drone2();
		} else {
			snd1 = new Drone1_2();
			snd2 = new Drone2_2();
		}
		sc1 = new SoundChannel();
		sc2 = new SoundChannel();
		st1 = new SoundTransform();
		st2 = new SoundTransform();
		sc1 = snd1.play(0,999999);
		sc2 = snd2.play(0,999999);
		st1.volume = st2.volume = 0;
		sc1.soundTransform = st1;
		sc2.soundTransform = st2;
		mySound_veil = new Sound();
		mySound_veil.addEventListener(SampleDataEvent.SAMPLE_DATA, sine2);
		mySound_veil.play();
		myTimer = new Timer(int(50/3));
		myTimer.addEventListener(TimerEvent.TIMER, timerListener);
		myTimer.start();
		stage.addEventListener(Event.ENTER_FRAME,ef2_veil);
		stage.addEventListener(MouseEvent.MOUSE_DOWN,md_veil);
		stage.addEventListener(MouseEvent.MOUSE_UP,mu_veil);
		addChild(bitmapHolder);
		M = new Matrix();
	} else {
		
	}
}

function init_form(redo:Boolean=false):void {
	if (!redo) {
		STATE = 2;
		cx = cy = cz = 0;
		plane = [[-50,-200,100],[50,-200,100],[-50,-300,100],[-50,-200,-100],[50,-200,-100],[-50,-300,-100]];
		spX = spY = spZ = 0;
		drawPlane = false;
		toDraw = [];
		for (n=0; n<tPt.length; n++) tPt[n] = 0;
		lx = mouseX;
		ly = mouseY;
		Dv = Math.sqrt(3)/(Math.sqrt(5)-1);
		deca = [[0.607, 0.000, 0.795], [ 0.188, 0.577, 0.795],
						[-0.491, 0.357, 0.795],
						[-0.491,-0.357, 0.795],
						[ 0.188,-0.577, 0.795],
						[ 0.982, 0.000, 0.188],
						[ 0.304, 0.934, 0.188],
						[-0.795, 0.577, 0.188],
						[-0.795,-0.577, 0.188],
						[ 0.304,-0.934, 0.188],
						[ 0.795, 0.577,-0.188],
						[-0.304, 0.934,-0.188],
						[-0.982, 0.000,-0.188],
						[-0.304,-0.934,-0.188],
						[ 0.795,-0.577,-0.188],
						[ 0.491, 0.357,-0.795],
						[-0.188, 0.577,-0.795],
						[-0.607, 0.000,-0.795],
						[-0.188,-0.577,-0.795],[ 0.491,-0.357,-0.795]];
		siz = 500;
		genDoce(siz);
		for (n=0; n<plane.length; n++) {	
			plane[n][0] += 1;
			plane[n][1] += 3000;
			plane[n][2] += 1;
			
			spX += plane[n][0];
			spY += plane[n][1];
			spZ += plane[n][2];
		}
		spX /= plane.length;
		spY /= plane.length;
		spZ /= plane.length;
		shape = [];
		shape.push([plane[0],plane[1],plane[2],plane[3],plane[4]]);
		shape.push([plane[0],plane[1],plane[6],plane[10],plane[5]]);
		shape.push([plane[1],plane[2],plane[7],plane[11],plane[6]]);
		shape.push([plane[2],plane[3],plane[8],plane[12],plane[7]]);
		shape.push([plane[3],plane[4],plane[9],plane[13],plane[8]]);
		shape.push([plane[4],plane[0],plane[5],plane[14],plane[9]]);
		shape.push([plane[19],plane[18],plane[17],plane[16],plane[15]]);
		shape.push([plane[15],plane[10],plane[5],plane[14],plane[19]]);
		shape.push([plane[16],plane[11],plane[6],plane[10],plane[15]]);
		shape.push([plane[17],plane[12],plane[7],plane[11],plane[16]]);
		shape.push([plane[18],plane[13],plane[8],plane[12],plane[17]]);
		shape.push([plane[19],plane[14],plane[9],plane[13],plane[18]]);
		dst = 0;
		light = [];
		trail = [];
		clrs_form = [];
		for (n=0; n<5; n++) {
			xd = plane[n][0] - spX;
			yd = plane[n][1] - spY;
			zd = plane[n][2] - spZ;
			dst += Math.sqrt(xd*xd+yd*yd+zd*zd);
		}
		dst /= shape[0].length;
		while (clrs_form.length < shape.length) {
			clrs_form.push(0xff*Math.random());
			trail.push([0,0]);
			light.push(0);
		}
		xs = ys = 0;
		drag = false;
		tList_form = [];
		sz_tm = 0;
		sw = sW/100;
		sh = sH/100;
		addChild(L);
		addChild(L2);
		addChild(L3);
		addChild(L4);
		stage.addEventListener(Event.ENTER_FRAME,rend);
		stage.addEventListener(MouseEvent.MOUSE_DOWN,ck_form);
		stage.addEventListener(MouseEvent.MOUSE_UP,mu_form);
		stage.addEventListener(Event.ENTER_FRAME,tef);
		
		scale_form = [s0,s2,s5,s7,s9,s5,s12,s14,s16,s19,s21,s17];
		scale_form = scale_form.sort(sort2);
		snds.length = 0;
		snds.push(s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23);
		msc_tracks = [];
		msc_st.length = msc_sc.length = 0;
		vol = 2*VOLUME;
		newTrack("l1", LP1, 0, 0, 0, 60*3);
		newTrack("l2", LP2, 0, 0, 0, 60*3);
		newTrack("l3", LP3, 0, 0, 0, 60*3);
		newTrack("l4", LP4, 0, 0, 0, 60*3);
		newTrack("l5", LP5, 0, 0, 0, 60*3);
		newTrack("l6", LP6, 0, 0, 0, 60*3);
		newTrack("l7", LP7, 0, 0, 0, 60*3);
		newTrack("l8", LP8, 0, 0, 0, 60*3);
		ind_form = 0;
		sList = ["l1","l2","l3","l4","l5","l6","l7","l8"];
		sList = sList.sort(sort2);
		stage.addEventListener(Event.ENTER_FRAME,snd_ef);
		stage.addEventListener(Event.ENTER_FRAME,msc_mng);
	} else {
		
	}
}







































/////////////////////////////////////////////////////////

function fadeOut():void {
	stage.removeEventListener(MouseEvent.CLICK, menu_ck);
	stage.removeEventListener(Event.ENTER_FRAME,ef);
	Mouse.cursor = MouseCursor.ARROW;
	
	fade_tmr = 0;
	addChild(OPTL);
	
	stage.addEventListener(Event.ENTER_FRAME,fade_ef);
}

function endFade():void {
	menu_s.removeEventListener(SampleDataEvent.SAMPLE_DATA,menu_sine);
	menu_s = null;
	menu_nList.length = 0;
	removeChild(OPTL);
	stage.removeEventListener(Event.ENTER_FRAME,fade_ef);
	sW = stage.stageWidth;
	sH = stage.stageHeight;
	switch (tti) {
		

		//verse:
		case 0:
		graphics.clear();
		graphics.beginFill(0);
		graphics.drawRect(0,0,sW,sH);
		graphics.endFill();
		init_verse();
		break;
		
		case 1:
		graphics.clear();
		graphics.beginFill(0x81B19A);
		graphics.drawRect(0,0,sW,sH);
		graphics.endFill();
		init_form();
		break;
		
		case 2:
		graphics.clear();
		graphics.beginFill(0x262639);
		graphics.drawRect(0,0,sW,sH);
		graphics.endFill();
		init_felt();
		break;
		
		case 3:
		graphics.clear();
		graphics.beginFill(0);
		graphics.drawRect(0,0,sW,sH);
		graphics.endFill();
		init_veil();
		break;
		
		case 4:
		graphics.clear();
		graphics.beginFill(0);
		graphics.drawRect(0,0,sW,sH);
		graphics.endFill();
		init_cycle();
		break;
		
		default:
	}
	l.clear();
	fading = 0;
	setScaleMP(MMODE);
}

var fade_tmr:Number = 0;

function fade_ef(e:Event):void {
	optL.clear();
	if (tti != 3) optL.beginFill(clr[0],fade_tmr/45);
	else optL.beginFill(0,fade_tmr/45);
	optL.drawRect(0,0,sW,sH);
	optL.endFill();
	
	for (n=0; n<tList.length; n++) tList[n].alpha -= tList[n].alpha/10;
	
	l.clear();
	for (n=0; n<p.length; n+=amt2) {
		for (n2=n+2; n2<n+amt2; n2+=6) {
			if (cM == n) {
				xd = (p[n]+p[n2]*2) - p[n2+2];
				yd = (p[n+1]+p[n2+1]*2) - p[n2+3];
			} else {
				xd = (p[n]+p[n2]) - p[n2+2];
				yd = (p[n+1]+p[n2+1]) - p[n2+3];
			}
			p[n2+4] += xd/100;
			p[n2+5] += yd/100;
		}
	}
	
	for (n=0; n<p.length; n+=amt2) {		
		ax = ay = 0;
		for (n2=n+2; n2<n+amt2; n2+=6) {
			p[n2+2] += p[n2+4];
			p[n2+3] += p[n2+5];
			
			n3 = n2-2; if (n3 == n2) n3 = n*amt2-4;
			p[n3]   += p[n2+4]*flw*.5;
			p[n3+1] += p[n2+5]*flw*.5;
			n3 = n2+6; if (n3 >= amt2) n3 = n+2;
			n3 += 2;
			p[n3]   += p[n2+4]*flw*.5;
			p[n3+1] += p[n2+5]*flw*.5;
			p[n2+4] *= (1-flw);
			p[n2+5] *= (1-flw);
			
			for (n3=0; n3<p.length; n3+=amt2) {
				if (n != n3 && pPoly(n3,p[n2+2],p[n2+3])) {
					xd = p[n3+0] - p[n2+2];
					yd = p[n3+1] - p[n2+3];
					d = Math.sqrt(xd*xd+yd*yd);
					p[n2+4] -= .5*xd/d;
					p[n2+5] -= .5*yd/d;
				}
			}
			
			if (p[n2+2] > sW) {
				p[n2+2] = sW;
				p[n2+4] = 0;
			} else if (p[n2+2] < 0) {
				p[n2+2] = 0;
				p[n2+4] = 0;
			}
			if (p[n2+3] > sH) {
				p[n2+3] = sH;
				p[n2+5] = 0;
			} else if (p[n2+3] < 0) {
				p[n2+3] = 0;
				p[n2+5] = 0;
			}
			
			ax += p[n2+2];
			ay += p[n2+3];
		}
		
		ax /= amt;
		ay /= amt;
		d = int(Math.random()*(p.length/amt2))*amt2;
		if (d != n) {
			xd = p[d] - ax;
			yd = p[d+1] - ay;
			d = Math.sqrt(xd*xd+yd*yd);
			p[n] = ax+5*xd/d;
			p[n+1] = ay+5*yd/d;
		} else {
			p[n] = ax;
			p[n+1] = ay;
		}
	}
	
	for (n=0; n<p.length; n+=amt2) {
		for (n2=n+amt2; n2<p.length; n2+=amt2) {
			xd = p[n] - p[n2];
			yd = p[n+1] - p[n2+1];
			d = Math.sqrt(xd*xd+yd*yd);
			if (d < 50) {
				p[n] = .5*(p[n]+p[n2]) + 50*xd/d;
				p[n+1] = .5*(p[n+1]+p[n2+1]) + 50*yd/d;
				p[n2] = .5*(p[n]+p[n2]) - 50*xd/d;
				p[n2+1] = .5*(p[n+1]+p[n2+1]) - 50*yd/d;
			}
		}
	}
	
	l.beginFill(clr[0]);
	l.drawRect(0,0,sW,sH);
	l.endFill();
	for (n=0; n<p.length; n+=amt2) {
		if (n != cM && mnu[n/amt2] == 0) {
			l.beginFill(cTran(clr[1],clr[2],n/p.length));
			l.moveTo(.5*(p[n+amt2-4]+p[n+4]), .5*(p[n+amt2-3]+p[n+5]));
			for (n2=n+2; n2<n+amt2-6; n2+=6) {
				l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n2+8]),.5*(p[n2+3]+p[n2+9]));
			}
			l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n+4]),.5*(p[n2+3]+p[n+5]));
			l.endFill();
		}
	}
	//cTran(cTran(cSet[mnu[n/amt2]-1][1],cSet[mnu[n/amt2]-1][2],n/p.length),cSet[mnu[n/amt2]-1][3],0*select[n/amt2]));
	for (n=0; n<p.length; n+=amt2) {
		if (mnu[n/amt2] != 0) {
			l.lineStyle(2,clr[3]);
			l.beginFill(clr[0]);
			l.moveTo(.5*(p[n+amt2-4]+p[n+4]), .5*(p[n+amt2-3]+p[n+5]));
			for (n2=n+2; n2<n+amt2-6; n2+=6) {
				l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n2+8]),.5*(p[n2+3]+p[n2+9]));
			}
			l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n+4]),.5*(p[n2+3]+p[n+5]));
			l.endFill();
		}
	}
	if (cM != -1) {
		n = cM;
		l.lineStyle(1,clr[3],0);
		l.beginFill(cTran(cTran(clr[1],clr[2],n/p.length),clr[3],0*select[n/amt2]));
		l.moveTo(.5*(p[n+amt2-4]+p[n+4]), .5*(p[n+amt2-3]+p[n+5]));
		for (n2=n+2; n2<n+amt2-6; n2+=6) {
			l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n2+8]),.5*(p[n2+3]+p[n2+9]));
		}
		l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n+4]),.5*(p[n2+3]+p[n+5]));
		l.endFill();
	}
	
	if (fade_tmr >= 45) endFade();
	else fade_tmr += 45/120;
}


























/////////////////////////////////////////////////////////

var menu_v:Vector.<Number> = new Vector.<Number>();
menu_v.push(0.09595,0.09866,0.09601,0.09561,0.09683,0.09555,0.09567,0.09558,0.09439,0.09482,0.09457,0.09357,0.09201,0.09103,0.09134,
	0.08929,0.08740,0.08704,0.08578,0.08667,0.08542,0.08450,0.08453,0.08234,0.08301,0.08139,0.07938,0.08005,0.07797,0.07999,0.07925,
	0.08041,0.08112,0.07742,0.07822,0.07855,0.07971,0.07944,0.07797,0.07797,0.07755,0.07816,0.07761,0.07654,0.07611,0.07541,0.07449,
	0.07449,0.07391,0.07422,0.07379,0.07245,0.07129,0.06943,0.07022,0.06830,0.06461,0.06583,0.06595,0.06372,0.06137,0.06100,0.05914,
	0.05771,0.05725,0.05496,0.05435,0.05377,0.05054,0.04895,0.04550,0.04388,0.04260,0.04092,0.03854,0.03494,0.03357,0.02960,0.02695,
	0.02493,0.02112,0.01773,0.01541,0.01373,0.00974,0.00546,0.00455,0.00174,-0.00198,-0.00394,-0.00800,-0.00998,-0.01276,-0.01837,-0.01920,
	-0.02097,-0.02499,-0.02673,-0.02856,-0.03439,-0.03918,-0.03983,-0.04333,-0.04593,-0.04819,-0.05173,-0.05383,-0.05557,-0.06036,-0.06467,
	-0.06824,-0.06998,-0.06973,-0.07285,-0.07632,-0.07883,-0.07935,-0.07983,-0.08398,-0.08548,-0.08704,-0.08966,-0.08908,-0.08975,-0.09128,
	-0.09332,-0.09375,-0.09488,-0.09512,-0.09442,-0.09628,-0.09723,-0.09790,-0.09854,-0.09888,-0.09872,-0.10022,-0.10342,-0.10318,-0.10260,
	-0.10229,-0.10352,-0.10562,-0.10617,-0.10825,-0.10782,-0.10712,-0.10742,-0.11005,-0.10803,-0.10559,-0.10626,-0.10709,-0.10715,-0.10733,
	-0.10782,-0.10867,-0.10794,-0.10931,-0.11041,-0.10840,-0.10727,-0.10931,-0.10913,-0.10751,-0.10663,-0.10669,-0.10641,-0.10767,-0.10559,
	-0.10611,-0.10455,-0.10382,-0.10339,-0.10123,-0.10074,-0.10040,-0.10181,-0.10129,-0.10101,-0.10074,-0.09930,-0.09842,-0.09811,-0.09650,
	-0.09595,-0.09491,-0.09360,-0.09369,-0.09204,-0.09106,-0.09100,-0.09341,-0.09320,-0.09024,-0.08887,-0.08884,-0.08868,-0.08578,-0.08417,
	-0.08319,-0.07932,-0.07846,-0.07657,-0.07315,-0.06982,-0.06839,-0.06366,-0.06238,-0.06226,-0.05975,-0.05679,-0.05679,-0.05679,-0.05283,
	-0.05252,-0.04999,-0.04776,-0.04694,-0.04456,-0.04190,-0.03821,-0.03708,-0.03613,-0.03354,-0.03168,-0.02890,-0.02469,-0.02197,-0.01886,
	-0.01672,-0.01505,-0.01263,-0.01089,-0.00708,-0.00534,-0.00528,-0.00146,0.00003,0.00336,0.00363,0.00504,0.00778,0.01056,0.01224,0.01523,
	0.01944,0.02118,0.02377,0.02930,0.03195,0.03448,0.03757,0.04114,0.04086,0.04291,0.04947,0.05200,0.05457,0.05713,0.05783,0.06259,0.06442,0.06619,0.06821,0.06955,0.07297,0.07327);
menu_v.push(menu_v[0]);

var menu_ind:int = 0;
var menu_L:Number, menu_R:Number;
var menu_env:int = 30*2048;

var menu_s:Sound = new Sound();
function menu_sine(e:SampleDataEvent):void {
	for (var c:int=0; c<BLOCK; c++) {
		menu_L = menu_R = 0;
		
		for (var n:int=0; n<menu_nList.length; n+=5) {
			d = menu_nList[n+2];
			yd = int(d);
			xd = d - yd;
			if (menu_nList[n] > 0) d = (menu_v[yd]*(1-xd) + menu_v[yd+1]*xd) * menu_nList[n+3] * (1-Math.sqrt(menu_nList[n]/menu_env));
			else d = (menu_v[yd]*(1-xd) + menu_v[yd+1]*xd) * menu_nList[n+3] * (1-Math.sqrt(c/BLOCK));
			menu_L += d * (1-menu_nList[n+4]);
			menu_R += d * menu_nList[n+4];
			
			menu_nList[n]++;
			menu_nList[n+2] += menu_nList[n+1];
			if (menu_nList[n+2] >= menu_v.length-1) menu_nList[n+2] -= menu_v.length-1;
			
			if (menu_nList[n] > menu_env) {
				menu_nList.splice(n,5);
				n -= 5;
			}
		}
		
		e.data.writeFloat(menu_L*VOLUME*(1-fade_tmr/45));
		e.data.writeFloat(menu_R*VOLUME*(1-fade_tmr/45));
	}
}

//time idx, v idx, rate, vol, pan
var menu_nList:Vector.<Number> = new Vector.<Number>();
function menu_newNote(n:Number, v:Number=1, p:Number=.5):void {
	menu_nList.push(0,menu_rates(n),0,v,p);
}
function menu_rates(n:Number):Number {
	return Math.pow(2, (n-.1)/12);
}

var menu_scale:Array = [0, 3, 5, 7, 8, 10,
					    12,15,17,19,20,22,
					    24,27,29,31,32,34];

//////////////////////////////////













var OPTL:Shape = new Shape();
var optL:Graphics = OPTL.graphics;

var opt_a:Number = 0;
menu_opt.alpha = 0;

function rOver(e:MouseEvent):void { Mouse.cursor = MouseCursor.BUTTON; }
function rOut(e:MouseEvent):void { Mouse.cursor = MouseCursor.ARROW; }
function rOver2(e:MouseEvent):void {
	Mouse.cursor = MouseCursor.BUTTON;
	menu_opt.back_btn.addEventListener(MouseEvent.ROLL_OUT, rOut2);
}
function rOut2(e:MouseEvent):void {
	Mouse.cursor = MouseCursor.ARROW;
	menu_opt.back_btn.removeEventListener(MouseEvent.ROLL_OUT, rOut2);
}

function btn_opt():void {
	STATE = -1;
	stage.removeEventListener(MouseEvent.CLICK, menu_ck);
	stage.removeEventListener(Event.ENTER_FRAME,ef);
	stage.addEventListener(Event.ENTER_FRAME,opt_ef);
	Mouse.cursor = MouseCursor.ARROW;
	opt_a = 0;
	addChild(OPTL);
	addChild(ttl5);
	addChild(menu_opt);
	menu_opt.vSlider.gotoAndStop(int(VOLUME*100)+1);
	menu_opt.onoff1.gotoAndStop(MMODE ? 1 : 10);
	menu_opt.onoff2.gotoAndStop(FULLSCREEN ? 1 : 10);
	
	menu_opt.vSlider.addEventListener(MouseEvent.ROLL_OVER, rOver);
	menu_opt.vSlider.addEventListener(MouseEvent.ROLL_OUT, rOut);
	menu_opt.onoff1.addEventListener(MouseEvent.ROLL_OVER, rOver);
	menu_opt.onoff1.addEventListener(MouseEvent.ROLL_OUT, rOut);
	menu_opt.onoff2.addEventListener(MouseEvent.ROLL_OVER, rOver);
	menu_opt.onoff2.addEventListener(MouseEvent.ROLL_OUT, rOut);
	menu_opt.back_btn.addEventListener(MouseEvent.ROLL_OVER, rOver2);
	menu_opt.quit_btn.addEventListener(MouseEvent.ROLL_OVER, rOver);
	menu_opt.quit_btn.addEventListener(MouseEvent.ROLL_OUT, rOut);
	
	menu_opt.vSlider.addEventListener(MouseEvent.MOUSE_DOWN, volDown);
	stage.addEventListener(MouseEvent.MOUSE_UP, volUp);
	menu_opt.onoff1.addEventListener(MouseEvent.CLICK, switchMP);	
	menu_opt.onoff2.addEventListener(MouseEvent.CLICK, switchFS);	
	menu_opt.back_btn.addEventListener(MouseEvent.CLICK, goBack);
	menu_opt.quit_btn.addEventListener(MouseEvent.CLICK, quitGame);
}

function volDown(e:MouseEvent):void {
	stage.addEventListener(MouseEvent.MOUSE_MOVE,volMove);
	VOLUME = (mouseX-183-45)/153;
	if (VOLUME < 0) VOLUME = 0;
	else if (VOLUME > 1) VOLUME = 1;
	menu_opt.vSlider.gotoAndStop(int(VOLUME*99)+1);
}
function volMove(e:MouseEvent):void {
	VOLUME = (mouseX-183-45)/153;
	if (VOLUME < 0) VOLUME = 0;
	else if (VOLUME > 1) VOLUME = 1;
	menu_opt.vSlider.gotoAndStop(int(VOLUME*99)+1);
}
function volUp(e:MouseEvent):void {
	stage.removeEventListener(MouseEvent.MOUSE_MOVE,volMove);
}

function switchMP(e:Event):void {
	MMODE = !MMODE;
	setScaleMP(MMODE);
	menu_opt.onoff1.gotoAndPlay(MMODE ? 11 : 2);
}

function switchFS(e:Event):void {
	FULLSCREEN = !FULLSCREEN;
	menu_opt.onoff2.gotoAndPlay(FULLSCREEN ? 11 : 2);
	if (FULLSCREEN) {
		stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
	} else {
		stage.displayState = StageDisplayState.NORMAL;
	}
}

function quitGame(e:MouseEvent):void {
	//fscommand("quit");
	NativeApplication.nativeApplication.exit();
	//NativeWindow.close();
}

function goBack(e:MouseEvent):void {
	goBack2();
}

function goBack2():void {
	STATE = 0;
	stage.addEventListener(Event.ENTER_FRAME,ef);
	stage.addEventListener(Event.ENTER_FRAME,opt_ef2);
	stage.removeEventListener(Event.ENTER_FRAME,opt_ef);
	
	menu_opt.vSlider.removeEventListener(MouseEvent.ROLL_OVER, rOver);
	menu_opt.vSlider.removeEventListener(MouseEvent.ROLL_OUT, rOut);
	menu_opt.onoff1.removeEventListener(MouseEvent.ROLL_OVER, rOver);
	menu_opt.onoff1.removeEventListener(MouseEvent.ROLL_OUT, rOut);
	menu_opt.onoff2.removeEventListener(MouseEvent.ROLL_OVER, rOver);
	menu_opt.onoff2.removeEventListener(MouseEvent.ROLL_OUT, rOut);
	menu_opt.back_btn.removeEventListener(MouseEvent.ROLL_OVER, rOver2);
	menu_opt.quit_btn.removeEventListener(MouseEvent.ROLL_OVER, rOver);
	menu_opt.quit_btn.removeEventListener(MouseEvent.ROLL_OUT, rOut);
	
	menu_opt.vSlider.removeEventListener(MouseEvent.MOUSE_DOWN, volDown);
	stage.removeEventListener(MouseEvent.MOUSE_UP, volUp);
	menu_opt.onoff1.removeEventListener(MouseEvent.CLICK, switchMP);
	menu_opt.onoff2.removeEventListener(MouseEvent.CLICK, switchFS);
	menu_opt.back_btn.removeEventListener(MouseEvent.CLICK, goBack);
	menu_opt.quit_btn.removeEventListener(MouseEvent.CLICK, quitGame);
}

function opt_ef(e:Event):void {
	opt_a += (.65-opt_a)/10;
	menu_opt.alpha = opt_a/.65;
	
	optL.clear();
	optL.beginFill(0,opt_a);
	optL.drawRect(0,0,sW,sH);
	optL.endFill();
}

function opt_ef2(e:Event):void {
	opt_a += (0-opt_a)/10;
	menu_opt.alpha = opt_a/.65;
	
	optL.clear();
	optL.beginFill(0,opt_a);
	optL.drawRect(0,0,sW,sH);
	optL.endFill();
	
	if (opt_a < .01) {
		menu_opt.alpha = 0;
		optL.clear();
		stage.removeEventListener(Event.ENTER_FRAME,opt_ef2);
		stage.addEventListener(MouseEvent.CLICK, menu_ck);
		removeChild(OPTL);
		removeChild(menu_opt);
	}
}













/////////////////////////////////////////////////////////

function menu_ck(e:MouseEvent):void {
	if (cM != -1) {
		switch (mnu[cM/amt2]) {
			case 1:
			fadeOut();
			break;
			
			case 2:
			fadeOut();
			break;
			
			case 3:
			fadeOut();
			break;
			
			case 4:
			fadeOut();
			break;
			
			case 5:
			fadeOut();
			break;
			
			case 6:
			btn_opt();
			break;
			
			default:
		}
	}
}





















































//Globals/helpers.






var clr:Array = [0x244D4A,0xCD39A9,0xF751BF,0xEBF5F4];
var cSet:Array = [[0x000000,0xaaaaaa,0xcccccc,0xffffff],
				  [0x81B19B,0x2F4842,0x2B3939,0x9DBA5D],
				  [0x262639,0xD1DCDE,0xEEFAFA,0xffffff],
				  [0x2C1F30,0x80F5FC,0xE93429,0xEBF5F4],
				  [0x000000,0x333333,0x444444,0xffffff],
				  [0x244D4A,0xCD39A9,0xF751BF,0xEBF5F4]];

var dotNum:uint = 21;
var amt:int = 13;
var amt2:int = amt * 6 + 2;

var n:int;
var n2:int;
var n3:int;

var select:Vector.<Number> = new Vector.<Number>();
var p:Vector.<Number> = new Vector.<Number>();
var mnu:Vector.<int> = new Vector.<int>(dotNum,true);

if (dotNum >= cSet.length) {
	for (n=0; n<cSet.length; n++) {
		n2 = int(Math.random()*mnu.length);
		while (n2 == 0 || mnu[n2] != 0) n2 = int(Math.random()*mnu.length);
		mnu[n2] = n+1;
	}
} else trace("ERROR: dotNum is less than menu length");

var cM:int = -1;
var lcM:int = -1;

var t_tmr:int = 0;
var tti:int = -1;
var titles:Array = ["VERSE","FORM","FELT","VEIL","CYCLE","OPTIONS"];
var tList:Array = [ttl0,ttl1,ttl_2,ttl3,ttl4,ttl5];
for (n=0; n<tList.length; n++) tList[n].alpha = 0;

function newBub(x:Number=0,y:Number=Math.PI,xs:Number=Math.PI,ys:Number=0):void {
	p.push(x,y);
	n=0;
	var n:int=0;
	while (n < amt) {
		n++;
		p.push(50*Math.cos(Math.PI*2*n/amt),50*Math.sin(Math.PI*2*n/amt));
		if (y == Math.PI) {
			x = Math.random()*sW;
			y = Math.random()*sH;
			if (x > sW*y/sH) {
				if (x > sW*(1-y/sH)) p.push(sW,y+50*Math.sin(Math.PI*2*n/amt));
				else p.push(x+50*Math.cos(Math.PI*2*n/amt),0);
			} else {
				if (x < sW*(1-y/sH)) p.push(0,y+50*Math.sin(Math.PI*2*n/amt));
				else p.push(x+50*Math.cos(Math.PI*2*n/amt),sH);
			}
		} else p.push(x+Math.random()*10*Math.cos(Math.PI*2*n/amt),y+Math.random()*10*Math.sin(Math.PI*2*n/amt));
		
		if (xs == Math.PI) p.push(30*(Math.random()-.5),30*(Math.random()-.5));
		else p.push(xs,ys);
	}
	select.push(0);
}

function pPoly(i1:int, x:Number, y:Number):Boolean {
	var n:int = 0;
	var n2:int = 0;
	var c:Boolean = false;
	n2 = i1+amt2-6;
	for (n=i1+2; n<i1+amt2; n) {
		if (((p[n+3] > y) != (p[n2+3] > y)) && (x < (p[n2+2]-p[n+2])*(y-p[n+3])/(p[n2+3]-p[n+3]) + p[n+2])) c = !c;
		n2 = n;
		n += 6;
	}
	return c;
}

var L:Shape = new Shape();
var l:Graphics = L.graphics;
addChild(L);
var xd:Number, yd:Number, d:Number;
var ax:Number,  ay:Number;

var flw:Number = .035;
var tm:int = -20;

var mx:Number, my:Number;

function ef(e:Event):void {	
	if (cM/amt2 > 0 && mnu[cM/amt2] != 0) Mouse.cursor = MouseCursor.BUTTON;
	else Mouse.cursor = MouseCursor.ARROW;
	
	if (tti != -1) {
		clr[0] = mvClr2(clr[0],cSet[tti][0],12);
		clr[1] = mvClr2(clr[1],cSet[tti][1],10);
		clr[2] = mvClr2(clr[2],cSet[tti][2],10);
		clr[3] = mvClr2(clr[3],cSet[tti][3],10);
	}
	
	for (n=0; n<tList.length; n++) {
		if (n == tti) tList[n].alpha += (1-tList[n].alpha)/10;
		else tList[n].alpha -= tList[n].alpha/10;
	}
		
	for (n=0; n<select.length; n++) {
		if (cM != -1 && n == cM/amt2) select[n] += (1-select[n])/10;
		else select[n] -= select[n]/10;
	}
	
	if (++tm > 3 && p.length/amt2 < dotNum) {
		xd = (Math.random()-.5)*(sW/5);
		yd = (Math.random()-.5)*(sH/5);
		d = Math.sqrt(xd*xd+yd*yd);
		newBub(sW*.5+xd,sH*.5+yd,xd/20,yd/20);
		tm = 0;
	}
	
	l.clear();
	for (n=0; n<p.length; n+=amt2) {
		for (n2=n+2; n2<n+amt2; n2+=6) {
			if (cM == n) {
				xd = (p[n]+p[n2]*2) - p[n2+2];
				yd = (p[n+1]+p[n2+1]*2) - p[n2+3];
			} else {
				xd = (p[n]+p[n2]) - p[n2+2];
				yd = (p[n+1]+p[n2+1]) - p[n2+3];
			}
			p[n2+4] += xd/100;
			p[n2+5] += yd/100;
		}
	}
	
	cM = -1;	
	for (n=0; n<p.length; n+=amt2) {
		if (pPoly(n,mouseX,mouseY)) {
			cM = n;
		}
		
		ax = ay = 0;
		for (n2=n+2; n2<n+amt2; n2+=6) {
			p[n2+2] += p[n2+4];
			p[n2+3] += p[n2+5];
			
			n3 = n2-2; if (n3 == n2) n3 = n*amt2-4;
			p[n3]   += p[n2+4]*flw*.5;
			p[n3+1] += p[n2+5]*flw*.5;
			n3 = n2+6; if (n3 >= amt2) n3 = n+2;
			n3 += 2;
			p[n3]   += p[n2+4]*flw*.5;
			p[n3+1] += p[n2+5]*flw*.5;
			p[n2+4] *= (1-flw);
			p[n2+5] *= (1-flw);
			
			for (n3=0; n3<p.length; n3+=amt2) {
				if (n != n3 && pPoly(n3,p[n2+2],p[n2+3])) {
					xd = p[n3+0] - p[n2+2];
					yd = p[n3+1] - p[n2+3];
					d = Math.sqrt(xd*xd+yd*yd);
					p[n2+4] -= .5*xd/d;
					p[n2+5] -= .5*yd/d;
				}
			}
			
			if (p[n2+2] > sW) {
				p[n2+2] = sW;
				p[n2+4] = 0;
			} else if (p[n2+2] < 0) {
				p[n2+2] = 0;
				p[n2+4] = 0;
			}
			if (p[n2+3] > sH) {
				p[n2+3] = sH;
				p[n2+5] = 0;
			} else if (p[n2+3] < 0) {
				p[n2+3] = 0;
				p[n2+5] = 0;
			}
			
			ax += p[n2+2];
			ay += p[n2+3];
		}
		
		ax /= amt;
		ay /= amt;
		d = int(Math.random()*(p.length/amt2))*amt2;
		if (d != n) {
			xd = p[d] - ax;
			yd = p[d+1] - ay;
			d = Math.sqrt(xd*xd+yd*yd);
			p[n] = ax+5*xd/d;
			p[n+1] = ay+5*yd/d;
		} else {
			p[n] = ax;
			p[n+1] = ay;
		}
	}
	
	if (lcM != cM) {
		if (cM != -1 && mnu[cM/amt2] != 0) {
			if (tti != mnu[cM/amt2]-1) {
				menu_newNote(menu_scale[tti+1]-12, 2.5-Math.random(), p[cM]/sW);
				menu_newNote(menu_scale[tti+3]-12, 2.5-Math.random(), p[cM]/sW);
				menu_newNote(menu_scale[tti+5]-12, 2.5-Math.random(), p[cM]/sW);
			} else {
				menu_newNote(menu_scale[int(Math.random()*menu_scale.length)], 1.5-Math.random(), p[cM]/sW);
			}
			tti = mnu[cM/amt2]-1;
		}
		lcM = cM;
	}
	
	for (n=0; n<p.length; n+=amt2) {
		for (n2=n+amt2; n2<p.length; n2+=amt2) {
			xd = p[n] - p[n2];
			yd = p[n+1] - p[n2+1];
			d = Math.sqrt(xd*xd+yd*yd);
			if (d < 50) {
				if (Math.random() < .1) menu_newNote(menu_scale[int(Math.random()*menu_scale.length)], 1.5-Math.random(), (p[n2]+xd*.5)/sW);
				p[n] = .5*(p[n]+p[n2]) + 50*xd/d;
				p[n+1] = .5*(p[n+1]+p[n2+1]) + 50*yd/d;
				p[n2] = .5*(p[n]+p[n2]) - 50*xd/d;
				p[n2+1] = .5*(p[n+1]+p[n2+1]) - 50*yd/d;
			}
		}
	}
	
	l.beginFill(clr[0]);
	l.drawRect(0,0,sW,sH);
	l.endFill();
	for (n=0; n<p.length; n+=amt2) {
		if (n != cM && mnu[n/amt2] == 0) {
			l.beginFill(cTran(clr[1],clr[2],n/p.length));
			l.moveTo(.5*(p[n+amt2-4]+p[n+4]), .5*(p[n+amt2-3]+p[n+5]));
			for (n2=n+2; n2<n+amt2-6; n2+=6) {
				l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n2+8]),.5*(p[n2+3]+p[n2+9]));
			}
			l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n+4]),.5*(p[n2+3]+p[n+5]));
			l.endFill();
		}
	}
	//cTran(cTran(cSet[mnu[n/amt2]-1][1],cSet[mnu[n/amt2]-1][2],n/p.length),cSet[mnu[n/amt2]-1][3],0*select[n/amt2]));
	for (n=0; n<p.length; n+=amt2) {
		if (mnu[n/amt2] != 0) {
			l.lineStyle(2,clr[3]);
			l.beginFill(clr[0]);
			l.moveTo(.5*(p[n+amt2-4]+p[n+4]), .5*(p[n+amt2-3]+p[n+5]));
			for (n2=n+2; n2<n+amt2-6; n2+=6) {
				l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n2+8]),.5*(p[n2+3]+p[n2+9]));
			}
			l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n+4]),.5*(p[n2+3]+p[n+5]));
			l.endFill();
		}
	}
	if (cM != -1) {
		n = cM;
		l.lineStyle(1,clr[3],0);
		l.beginFill(cTran(cTran(clr[1],clr[2],n/p.length),clr[3],0*select[n/amt2]));
		l.moveTo(.5*(p[n+amt2-4]+p[n+4]), .5*(p[n+amt2-3]+p[n+5]));
		for (n2=n+2; n2<n+amt2-6; n2+=6) {
			l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n2+8]),.5*(p[n2+3]+p[n2+9]));
		}
		l.curveTo(p[n2+2],p[n2+3],.5*(p[n2+2]+p[n+4]),.5*(p[n2+3]+p[n+5]));
		l.endFill();
	}
}

/////////////////////////////////////////////////////////

function RGBtoHSV(clr:uint):Array
{
	var r:int = clr >> 16;
	var g:int = (clr >> 8) & 0xff;
	var b:int = clr & 0xff;
	
	var max:uint = Math.max(r, g, b);
	var min:uint = Math.min(r, g, b);
	 
	var hue:Number = 0;
	var saturation:Number = 0;
	var value:Number = 0;
	 
	var hsv:Array = [];
	 
	//get Hue
	if(max == min){
		hue = 240;
	}else if(max == r){
		hue = (60 * (g-b) / (max-min) + 360) % 360;
	}else if(max == g){
		hue = (60 * (b-r) / (max-min) + 120);
	}else if(max == b){
		hue = (60 * (r-g) / (max-min) + 240);
	}
	 
	//get Value
	value = max;
	 
	//get Saturation
	if(max == 0){
		saturation = 0;
		}else{
		saturation = (max - min) / max;
	}
	 
	hsv = [Math.round(hue), Math.round(saturation * 100), Math.round(value / 255 * 100)];
	return hsv;
}

function HSVtoRGB(HSV:Array):uint
{
	var h:Number = HSV[0];
	var s:Number = HSV[1];
	var v:Number = HSV[2];
	
	var r:Number = 0;
	var g:Number = 0;
	var b:Number = 0;
	var rgb:Array = [];
	 
	var tempS:Number = s / 100;
	var tempV:Number = v / 100;
	 
	var hi:int = Math.floor(h/60) % 6;
	var f:Number = h/60 - Math.floor(h/60);
	var p:Number = (tempV * (1 - tempS));
	var q:Number = (tempV * (1 - f * tempS));
	var t:Number = (tempV * (1 - (1 - f) * tempS));
	
	switch(hi)
	{
		case 0: r = tempV; g = t; b = p; break;
		case 1: r = q; g = tempV; b = p; break;
		case 2: r = p; g = tempV; b = t; break;
		case 3: r = p; g = q; b = tempV; break;
		case 4: r = t; g = p; b = tempV; break;
		case 5: r = tempV; g = p; b = q; break;
	}
	 
	return (r*255) << 16 | (g*255) << 8 | b*255;
}

function cTran(c1:uint, c2:uint, p:Number):uint {
	var C1:Array = RGBtoHSV(c1);
	var C2:Array = RGBtoHSV(c2);
	
	C1[0] = C1[0] + p*(C2[0]-C1[0]);
	C1[1] = C1[1] + p*(C2[1]-C1[1]);
	C1[2] = C1[2] + p*(C2[2]-C1[2]);
	
	return HSVtoRGB(C1);
}

function mvClr(c1:uint, c2:uint, p:Number):uint {
	var C1:Array = RGBtoHSV(c1);
	var C2:Array = RGBtoHSV(c2);
	
	C1[0] += (C2[0]-C1[0])/p;
	C1[1] += (C2[1]-C1[1])/p;
	C1[2] += (C2[2]-C1[2])/p;
	
	return HSVtoRGB(C1);
}

function mvClr2(c1:uint, c2:uint, p:Number):uint {
	var C1:Array = RGBtoHSV(c1);
	var C2:Array = RGBtoHSV(c2);
	
	var amt:Number = .01;
	
	if (C1[0] != C2[0]) {
		if (Math.abs((C2[0]-C1[0])/p) < amt) {
			if (C1[0]+amt*((C2[0]-C1[0])/p)/Math.abs((C2[0]-C1[0])/p)<C2[0] != C1[0]<C2[0]) C1[0] = C2[0];
			else C1[0] += amt*((C2[0]-C1[0])/p)/Math.abs((C2[0]-C1[0])/p);
		} else C1[0] += (C2[0]-C1[0])/p;
	}
	
	if (C1[1] != C2[1]) {
		if (Math.abs((C2[1]-C1[1])/p) < amt) {
			if (C1[1]+amt*((C2[1]-C1[1])/p)/Math.abs((C2[1]-C1[1])/p)<C2[1] != C1[1]<C2[1]) C1[1] = C2[1];
			else C1[1] += amt*((C2[1]-C1[1])/p)/Math.abs((C2[1]-C1[1])/p);
		} else C1[1] += (C2[1]-C1[1])/p;
	}
	
	if (C1[2] != C2[2]) {
		if (Math.abs((C2[2]-C1[2])/p) < amt) {
			if (C1[2]+amt*((C2[2]-C1[2])/p)/Math.abs((C2[2]-C1[2])/p)<C2[2] != C1[2]<C2[2]) C1[2] = C2[2];
			else C1[2] += amt*((C2[2]-C1[2])/p)/Math.abs((C2[2]-C1[2])/p);
		} else C1[2] += (C2[2]-C1[2])/p;
	}
	
	return HSVtoRGB(C1);
}

function color(fromColor:uint, toColor:uint, progress:Number):uint
{
    var q:Number = 1-progress;
    var fromA:uint = (fromColor >> 24) & 0xFF;
    var fromR:uint = (fromColor >> 16) & 0xFF;
    var fromG:uint = (fromColor >>  8) & 0xFF;
    var fromB:uint =  fromColor        & 0xFF;

    var toA:uint = (toColor >> 24) & 0xFF;
    var toR:uint = (toColor >> 16) & 0xFF;
    var toG:uint = (toColor >>  8) & 0xFF;
    var toB:uint =  toColor        & 0xFF;

    var resultA:uint = fromA*q + toA*progress;
    var resultR:uint = fromR*q + toR*progress;
    var resultG:uint = fromG*q + toG*progress;
    var resultB:uint = fromB*q + toB*progress;
    var resultColor:uint = resultA << 24 | resultR << 16 | resultG << 8 | resultB;
    return resultColor; 
}























































//{ region FELT


//FELT//////////////////////////////////////////////////

function felt_fadeOut():void {
	fading = 0;
	addChild(OPTL);
	stage.removeEventListener(Event.ENTER_FRAME,ef2);
	stage.removeEventListener(MouseEvent.MOUSE_DOWN,md2);
	stage.removeEventListener(MouseEvent.MOUSE_DOWN,md);
	stage.addEventListener(Event.ENTER_FRAME,felt_fade_ef);
	//mySound.addEventListener(SampleDataEvent.SAMPLE_DATA,sineWaveGenerator);
}

var fading:uint = 0;
var END:uint = 120;
function felt_fade_ef(e:Event):void {
	fading++;
	optL.clear();
	optL.beginFill(0x262639,fading/END);
	optL.drawRect(0,0,sW,sH);
	optL.endFill();
	
	////////
	
	newBranch2();
	
	l.clear();
	
	for (n=0; n<xv.length; n++) {
		temp = [];
		for (n2=0; n2<v[sv[n]].length; n2+=2) {
			xd = xv[n] - v[sv[n]][n2];
			yd = yv[n] - v[sv[n]][n2+1];
			if (temp.length == 0 || xd*xd+yd*yd < temp[0]) {
				temp = [xd*xd+yd*yd, xd, yd];
			}
		}
		
		temp = rv[n] - Math.atan2(temp[1],temp[2])*C - offset;
		while (temp > 180) temp -= 360;
		while (temp < -180) temp += 360;
		
		if (temp < limit || temp > -limit) {
			if (temp < 0) rv[n] -= rs;
			else rv[n] += rs;
		}
		
		if (rv[n] < -180) rv[n] += 360;
		else if (rv[n] > 180) rv[n] -= 360;
		
		ttl--;
		if (er[n]) {
			l.lineStyle(1.5,0x262639);
			ttl--;
		} else l.lineStyle(.1,0xEDF8F8);
		
		l.moveTo(xv[n],yv[n]);
		xv[n] += s*Math.sin(rv[n]*Ci);
		yv[n] += s*Math.cos(rv[n]*Ci);
		l.lineTo(xv[n],yv[n]);
		
		if (lv[n]++ > kill) {
			xv.splice(n,1);
			yv.splice(n,1);
			rv.splice(n,1);
			sv.splice(n,1);
			lv.splice(n,1);
			er.splice(n,1);
			n--;
		}
	}
	bitMappin();
	l.clear();
	
	if (ttl2 != 0 && ttl2 > ttl) {
		ttl2 = ttl/ttl2;
		for (n=0; n<5; n++) {
			for (n2=0; n2<441; n2++) {
				nList[n][n2] *= ttl2;
				nListr[n][n2] *= ttl2;
			}
		}
	}
	ttl2 = ttl;
	
	if (fading >= END) {
		stage.removeEventListener(Event.ENTER_FRAME,felt_fade_ef);
		mySound.removeEventListener(SampleDataEvent.SAMPLE_DATA,sineWaveGenerator);
		tempBitmap.fillRect(tempBitmap.rect,0x262639);
		//bitmapHolder = new Bitmap(tempBitmap);
		init_menu();
	}
}

var v:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>();

var temp:*;

var felt_amt:int = 60*(sW*sH)/(1280*800);

function newSet():void {
	temp = [Math.random()*sW,Math.random()*sH];
	var n:uint = v.length;
	var n2:uint = 0;
	v.push(new Vector.<Number>());
	while (++n2 < felt_amt) {
		temp[2] = Math.random()*sW;
		temp[3] = Math.random()*sH;
		temp[4] = Math.random()*sW;
		temp[5] = Math.random()*sH;
		if (Math.random()<.5 || (temp[2]-temp[0])*(temp[2]-temp[0])+(temp[3]-temp[1])*(temp[3]-temp[1]) > (temp[4]-temp[0])*(temp[4]-temp[0])+(temp[5]-temp[1])*(temp[5]-temp[1])) v[n].push(temp[2],temp[3]);
		else v[n].push(temp[4],temp[5]);
	}
}

newSet();

var xv:Vector.<Number> = new Vector.<Number>();
var yv:Vector.<Number> = new Vector.<Number>();
var rv:Vector.<Number> = new Vector.<Number>();
var sv:Vector.<uint> = new Vector.<uint>();
var lv:Vector.<uint> = new Vector.<uint>();
var er:Vector.<Boolean> = new Vector.<Boolean>();

function newBranch(x:Number=100, y:Number=100, r:Number=0, s:uint=0):void {
	xv.push(x);
	yv.push(y);
	rv.push(r);
	sv.push(s);
	lv.push(0);
	er.push(false);
	lateSpawn.push([1000,x,y,r,s,0]);
}

var lateSpawn:Array = new Array();
function newBranch2():void {
	for (var n:int=0; n<lateSpawn.length; n++) {
		if (lateSpawn[n][0] <= 0) {
			xv.push(lateSpawn[n][1]);
			yv.push(lateSpawn[n][2]);
			rv.push(lateSpawn[n][3]);
			sv.push(lateSpawn[n][4]);
			lv.push(lateSpawn[n][5]);
			er.push(true);
			lateSpawn.splice(n,1);
			n--;
		} else lateSpawn[n][0]--;
	}
}

const C:Number = 180/Math.PI;
const Ci:Number = 1/C;

var s:Number = 1;
var rs:Number = 3;
var limit:uint = 45;
var kill:uint = 1000;
var offset:uint = 100;

var ttl:int = 0;
var ttl2:Number = 0;


//stage.addEventListener(Event.ENTER_FRAME,ef2);
function ef2(e:Event):void {
	newBranch2();
	
	l.clear();
	
	for (n=0; n<xv.length; n++) {
		temp = [];
		for (n2=0; n2<v[sv[n]].length; n2+=2) {
			xd = xv[n] - v[sv[n]][n2];
			yd = yv[n] - v[sv[n]][n2+1];
			if (temp.length == 0 || xd*xd+yd*yd < temp[0]) {
				temp = [xd*xd+yd*yd, xd, yd];
			}
		}
		
		temp = rv[n] - Math.atan2(temp[1],temp[2])*C - offset;
		while (temp > 180) temp -= 360;
		while (temp < -180) temp += 360;
		
		if (temp < limit || temp > -limit) {
			if (temp < 0) rv[n] -= rs;
			else rv[n] += rs;
		}
		
		if (rv[n] < -180) rv[n] += 360;
		else if (rv[n] > 180) rv[n] -= 360;
		
		ttl--;
		if (er[n]) {
			l.lineStyle(1.5,0x262639);
			ttl--;
		} else l.lineStyle(.1,0xEDF8F8);
		
		l.moveTo(xv[n],yv[n]);
		xv[n] += s*Math.sin(rv[n]*Ci);
		yv[n] += s*Math.cos(rv[n]*Ci);
		l.lineTo(xv[n],yv[n]);
		
		if (lv[n]++ > kill) {
			xv.splice(n,1);
			yv.splice(n,1);
			rv.splice(n,1);
			sv.splice(n,1);
			lv.splice(n,1);
			er.splice(n,1);
			n--;
		}
	}
	bitMappin();
	l.clear();
	
	if (ttl2 != 0 && ttl2 > ttl) {
		ttl2 = ttl/ttl2;
		for (n=0; n<5; n++) {
			for (n2=0; n2<441; n2++) {
				nList[n][n2] *= ttl2;
				nListr[n][n2] *= ttl2;
			}
		}
	}
	ttl2 = ttl;
}

addChild(L);

//stage.addEventListener(MouseEvent.MOUSE_DOWN,md);
function md(e:MouseEvent):void {
	//soundAt(mouseX);
	ttl += 30000;
	for (n=0; n<10; n++) newBranch(mouseX,mouseY,Math.random()*360);
}


//} endregion

////////////////////////////////////////////

function bitMappin():void {
	tempBitmap.draw(L, new Matrix());
	//bitmapHolder = new Bitmap(tempBitmap);
}

var tempBitmap:BitmapData=new BitmapData(sW,sH,true,0x00000000);
var bitmapHolder:Bitmap=new Bitmap(tempBitmap);
addChild(bitmapHolder);

function efla(x:int, y:int, x2:int, y2:int, color:uint, bmd:BitmapData):void {
	var shortLen:int = y2-y;
	var longLen:int = x2-x;

	if ((shortLen ^ (shortLen >> 31)) - (shortLen >> 31) > (longLen ^ (longLen >> 31)) - (longLen >> 31)) {
		shortLen ^= longLen;
		longLen ^= shortLen;
		shortLen ^= longLen;

		var yLonger:Boolean = true;
	} else {
		yLonger = false;
	}

	var inc:int = longLen < 0 ? -1 : 1;
	var multDiff:Number = longLen == 0 ? shortLen : shortLen / longLen;

	if (yLonger) {
		for (var i:int = 0; i != longLen; i += inc) {
			bmd.setPixel(x + i*multDiff, y+i, color);
		}
	} else {
		for (i = 0; i != longLen; i += inc) {
			bmd.setPixel(x+i, y+i*multDiff, color);
		}
	}
}

/////////////////////////////////////////////////////////

var tone:Vector.<Number> = new Vector.<Number>();
//for (n=0; n<440; n++) tone.push(Math.random()-.5);
tone.push(-1.3395151625996673,-1.337176644969368,-1.3349259833455636,-1.3326668029090718,-1.3303402001256472,-1.3279099383424355,-1.3253532553139327,-1.3226551893958896,-1.3198051042955508,-1.316794582035627,-1.3136161634801937,-1.3102626111634215,-1.3067264921126935,-1.3029999554749738,-1.2990746279358045,-1.294941579878533,-1.2905913337502124,-1.2860138974653983,-1.2811988125905382,-1.2761352112069788,-1.2708118778125743,-1.2652173140531124,-1.2593398048864126,-1.2531674852273804,-1.2466884063565338,-1.2398906014913846,-1.2327621499756551,-1.2252912395684927,-1.217466226333444,-1.2092756916452203,-1.200708495856453,-1.1917538281989546,-1.1824012525350196,-1.1726407486235682,-1.162462748622571,-1.151858168611961,-1.1408184349888648,-1.1293355056581063,-1.1174018860142623,-1.1050106397857316,-1.0921553948851435,-1.0788303444827503,-1.0650302435891088,-1.0507504014993354,-1.0359866705125107,-1.0207354313955437,-1.0049935761101607,-0.988758488363945,-0.9720280225808919,-0.9548004819132493,-0.9370745959340342,-0.91884949865828,-0.9001247075405304,-0.8809001040862994,-0.8611759166961713,-0.8409527063330665,-0.8202313555662075,-0.7990130614998708,-0.777299333041579,-0.755091992903593,-0.7323931846641062,-0.7092053851412462,-0.685531422254743,-0.6613744984679485,-0.6367382198178368,-0.6116266304538258,-0.5860442525189276,-0.5599961311200702,-0.5334878840496943,-0.5065257558391426,-0.4791166756471796,-0.45126831841536497,-0.42298916865713043,-0.39428858619029494,-0.36517687307439267,-0.3356653409754049,-0.30576637815200053,-0.2754935152397536,-0.24486148900341076,-0.21388630323233562,-0.18258528597077683,-0.15097714230242204,-0.11908200194742377,-0.0869214609791468,-0.05451861702651671,-0.021898097395091513,0.010913920385293393,0.043889695997523404,0.07699992208433654,0.11021372854208253,0.14349869550693514,0.17682087508869374,0.21014482181826222,0.24343363168913204,0.27664898959230894,0.30975122486960976,0.3426993746434883,0.37545125452373834,0.40796353624359755,0.44019183174073534,0.47209078317292597,0.5036141583441825,0.5347149510148012,0.5653454855778788,0.5954575256049065,0.625002385793189,0.6539310468870329,0.68219427319157,0.709742732351194,0.7365271171221627,0.7624982689290796,0.7876073030557095,0.8118057353798535,0.8350456106177154,0.8572796320932918,0.8784612930908345,0.8985450098815392,0.9174862565376419,0.9352417016566499,0.9517693471143304,0.9670286689465042,0.9809807604261399,0.9935884773536038,1.004816585514446,1.014631910181465,1.0230034874470348,1.0299027170692578,1.0353035164032243,1.0391824748686698,1.0415190082800907,1.0422955122375928,1.0414975136493712,1.0391138193327702,1.0351366605235373,1.0295618320153115,1.022388824556673,1.0136209490542265,1.0032654510699464,0.9913336140618998,0.9778408498016472,0.9628067744108774,0.9462552684954936,0.9282145199182621,0.9087170478415806,0.8877997067896785,0.8655036696238213,0.8418743884934977,0.8169615330191989,0.7908189051758264,0.7635043305770361,0.7350795261065995,0.7056099440993493,0.6751645935374373,0.6438158389931279,0.6116391783127375,0.578713000293058,0.5451183238471633,0.5109385203864883,0.47625902135630105,0.4411670130482394,0.40575112097295135,0.37010108620495547,0.3343074362080929,0.29846115271137574,0.2626533392303001,0.22697489081707783,0.1915161685747358,0.1563666813852818,0.12161477718249714,0.0873473459473675,0.05364953642133133,0.020604488322591166,-0.011706918382597043,-0.043206295854324846,-0.07381796136711954,-0.1034691301570073,-0.1320900876551263,-0.15961434091769952,-0.1859787493393215,-0.211123635003647,-0.23499287327797788,-0.2575339644915169,-0.278698087747176,-0.29844013810023134,-0.31671874849079723,-0.3334962979386222,-0.34873890759630805,-0.36241642630961934,-0.37450240735066376,-0.3849740779716836,-0.3938123033749744,-0.4010015466097003,-0.40652982579138025,-0.41038866989745904,-0.4125730742260374,-0.4130814564183831,-0.41191561374350655,-0.4090806821293835,-0.4045850972050766,-0.3984405573958667,-0.39066198889439835,-0.3812675121195171,-0.37027840907549037,-0.357719090841954,-0.3436170642631376,-0.3280028967671915,-0.31091017813576133,-0.292375477962751,-0.27243829749132414,-0.2511410145007851,-0.22852881993058816,-0.20464964497720964,-0.17955407748017277,-0.15329526652471212,-0.1259288143283532,-0.09751265464445859,-0.06810691710444831,-0.037773777128383604,-0.006577291256996192,0.025416782007153263,0.058141175520300174,0.09152732040710672,0.12550556574508592,0.16000540997490556,0.19495574276401703,0.23028509584256995,0.2659219011410316,0.30179475439174747,0.3378326822148308,0.3739654105947496,0.4101236325697582,0.4462392729033167,0.48224574748570154,0.5180782152254163,0.5536738202334673,0.5889719221782372,0.6239143127932087,0.658445416652316,0.692512474485934,0.7260657074917948,0.7590584612964327,0.7914473284408235,0.823192248495233,0.854256585149306,0.8846071798704224,0.914214381972634,0.9430520551864497,0.9710975610628284,0.9983317197796474,1.024738749142493,1.050306182781033,1.075024768734897,1.0988883497967037,1.1218937271327198,1.1440405088321375,1.1653309451429383,1.1857697522350346,1.205363926389418,1.2241225505454087,1.2420565951470395,1.2591787152148286,1.275503045531581,1.2910449957716612,1.3058210473238578,1.3198485534602031,1.3331455443887883,1.3457305385997829,1.3576223617726557,1.3688399743612976,1.3794023088146627,1.3893281172260408,1.398635830036525,1.4073434262499973,1.415468315450313,1.4230272317485837,1.4300361396316794,1.436510151534319,1.4424634568183257,1.447909261715508,1.4528597396768164,1.4573259914712595,1.4613180142947935,1.4648446790829515,1.4679137151721413,1.4705317014237802,1.4727040629130337,1.474435072289873,1.475727854944166,1.4765843971480836,1.4770055564073834,1.476991073327094,1.476539584385435,1.4756486351109006,1.4743146932695035,1.4725331617902324,1.4702983912845877,1.4676036921482818,1.4644413463673074,1.4608026192839911,1.4566777717086987,1.452056072886827,1.4469258149459705,1.441274329552027,1.4350880075930474,1.4283523227834451,1.4210518601366273,1.4131703502892758,1.4046907106737432,1.395595094525047,1.3858649486747898,1.3754810810254339,1.364423738514606,1.3526726962707647,1.3402073585294172,1.32700687172433,1.3130502499925178,1.2983165131373724,1.2827848368836776,1.2664347150344766,1.2492461329061784,1.231199751178691,1.2122770990557694,1.1924607753914858,1.1717346562062179,1.1500841067944225,1.1274961964213133,1.1039599134209734,1.0794663783488296,1.0540090527109867,1.02758394069554,1.0001897812700973,0.9718282279882637,0.9425040138681466,0.9122250987695967,0.8810027968048845,0.848851881469826,0.8157906663782463,0.781841059720421,0.7470285908431514,0.7113824076619226,0.6749352439598114,0.6377233559982799,0.5997864282558174,0.5611674485150536,0.5219125529304294,0.48207084211938367,0.44169416972270414,0.4008369052665707,0.35955567352241075,0.3179090728938562,0.2759573756562002,0.2337622131268763,0.19138624905052476,0.1488928446350758,0.10634571877298303,0.06380860702248163,0.02134492290698616,-0.020982574982786904,-0.0631121067277019,-0.10498318248372725,-0.14653689860091987,-0.1877162157778466,-0.22846621687638355,-0.26873434235577043,-0.3084706016403836,-0.34762775910531657,-0.3861614937398446,-0.42403053192364265,-0.46119675311700853,-0.497625268617595,-0.5332844738662412,-0.5681460750881735,-0.6021850913287913,-0.6353798331821253,-0.6677118597125145,-0.6991659152348025,-0.7297298477450911,-0.7593945108834302,-0.7881536513632593,-0.8160037838221593,-0.842944055037377,-0.8689760994109699,-0.8941038875669647,-0.9183335698205001,-0.9416733161804702,-0.9641331544365825,-0.9857248077626816,-1.0064615331441007,-1.0263579618107572,-1.0454299427323597,-1.0636943901096663,-1.0811691356779747,-1.0978727865272069,-1.1138245890379534,-1.1290442994350696,-1.1435520613699743,-1.1573682908594767,-1.170513568832257,-1.1830085414634726,-1.1948738284125495,-1.206129939018321,-1.2167971964484665,-1.2268956697459896,-1.2364451136636385,-1.245464916127207,-1.2539740531202705,-1.2619910507359093,-1.2695339540953854,-1.2766203027897394,-1.283267112458166,-1.2894908620773013,-1.2953074864987253,-1.3007323737387226,-1.3057803664953047,-1.3104657673433688,-1.3148023470403316,-1.3188033553622236,-1.3224815338846139,-1.325849130124271,-1.3289179124664778,-1.3316991853195395,-1.334203803962318,-1.3364421885823958,-1.3384243370414521,-1.3401598359501612,-1.3416578696867814,-1.342927227050862,-1.3439763053052936,-1.3448131114252986,-1.3454452604408575,-1.3458799708283748,-1.3461240569769797,-1.3461839188235378,-1.3460655288170997,-1.3457744164369743,-1.345315650547842,-1.3446938199293021,-1.3439130123650762,-1.3429767927179703,-1.3418881804499485,-1.340649627071747
);
tone.push(tone[0]);

var env:Vector.<Number> = new Vector.<Number>();
env.push(0.47974243164062497,0.71844482421875,0.8392486572265625,0.82158203125,0.8480926513671874,0.8510406494140625,0.8392486572265625,0.82158203125,0.7685394287109375,0.7655914306640624,0.730194091796875,0.6889862060546874,0.6742462158203124,0.63299560546875,0.5976409912109375,0.5799316406249999,0.5622650146484375,0.5386810302734375,0.51806640625,0.5033477783203124,0.48565979003906246,0.47091979980468746,0.467950439453125,0.44438781738281247,0.4355438232421875,0.4237518310546875,0.40903320312499997,0.3972412109375,0.3825225830078125,0.3766265869140625,0.37073059082031246,0.3648345947265625,0.35599060058593746,0.3530426025390625,0.34419860839843747,0.34125061035156246,0.3353546142578125,0.32947998046875,0.326531982421875,0.326531982421875,0.3235626220703125,0.31768798828125,0.3176666259765625,0.314739990234375,0.3117919921875,0.3117919921875,0.3117919921875,0.30884399414062497,0.30884399414062497,0.30884399414062497,0.30884399414062497,0.30589599609375,0.30884399414062497,0.30884399414062497,0.30884399414062497,0.30589599609375,0.30589599609375,0.30589599609375,0.30884399414062497,0.30589599609375,0.30884399414062497,0.30884399414062497,0.30884399414062497,0.30884399414062497,0.30884399414062497,0.30884399414062497,0.30884399414062497,0.30884399414062497,0.30884399414062497,0.30884399414062497,0.30884399414062497,0.30589599609375,0.30589599609375,0.30884399414062497,0.30589599609375,0.3059173583984375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30884399414062497,0.30884399414062497,0.30589599609375,0.30589599609375,0.30884399414062497,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.30589599609375,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.302947998046875,0.3029266357421875,0.3029266357421875,0.3029266357421875,0.3029052734375,0.3029052734375,0.3028839111328125,0.3028839111328125,0.3028839111328125,0.30286254882812497,0.30286254882812497,0.3028411865234375,0.3028411865234375,0.3028411865234375,0.30281982421875,0.30281982421875,0.3027984619140625,0.3027984619140625,0.3027984619140625,0.302777099609375,0.302777099609375,0.30275573730468747,0.30275573730468747,0.302734375,0.302734375,0.302734375,0.3027130126953125,0.3027130126953125,0.302691650390625,0.3053619384765625,0.302691650390625,0.3026702880859375,0.3026702880859375,0.30264892578124997,0.30264892578124997,0.30264892578124997,0.3026275634765625,0.3026275634765625,0.302606201171875,0.302606201171875,0.302606201171875,0.3025848388671875,0.3025848388671875,0.3025634765625,0.3025634765625,0.3025634765625,0.30254211425781247,0.30254211425781247,0.302520751953125,0.302520751953125,0.30499877929687497,0.3024993896484375,0.3049560546875,0.3049560546875,0.3049346923828125,0.304913330078125,0.304913330078125,0.30489196777343747,0.3048492431640625,0.30243530273437497,0.3024139404296875,0.3024139404296875,0.30478515624999997,0.3047637939453125,0.302392578125,0.3023712158203125,0.3047210693359375,0.30469970703125,0.30469970703125,0.30467834472656247,0.304656982421875,0.3046356201171875,0.3046142578125,0.3046142578125,0.3045928955078125,0.30457153320312497,0.3045501708984375,0.3045501708984375,0.30452880859375,0.3045074462890625,0.30446472167968747,0.30446472167968747,0.304443359375,0.3044219970703125,0.3044219970703125,0.304400634765625,0.3043792724609375,0.302178955078125,0.302178955078125,0.302178955078125,0.3021575927734375,0.3021575927734375,0.30213623046875,0.30213623046875,0.30213623046875,0.30211486816406247,0.30211486816406247,0.302093505859375,0.302093505859375,0.302093505859375,0.3020721435546875,0.3020721435546875,0.30205078125,0.30205078125,0.30205078125,0.3020294189453125,0.3020294189453125,0.30200805664062497,0.30200805664062497,0.30200805664062497,0.3019866943359375,0.3019866943359375,0.30196533203125,0.30196533203125,0.3019439697265625,0.3019439697265625,0.3019439697265625,0.301922607421875,0.301922607421875,0.301922607421875,0.30190124511718747,0.30190124511718747,0.3018798828125,0.3018798828125,0.3018585205078125,0.3018585205078125,0.3018585205078125,0.301837158203125,0.301837158203125,0.3018157958984375,0.3018157958984375,0.3018157958984375,0.30179443359374997,0.30179443359374997,0.3017730712890625,0.3017730712890625,0.301751708984375,0.301751708984375,0.301751708984375,0.3017303466796875,0.3017303466796875,0.301708984375,0.301708984375,0.301708984375,0.30168762207031247,0.30168762207031247,0.30168762207031247,0.301666259765625,0.301666259765625,0.3016448974609375,0.3016448974609375,0.30162353515625,0.30162353515625,0.30162353515625,0.3016021728515625,0.3016021728515625,0.30158081054687497,0.30158081054687497,0.30158081054687497,0.3015594482421875,0.3015594482421875,0.3015380859375,0.3015380859375,0.3015380859375,0.3015167236328125,0.3015167236328125,0.301495361328125,0.301495361328125,0.301495361328125,0.30147399902343747,0.30147399902343747,0.30145263671875,0.30145263671875,0.3014312744140625,0.3014312744140625,0.3014312744140625,0.301409912109375,0.301409912109375,0.3013885498046875,0.3013885498046875,0.3013885498046875,0.30136718749999997,0.30136718749999997,0.3013458251953125,0.3013458251953125,0.3013458251953125,0.301324462890625,0.301324462890625,0.3013031005859375,0.3013031005859375,0.30128173828125,0.30128173828125,0.30128173828125,0.30126037597656247,0.30126037597656247,0.301239013671875,0.301239013671875,0.301239013671875,0.3012176513671875,0.3012176513671875,0.3011962890625,0.3011962890625,0.3011962890625,0.3011749267578125,0.3011749267578125,0.30115356445312497,0.30115356445312497,0.30115356445312497,0.3011322021484375,0.3011322021484375,0.30111083984375,0.30111083984375,0.3010894775390625,0.3010894775390625,0.3010894775390625,0.301068115234375,0.301068115234375,0.301068115234375,0.30104675292968747,0.30104675292968747,0.301025390625,0.301025390625,0.301025390625,0.3010040283203125,0.3010040283203125,0.300982666015625,0.300982666015625,0.3009613037109375,0.3009613037109375,0.3009613037109375,0.30093994140624997,0.30093994140624997,0.3009185791015625,0.3009185791015625,0.3009185791015625,0.300897216796875,0.300897216796875,0.3008758544921875,0.3008758544921875,0.3008758544921875,0.3008544921875,0.3008544921875,0.30083312988281247,0.30083312988281247,0.300811767578125,0.300811767578125,0.300811767578125,0.3007904052734375,0.3007904052734375,0.3007904052734375,0.30076904296875,0.30076904296875,0.3007476806640625,0.3007476806640625,0.30072631835937497,0.30072631835937497,0.30072631835937497,0.3007049560546875,0.3007049560546875,0.30068359375,0.30068359375,0.30068359375,0.3006622314453125,0.3006622314453125,0.300640869140625,0.300640869140625,0.300640869140625,0.30061950683593747,0.30061950683593747,0.30059814453125,0.30059814453125,0.30059814453125,0.3005767822265625,0.3005767822265625,0.300555419921875,0.300555419921875,0.3005340576171875,0.3005340576171875,0.3005340576171875,0.30051269531249997,0.30051269531249997,0.3004913330078125,0.3004913330078125,0.3004913330078125,0.300469970703125,0.300469970703125,0.3004486083984375,0.3004486083984375,0.3004486083984375,0.30042724609375,0.30042724609375,0.30040588378906247,0.30040588378906247,0.30040588378906247,0.300384521484375,0.300384521484375,0.3003631591796875,0.3003631591796875,0.3003631591796875,0.300341796875,0.300341796875,0.3003204345703125,0.3003204345703125,0.3003204345703125,0.30029907226562497,0.30029907226562497,0.3002777099609375,0.3002777099609375,0.30025634765625,0.30025634765625,0.30025634765625,0.3002349853515625,0.3002349853515625,0.300213623046875,0.300213623046875,0.300213623046875,0.30019226074218747,0.30019226074218747,0.3001708984375,0.3001708984375,0.3001708984375,0.3001495361328125,0.3001495361328125,0.300128173828125,0.300128173828125,0.300128173828125,0.3001068115234375,0.3001068115234375,0.30008544921874997,0.30008544921874997,0.3000640869140625,0.3000640869140625,0.3000640869140625,0.300042724609375,0.300042724609375,0.3000213623046875,0.3000213623046875,0.3000213623046875);

var NM0:Vector.<Number> = new Vector.<Number>(441,true);
var NM1:Vector.<Number> = new Vector.<Number>(441,true);
var NM2:Vector.<Number> = new Vector.<Number>(441,true);
var NM3:Vector.<Number> = new Vector.<Number>(441,true);
var NM4:Vector.<Number> = new Vector.<Number>(441,true);
var nList:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>();
nList.push(NM0,NM1,NM2,NM3,NM4);

var NM0r:Vector.<Number> = new Vector.<Number>(441,true);
var NM1r:Vector.<Number> = new Vector.<Number>(441,true);
var NM2r:Vector.<Number> = new Vector.<Number>(441,true);
var NM3r:Vector.<Number> = new Vector.<Number>(441,true);
var NM4r:Vector.<Number> = new Vector.<Number>(441,true);
var nListr:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>();
nListr.push(NM0r,NM1r,NM2r,NM3r,NM4r);

var pList:Vector.<Number> = new Vector.<Number>(5,true);
var pRate:Vector.<Number> = new Vector.<Number>();
pRate.push(rates(0),rates(3),rates(5),rates(8),rates(10));

var BLOCK:int = 2048;//8192;
var _L:Number, R:Number;
var temp1:Number;
var temp2:int;

var mySound:Sound = new Sound();
function sineWaveGenerator(e:SampleDataEvent):void {
    for (var c:int=0; c<BLOCK; c++) {
		_L = R = 0;
		for (n=0; n<5; n++) {
			temp1 = int(pList[n]);
			_L += .1*(nList[n][temp1]+(pList[n]-temp1)*(nList[n][temp1+1]-nList[n][temp1]));
			R += .1*(nListr[n][temp1]+(pList[n]-temp1)*(nListr[n][temp1+1]-nListr[n][temp1]));
			pList[n] += pRate[n];
			if (pList[n] >= 440) pList[n] -= 440;
		}
		
		for (n=0; n<nts.length; n+=5) {
			temp1 = int(nts[n]);
			temp1 = .1*nts[n+4]*(env[int(nts[n+1])] + (nts[n]/440)*(env[int(nts[n+1])+1] - env[int(nts[n+1])])) * (tone[temp1]+(nts[n]-temp1)*(tone[temp1+1]-tone[temp1]));
			_L += temp1 * nts[n+3];
			R += temp1 * (1-nts[n+3]);
			
			nts[n] += nts[n+2];
			if (nts[n] >= 441) {
				nts[n] -= 441;
				nts[n+1] += 1/nts[n+2];
				if (nts[n+1] >= env.length-1) {
					toMemPos(noteFromRate(nts[n+2]),.3*nts[n+4],nts[n+3],nts[n]);
					nts.splice(n,5);
					n -= 5;
				}
			}
		}
		
		e.data.writeFloat(_L*(1-fading/END)*VOLUME);
        e.data.writeFloat(R*(1-fading/END)*VOLUME);
	}
	
	for (n=0; n<5; n++) {
		for (n2=0; n2<441; n2++) {
			for (c=1; c<=17; c++) {
				nListr[n][n2] = nListr[n][n2]*(1-felt_amt2*2) + nList[n][correct(int(n2*2-c))]*felt_amt2 + nList[n][correct(int(n2-c))]*felt_amt2;
				nList[n][n2] = nList[n][n2]*(1-felt_amt2*2) + nListr[n][correct(int(n2*2-c))]*felt_amt2 + nListr[n][correct(int(n2-c))]*felt_amt2;
			}
		}
	}
}

var felt_amt2:Number = .00002;
function correct(n:int):int {
	if (n < 0) n += 441;
	else if (n > 440) n -= 441;
	return n;
}

//wave pt, env pt, rt, pan
var nts:Vector.<Number> = new Vector.<Number>();

//mySound.addEventListener(SampleDataEvent.SAMPLE_DATA,sineWaveGenerator);
//mySound.play();

var N2:Number;
var scale2:Array = [0,3,5,8,10];

//stage.addEventListener(MouseEvent.MOUSE_DOWN,md2);
function md2(e:MouseEvent):void {
	var n:int = int((mouseX/sW)*16);
	var p:Number = Math.random();
	//toMem(n, 1, p);
	//toMem(n+5,.2,Math.max(0,p-.1));
	//toMem(n-5,.1,Math.min(1,p+.1));
	//wave pt, env pt, rt, v, pan
	var a:Array = [0,1,2,3,4];
	var nt:int = int(scale2.length*3*(mouseX%(sW/3))/sW);
	a.splice(nt,1);
	var nt2:int = a[int(4*mouseY/sH)];
	//a.splice(int(4*mouseY/sH),1);
	//var nt3:int = a[int(12*(mouseY%(sH/4))/sH)];
	
	nt = scale2[nt]; 
	nt2 = scale2[nt2];
	//nt3 = scale2[nt3];
	nt += 12*int(3*mouseX/sW);
	nt2 += 12*int(3*mouseX/sW);
	//nt3 += 12*int(3*mouseX/sW) - 12;
	
	xd = (mouseX+((1-mouseY/sH)*sW/3));
	nt = 12*int(3*mouseX/sW) + scale2[int(scale2.length*(mouseX%(sW/3))/(sW/3))];
	nt2 = 12*int(3*xd/sW) + scale2[int(scale2.length*(xd%(sW/3))/(sW/3))];
	
	nts.push(0,0,rates(nt),Math.random(),1);
	nts.push(0,0,rates(nt2),Math.random(),1);
	//nts.push(0,0,rates(nt3),Math.random(),.2);
}

function toMem(n:int,v:Number=1,p:Number=.5,pos:Number=-1):void {
	var m:int = n%5;
	if (m<0) m *= -1;
	if (pos == -1) N2 = pList[m];
	else N2 = pos;
	var B:Number = Math.pow(2,1+int(n/5))*.5;
	for (n=0; n<441; n++) {
		nList[m][(n2+n)%441] += toneAt(N2)*p*v;
		nListr[m][(n2+n)%441] += toneAt(N2)*(1-p)*v;
		N2 += B;
		if (N2 >= 441) N2 -= 441;
	}
}
var scale:Array = [0,0,0,1,0,2,0,0,3,0,4,0];

function toMemPos(n:int,v:Number=1,p:Number=.5,pos1:Number=0):void {
	var m:int = n%12;
	if (m<0) m = -m;
	m = scale[m];
	var B:Number = Math.pow(2,1+int(n/12))*.5;
	var pos2:int = pList[m];
	
	for (n=0; n<441; n++) {
		nList[m][(pos2+n)%441] += toneAt(pos1)*p*v;
		nListr[m][(pos2+n)%441] += toneAt(pos1)*(1-p)*v;
		pos1 += B;
		if (pos1 >= 441) pos1 -= 441;
	}
}

function noteFromRate(y:Number):int {
	return 12*Math.log(y)/Math.log(2) - .47 + 4;
}
function rates(n:int):Number {
	return Math.pow(2, (n+.47-4)/12);
}
function toneAt(n:Number):Number {
	var n2:int = int(n);
	return tone[n2]+(n-n2)*(tone[n2+1]-tone[n2]);
}











































//{ region VERSE



//VERSE/////////////////////////////////////////////////


function init_verse(redo:Boolean = false):void {
	
	//this is always true, it seems
	if (!redo) {
		
		//enum for which view we're in.
		STATE = 1;
		
		//have we hit a note this frame
		nHit = false;
		
		
		//some sort of distance scaling factor, i think.
		s = 10;
		
		//initialize arrays.
		px.length = py.length = pxs.length = pys.length = pt.length = 0;
		
		
		//number of entities...?
		dotNum = int(60 * sW / 700);
		
		//pt = dotNum ^ 2, since it's iterating via that nested for loop.
		//counts down.
		for (n = 0; n < dotNum * dotNum; n++) {
			pt.push(0);
		}
		
		
		
		//index for chord selection.
		ind = 0;
		//mouse timer --> mouse event increments chord selection.
		mTmr = -1;
		
		
		
		//initialize chord.
		setChord(chordList[ind]);
		
		
		//last mouse x and y.
		lx = mouseX;
		ly = mouseY;
		
		
		_s = new stepSequencer();
		
		
		tempBitmap = new BitmapData(sW,sH,true,0);
		bitmapHolder = new Bitmap(tempBitmap);
		addChild(bitmapHolder);
		
		
		//looks like a 95% alpha fade filter.
		filter = new ColorMatrixFilter([
			1, 0, 0, 0, 0,
			0, 1, 0, 0, 0,
			0, 0, 1, 0, 0,
			0, 0, 0, .95, 0
		]);
		
		
		stage.addEventListener(MouseEvent.MOUSE_MOVE,mm);
		stage.addEventListener(Event.ENTER_FRAME,ef_verse);
	}
	
	//never called.
	/*
	else {
		tempBitmap.fillRect(tempBitmap.rect, 0);
		tempBitmap = new BitmapData(sW,sH,true,0);
		bitmapHolder = new Bitmap(tempBitmap);
		addChild(bitmapHolder);
		dotNum = int(60*sW/700);
		px.length = py.length = pxs.length = pys.length = pt.length = 0;
		for (n=0; n<dotNum*dotNum; n++) pt.push(0);
		for (n=0; n<dotNum; n++) newDot();
	}
	*/
}




//Note sequencer.
var _s:stepSequencer;


//hm.
var i:int;

//have we hit a note this frame?
var nHit:Boolean = false;


//very mysterious.
var a:Number = .5;
var mDist:uint = 100;
var cDist:Number = 50;//Math.sqrt(471238.89803846896/(Math.PI*dotNum));


//the dots.
var px:Vector.<Number> = new Vector.<Number>();
var py:Vector.<Number> = new Vector.<Number>();

var pxs:Vector.<Number> = new Vector.<Number>();
var pys:Vector.<Number> = new Vector.<Number>();

var pt:Vector.<int> = new Vector.<int>();


var scale_verse:Array = [0,2,4,5,7,9,11,12,14,16,17,19,21,23,24,26,28,29,31,33,35,36];
var noteIndex:Array = ["e","f","f#","g","g#","a","a#","b","c","c#","d","d#","e","f","f#","g","g#","a","a#","b","c","c#","d","d#","e","f","f#","g","g#","a","a#","b","c","c#","d","d#","e"];
var chordList:Array = [",e,c,g,", ",e,b,g,"];


//index into our chord list.
var ind:uint = 0;

//mouse timer.
var mTmr:int = -1;



function setChord(c:String):void {
	var n:uint = 0;
	var n2:uint = 0;
	scale_verse = [];
	for (n = 0; n < 37; n++) {
		if (c.indexOf("," + noteIndex[n] + ",") != -1) {
			scale_verse.push(n);
		}
	}
}


//Mouse tracking variables.
var ys:Number;
var xs:Number;
var lx:Number = mouseX;
var ly:Number = mouseY;


//alpha fade filter.
var filter:ColorMatrixFilter = new ColorMatrixFilter( [
        1, 0, 0, 0, 0, 
        0, 1, 0, 0, 0, 
        0, 0, 1, 0, 0, 
        0, 0, 0, .95, 0] );


function newDot(x:Number = 0, y:Number = 0, xs:Number = 0, ys:Number = 0):void {
	//ignores the function arguments, but ok
	px.push(Math.random()*sW);
	py.push(Math.random()*sH);
	pxs.push(0);
	pys.push(0);
}


//never used.
/*
function killDot(n:int):void {
	px.splice(n,1);
	py.splice(n,1);
	pxs.splice(n,1);
	pys.splice(n,1);
	pt.splice(n,1);
}
*/


//on mouse move.
function mm(e:MouseEvent):void {
	
	//this doesn't seem to need to be a mouse event.
	if (mTmr <= 0) {
		ind++;
		ind %= chordList.length;
		setChord(chordList[ind]);
	}
	mTmr = 120;
}







function ef_verse(e:Event):void
{	
	//add dots randomly each frame, up to our defined maximum.
	if (px.length < dotNum && Math.random() < .2)
		newDot();
	
	//decrement our mouse timer.
	mTmr--;
	
	//mouse and deltas.
	xs = mouseX - lx;
	ys = mouseY - ly;
	lx = mouseX;
	ly = mouseY;
	
	//shape.graphics.
	l.clear();
	l.lineStyle(1, 0xffffff);
	
	
	for (n = 0; n < px.length; n++) {
		//for all dots, move by deltas and draw.
		l.moveTo(px[n],py[n]);
		px[n] += pxs[n];
		py[n] += pys[n];
		l.lineTo(px[n],py[n]);
			
	//wrap dots around the screen.
		if (px[n] < 0)
			px[n] += sW;
		else if (px[n] > sW)
			px[n] -= sW;
		if (py[n] < 0)
			py[n] += sH;
		else if (py[n] > sH)
			py[n] -= sH;
	}
	
	//inner loop counter...?
	i = 0;
	
	//for all dots...
	for (n = 0; n < px.length; n++) {
		//check against every dot following it...
		for (n2 = n + 1; n2 < px.length; n2++) {
			
			//delta them.
			xd = px[n] - px[n2];
			yd = py[n] - py[n2];
			
			//the distance...
			d = Math.sqrt(xd * xd + yd * yd);
			
			//if we're close enough...
			if (d < cDist) {
				
				if (d != 0) {
					pxs[n] += a*xd/d;
					pys[n] += a*yd/d;
					pxs[n2] -= a*xd/d;
					pys[n2] -= a*yd/d;
				}
				
				
				//and our timeout has fired...
				if (pt[i] <= 0) {
					
					//reset the timeout.
					pt[i] = 10;
					
					
					//draw...
					l.moveTo(px[n],py[n]);
					l.lineTo(px[n2], py[n2]);
					
					//ensure we don't play more than one note each frame.
					if (!nHit) {
						nHit = true;
						
						xd = .5 * (Math.abs(pxs[n]) + Math.abs(pxs[n2]));
						yd = .5 * (Math.abs(pys[n]) + Math.abs(pys[n2]));
						
						d = Math.sqrt(xd * xd + yd * yd);
						
						xd = (px[n] + px[n2]) * .5;
						yd = (py[n] + py[n2]) * .5;
						
						_s._sound.addTone(
							440,
							scale_verse[
								Math.max(
									0,
									int(Math.random() * 2 ) * 2 - 1 + Math.min(
										scale_verse.length - 1 - uint(scale_verse.length * yd / sH),
										scale_verse.length - 1
									)
								)
							],
							-1,
							xd / (sW * .5) - 1,
							1,
							(.2 + .8 * (d / s)) * VOLUME //s = 10.
						);
					}
				}
			}
			
			//tick down the timeout.
			if (pt[i] > 0)
				pt[i]--;
				
			//increment inner loop.
			i++;
		}
	
		
		//Handle mouse interaction with all dots.
		xd = px[n] - mouseX;
		yd = py[n] - mouseY;
		d = Math.sqrt(xd*xd+yd*yd);
		if (d < mDist) {
			//accelerate it.
			pxs[n] += .001*(mDist-d)*xs;
			pys[n] += .001*(mDist-d)*ys;
		}
		
		//move them...
		d = Math.sqrt(pxs[n] * pxs[n] + pys[n] * pys[n]);
		//s is 10...
		if (d > s) {
			pxs[n] = s*pxs[n]/d;
			pys[n] = s*pys[n]/d;
		}
		
		//quadratic deceleration..?
		pxs[n] *= .99;
		pys[n] *= .99;
	}
	
	//probably the fade.
	tempBitmap.applyFilter(tempBitmap, tempBitmap.rect, new Point(), filter);
	
	//blit our lines.
	tempBitmap.draw(L, new Matrix());
	
	
	//we can play one note each frame.
	nHit = false;
}








function verse_fade():void {
	stage.removeEventListener(MouseEvent.MOUSE_MOVE,mm);
	stage.removeEventListener(Event.ENTER_FRAME,ef_verse);
	fading = 0;
	addChild(OPTL);
	stage.addEventListener(Event.ENTER_FRAME,ef_verseFade);
}

//Duplicate block for the fading logic.
/*
function ef_verseFade(e:Event):void {
	fading++;
	optL.clear();
	optL.beginFill(0,fading/END);
	optL.drawRect(0,0,sW,sH);
	optL.endFill();
	
	////////
	
	if (px.length < dotNum && Math.random()<.2) newDot();
	mTmr--;
	
	xs = mouseX - lx;
	ys = mouseY - ly;
	lx = mouseX;
	ly = mouseY;
	
	l.clear();
	l.lineStyle(1,0xffffff);
	for (n=0; n<px.length; n++) {
		l.moveTo(px[n],py[n]);
		px[n] += pxs[n];
		py[n] += pys[n];
		l.lineTo(px[n],py[n]);
		
		if (px[n] < 0) px[n] += sW;
		else if (px[n] > sW) px[n] -= sW;
		if (py[n] < 0) py[n] += sH;
		else if (py[n] > sH) py[n] -= sH;
	}
	
	i = 0;
	for (n=0; n<px.length; n++) {
		for (n2=n+1; n2<px.length; n2++) {
			xd = px[n] - px[n2];
			yd = py[n] - py[n2];
			d = Math.sqrt(xd*xd+yd*yd);
			if (d < cDist) {
				if (d != 0) {
					pxs[n] += a*xd/d;
					pys[n] += a*yd/d;
					pxs[n2] -= a*xd/d;
					pys[n2] -= a*yd/d;
				}
				if (pt[i] <= 0) {
					l.moveTo(px[n],py[n]);
					l.lineTo(px[n2],py[n2]);
					pt[i] = 10;
					if (!nHit) {
						xd = .5*(Math.abs(pxs[n])+Math.abs(pxs[n2]));
						yd = .5*(Math.abs(pys[n])+Math.abs(pys[n2]));
						d = Math.sqrt(xd*xd+yd*yd);
						nHit = true;
						xd = (px[n]+px[n2])*.5;
						yd = (py[n]+py[n2])*.5;
						_s._sound.addTone(
							440,
							scale_verse[Math.max(0,int(Math.random()*2)*2-1+Math.min(scale_verse.length-1-uint(scale_verse.length*yd/sH),scale_verse.length-1))],
							-1,
							xd/(sW*.5)-1,
							1,
							(.2+.8*(d/s))*(1-fading/END)*VOLUME
						);
					}
				}
			}
			if (pt[i] > 0) pt[i]--;
			i++;
		}
	
		xd = px[n] - mouseX;
		yd = py[n] - mouseY;
		d = Math.sqrt(xd*xd+yd*yd);
		if (d < mDist) {
			pxs[n] += .001*(mDist-d)*xs;
			pys[n] += .001*(mDist-d)*ys;
		}
		
		d = Math.sqrt(pxs[n]*pxs[n]+pys[n]*pys[n]);
		if (d > s) {
			pxs[n] = s*pxs[n]/d;
			pys[n] = s*pys[n]/d;
		}
		
		pxs[n] *= .99;
		pys[n] *= .99;
	}
	
	tempBitmap.applyFilter(tempBitmap,tempBitmap.rect,new Point(),filter);
	tempBitmap.draw(L,new Matrix());
	//bitmapHolder=new Bitmap(tempBitmap);
	
	nHit = false;
	
	if (fading >= END) {
		stage.removeEventListener(Event.ENTER_FRAME,ef_verseFade);
		_s.stopSound();
		tempBitmap.fillRect(tempBitmap.rect,0);
		//bitmapHolder = new Bitmap(tempBitmap);
		init_menu();
	}
}
*/



//} endregion VERSE







































//CYCLE/////////////////////////////////////////////////

function cycle_fade():void {	
	stage.removeEventListener(MouseEvent.MOUSE_DOWN,md_cycle);
	stage.removeEventListener(Event.ENTER_FRAME,ef_cycle);
	stage.removeEventListener(MouseEvent.MOUSE_UP,mu);
	stage.removeEventListener(Event.ENTER_FRAME,ef2_cycle);
	
	stage.addEventListener(Event.ENTER_FRAME,ef_cycle_fade);
	
	fading = 0;
	addChild(OPTL);
}

function ef_cycle_fade(e:Event):void {
	for (var itr:int=0; itr<1; itr++) {
		l.lineStyle(.1,0xffffff,.4);
		for (n=0; n<lns.length; n+=4) {
			lx = lns[n]; ly = lns[n+1];
			d = ccl[n/4][lns[n+2]*2];
			ccl[n/4][lns[n+2]*2] *= 1.01;
			r = lns[n+3] = lns[n+3] + ccl[n/4][lns[n+2]*2+1];
			
			lns[n+2]++; 
			if (lns[n+2]*2 >= ccl[n/4].length) {
				lns[n+2] = 0;
			}
			xd = lns[n];
			yd = lns[n+1];
			lns[n] += d*Math.cos(r*Ci);
			lns[n+1] += d*Math.sin(r*Ci);
			
			if (xd < sW*.5 != lns[n] < sW*.5) {
				if (lns[n+1] > 0 && lns[n+1] < sH) {
					l.drawCircle(sW*.5,yd + (lns[n+1]-yd)*(sW*.5-xd)/(lns[n]-xd),3);
					//newNote(1-Math.abs(lns[n+1]-sH*.5)/(sH*.5));
					newNote(1+Math.random()*.7, scale_cycle[Math.min(Math.max(int(scale_cycle.length*(1-lns[n+1]/sH)),0),scale_cycle.length-1)]);
				}
			}
			
			OX += .01*d*Math.cos(r*Ci);
			OY += .01*d*Math.sin(r*Ci);
			
			xd = lns[n]; yd = lns[n+1];
			
			if ((lx > 0 && lx < sW && ly > 0 && ly < sH) || (xd > 0 && xd < sW && yd > 0 && yd < sH)) {
				l.moveTo(lx,ly);
				l.lineTo(xd,yd);
			}
		}
		
		l.lineStyle(.1,0xffffff,.01);
		l.moveTo(sW*.5,0);
		l.lineTo(sW*.5,sH);
		
		//l.moveTo(OX2,OY2);
		//l.lineTo(OX,OY);
		OX2 = OX;
		OY2 = OY;
		
		bitMappin2();
		l.clear();
	}
	
	fading++;
	optL.clear();
	optL.beginFill(0,fading/END);
	optL.drawRect(0,0,sW,sH);
	optL.endFill();
	
	if (fading >= END) {
		stage.removeEventListener(Event.ENTER_FRAME,ef_cycle_fade);
		mySound2.removeEventListener(SampleDataEvent.SAMPLE_DATA, sine);
		mySound2 = null;
		tempBitmap.fillRect(tempBitmap.rect,0);
		//bitmapHolder = new Bitmap(tempBitmap);
		init_menu();
	}
}

var _L2:Number, _R:Number;
var sineNum:Number;

var dropLimit:int = 100;
var scale_cycle:Array = [0, 2, 3, 5, 7, 8, 10,
				   12,14,15,17,19,20,22,
				   24,26,27,29,31,32,34];

var mySound2:Sound;

const cycle_rate = rate(-.2);

function sine(e:SampleDataEvent):void {
	var n2:uint;
    for (var c:int=0; c<BLOCK; c++) {
		_L2 = _R = 0;
			
		for (n=0; n<rs_vn.length; n++) {
			d = int(rs_vn[n]);
			xd = int(rs_vn[n]) - d;
			sineNum = rs_vol[n]*(rs_v[d]*(1-xd) + rs_v[d+1]*xd);
			_L2 += (1-rs_pan[n])*sineNum;
			_R += rs_pan[n]*sineNum;
			rs_vn[n] += cycle_rate;
			if (tLen - rs_vn[n]%tLen <= cycle_rate) {
				rs_vn.splice(n,1);
				rs_vol.splice(n,1);
				rs_pan.splice(n,1);
				n--;
			}
		}
		
		e.data.writeFloat(_L2*VOLUME*(1-fading/END));
		e.data.writeFloat(_R*VOLUME*(1-fading/END));
    }
}

function newNote(v:Number=-1,nt:int=-1):void {
	if (nt == -1) rs_vn.push(scale_cycle[int(Math.random()*scale_cycle.length)]*tLen);
	else rs_vn.push(nt*tLen);
	if (v == -1) rs_vol.push(Math.random()*.35);
	else rs_vol.push(.35*v);
	rs_pan.push(Math.random());//0*.5+.5);
	if (rs_vn.length > dropLimit) {
		while (rs_vn.length > dropLimit) {
			rs_vn.shift();
			rs_vol.shift();
			rs_pan.shift();
		}
	}
}

//////////////////////////////

stop();

var ccl:Array = [];
var r:Number;
var rcd:Array = [];

var MD:Boolean = false;
var od:Number = 0;

function md_cycle(e:Event):void {
	rcd = [];
	MD = true;
	newNote();
}

var LX:Number, LY:Number;
var LR:Number;

function ef_cycle(e:Event):void {
	xd = mouseX - LX;
	yd = mouseY - LY;
	LX = mouseX; LY = mouseY;
	if (MD) {
		l.lineStyle(.1,0xffffff,.4);
		l.moveTo(mouseX-xd, mouseY-yd);
		l.lineTo(mouseX, mouseY);
		bitMappin2();
		l.clear();
		d = Math.sqrt(xd*xd+yd*yd);
		rcd.push(d,(Math.atan2(yd,xd)-LR)*C);
	}
	LR = Math.atan2(yd,xd);
}

var rX:Number = 0;
var rY:Number = 0;

function mu(e:Event):void {
	l.lineStyle(.1,0xffffff,.4);
	l.moveTo(LX, LY);
	l.lineTo(mouseX, mouseY);
	bitMappin2();
	l.clear();
	
	MD = false;
	rX = rY = 0;
	while (rcd.length > 0) {
		LR -= rcd[rcd.length-1]*Ci;
		rX += rcd[rcd.length-2]*Math.cos(LR);
		rY += rcd[rcd.length-2]*Math.sin(LR);
		rcd.pop(); rcd.pop();
		if (rX*rX+rY*rY > 100) break;
	}
	xd = rX;
	yd = rY;
	d = LR;
	
	LR = rX = rY = 0;
	while (rcd.length > 0) {
		LR += rcd[1]*Ci;
		rX += rcd[0]*Math.cos(LR);
		rY += rcd[0]*Math.sin(LR);
		rcd.shift(); rcd.shift();
		if (rX*rX+rY*rY > 100) break;
	}
	
	if (rcd.length > 0) {
		ccl.push(rcd);
		lns.push(mouseX,mouseY,0,d*C);
		myNote.push(scale_cycle[int(Math.random()*scale_cycle.length)]);
	}
	newNote();
}

////////////////////////////

var OX:Number = sW*.5;
var OY:Number = sH*.5 - 200;
var OX2:Number = sW*.5;
var OY2:Number = sH*.5 - 200;

var lns:Vector.<Number> = new Vector.<Number>();

var myNote:Vector.<uint> = new Vector.<uint>();
//for (n=0; n<5; n++) newNote();

function ef2_cycle(e:Event):void {
	for (var itr:int=0; itr<1; itr++) {
		l.lineStyle(.1,0xffffff,.4);
		for (n=0; n<lns.length; n+=4) {
			lx = lns[n]; ly = lns[n+1];
			d = ccl[n/4][lns[n+2]*2];
			ccl[n/4][lns[n+2]*2] *= 1.01;
			r = lns[n+3] = lns[n+3] + ccl[n/4][lns[n+2]*2+1];
			
			lns[n+2]++; 
			if (lns[n+2]*2 >= ccl[n/4].length) {
				lns[n+2] = 0;
			}
			xd = lns[n];
			yd = lns[n+1];
			lns[n] += d*Math.cos(r*Ci);
			lns[n+1] += d*Math.sin(r*Ci);
			
			if (xd < sW*.5 != lns[n] < sW*.5) {
				if (lns[n+1] > 0 && lns[n+1] < sH) {
					l.drawCircle(sW*.5,yd + (lns[n+1]-yd)*(sW*.5-xd)/(lns[n]-xd),3);
					//newNote(1-Math.abs(lns[n+1]-sH*.5)/(sH*.5));
					newNote(1+Math.random()*.7, scale_cycle[Math.min(Math.max(int(scale_cycle.length*(1-lns[n+1]/sH)),0),scale_cycle.length-1)]);
				}
			}
			
			OX += .01*d*Math.cos(r*Ci);
			OY += .01*d*Math.sin(r*Ci);
			
			xd = lns[n]; yd = lns[n+1];
			
			if ((lx > 0 && lx < sW && ly > 0 && ly < sH) || (xd > 0 && xd < sW && yd > 0 && yd < sH)) {
				l.moveTo(lx,ly);
				l.lineTo(xd,yd);
			}
		}
		
		l.lineStyle(.1,0xffffff,.01);
		l.moveTo(sW*.5,0);
		l.lineTo(sW*.5,sH);
		
		//l.moveTo(OX2,OY2);
		//l.lineTo(OX,OY);
		OX2 = OX;
		OY2 = OY;
		
		bitMappin2();
		l.clear();
	}
}

///////////////////////////

function bitMappin2():void {
	if (++_i >= 10) {
		tempBitmap.applyFilter(tempBitmap,tempBitmap.rect,new Point(),filter);
		_i = 0;
	}
	tempBitmap.draw(L);
	//bitmapHolder = new Bitmap(tempBitmap);
}

var _i:int = 0;

//VEIL//////////////////////////////////////////////////

function veil_fade():void {
	stage.removeEventListener(MouseEvent.MOUSE_DOWN,md_veil);
	stage.removeEventListener(MouseEvent.MOUSE_UP,mu_veil);
	stage.addEventListener(Event.ENTER_FRAME,ef_veil_fade);
	stage.removeEventListener(Event.ENTER_FRAME,ef2_veil);
	fading = 0;
	addChild(OPTL);
}

function ef_veil_fade(e:Event):void {
	dp1.length = 0;
	dpc1.length = 0;
	dp2.length = 0;
	dpc2.length = 0;
	
	
	for (_n=0; _n<ptx.length; _n++) {
		xd = ptx[_n] - sW*.5;
		yd = pty[_n] - sH*.5;
		_r = Math.atan2(yd,xd)*57.29577951308232;
		d = Math.sqrt(xd*xd+yd*yd);
		
		fp = (flws[ptpt[_n]]-.2)/3.8;
		
		if (pta[_n] == 1) {
			drawShape1(shLib[_n], 
					   sW*.5+sz_tm*(200+fp*400)*d*Math.cos(0.017453292519943295*360*_r),
					   sH*.5+sz_tm*(200+fp*400)*d*Math.sin(0.017453292519943295*360*_r),
					   sz_tm*.035*(100-ptpt[_n])*Math.sin(ptt[_n]*0.017453292519943295)*(.5+fp*.5)
			);
		} else {
			drawShape2(shLib[_n], 
					   sW*.5+sz_tm*(200+fp*400)*d*Math.cos(0.017453292519943295*360*_r),
					   sH*.5+sz_tm*(200+fp*400)*d*Math.sin(0.017453292519943295*360*_r),
					   sz_tm*.035*(100-ptpt[_n])*Math.sin(ptt[_n]*0.017453292519943295)*(.5+fp*.5)
			);
		}
	}
	
	fp = (flw_veil-.2)/3.8;
	
	l.beginFill(clr_veil(clrs[0][0],clrs[0][1],clrs[0][2]));
	l.drawPath(dpc1, dp1, "nonZero");
	l.endFill();
	l2.beginFill(clr_veil(clrs[1][0],clrs[1][1],clrs[1][2]));
	l2.drawPath(dpc2, dp2, "nonZero");
	l2.endFill();
	
	bitMappin3();
	
	fading++;
	optL.clear();
	optL.beginFill(cSet[3][0],fading/END);
	optL.drawRect(0,0,sW,sH);
	optL.endFill();
	
	if (fading >= END) {
		st1.volume = 0;
		sc1.soundTransform = st1;
		st2.volume = 0;
		sc2.soundTransform = st2;
		snd1 = null; sc1 = null; st1 = null;
		snd2 = null; sc2 = null; st2 = null;
		mySound_veil.removeEventListener(SampleDataEvent.SAMPLE_DATA, sine2);
		mySound_veil = null;
		myTimer.removeEventListener(TimerEvent.TIMER, timerListener);
		myTimer = null;
		stage.removeEventListener(Event.ENTER_FRAME,ef_veil_fade);
		tempBitmap.fillRect(tempBitmap.rect,0);
		//bitmapHolder = new Bitmap(tempBitmap);
		init_menu();
	}
}

var _L3:Number, _R3:Number;
var sineNum2:Number;

var echo:int = 44100*.1;
var sineMemL:Vector.<Number> = new Vector.<Number>(echo,true);
var sineMemR:Vector.<Number> = new Vector.<Number>(echo,true);
var memi:int = 0;
var memi2:Number = 0;

var dn:Boolean = false;

function sine2(e:SampleDataEvent):void {
	var n2:uint;
    for (var c:int=0; c<BLOCK; c++) {
		_L3 = _R3 = 0;
			
		for (n=0; n<rs_vn2.length; n++) {
			sineNum2 = rs_vol2[n]*rs_v2[rs_vn2[n]];
			_L3 += (1-rs_pan2[n])*sineNum2;
			_R3 += rs_pan2[n]*sineNum2;
			if (++rs_vn2[n]%tLen2 == 0) {
				rs_vn2.splice(n,1);
				rs_vol2.splice(n,1);
				rs_pan2.splice(n,1);
				n--;
			}
		}
		
		memi2 += .5; if (memi2 >= echo) memi2 -= echo;
		memi++; if (memi >= echo) memi -= echo;
		
		if (dn) {
			sineMemL[memi] += sineMemL[int(memi2)]*.1;
			sineMemR[memi] += sineMemR[int(memi2)]*.1;
			sineMemL[memi] += sineMemL[int(memi*1.5)%echo]*.1;
			sineMemR[memi] += sineMemR[int(memi*1.5)%echo]*.1;
			
			sineMemL[memi] = sineMemL[memi]*.9 + sineMemR[memi]*.1;
			sineMemR[memi] = sineMemR[memi]*.9 + sineMemL[memi]*.1;
			
			sineMemL[memi] = sineMemL[memi]*.6 + _L3;
			sineMemR[memi] = sineMemR[memi]*.6 + _R3;
			sineMemL[memi] = sineMemL[(memi+1)%echo]*.5 + sineMemL[memi]*.5;
			sineMemR[memi] = sineMemR[(memi+1)%echo]*.5 + sineMemR[memi]*.5;
		} else {
			sineMemL[memi] += sineMemL[int(memi2)]*.1;
			sineMemR[memi] += sineMemR[int(memi2)]*.1;
			sineMemL[memi] += sineMemL[int(memi*1.5)%echo]*.1;
			sineMemR[memi] += sineMemR[int(memi*1.5)%echo]*.1;
			
			sineMemL[memi] = sineMemL[memi]*.9 + sineMemR[memi]*.1;
			sineMemR[memi] = sineMemR[memi]*.9 + sineMemL[memi]*.1;
			
			sineMemL[memi] = sineMemL[memi]*.9;
			sineMemR[memi] = sineMemR[memi]*.9;
			sineMemL[memi] = sineMemL[(memi+1)%echo]*.7 + sineMemL[memi]*.3;
			sineMemR[memi] = sineMemR[(memi+1)%echo]*.7 + sineMemR[memi]*.3;
		}
		
		e.data.writeFloat(sineMemL[memi]*2*VOLUME*(1-fading/END));
		e.data.writeFloat(sineMemR[memi]*2*VOLUME*(1-fading/END));
    }
}

function rate(n:Number):Number {
	return Math.pow(2,n/12);
}

//var dropLimit:int = 100;
//B, C#, E, F#, G, A
var scale_veil:Array = [0, 2, 5, 7, 8, 10,
				   12,14,17,19,20,22,
				   24,26,29,31,32,34];

var wheelA:Array = [2,  14, 26,
					7,  19, 31,
					5,  17, 29];
var wheelB:Array = [0,  12, 24,
					8,  20, 32,
					10, 22, 34];

var wia:Vector.<Number> = new Vector.<Number>(wheelA.length, true);
var wib:Vector.<Number> = new Vector.<Number>(wheelB.length, true);

//stage.addEventListener(MouseEvent.CLICK,ck);
function ck(e:MouseEvent):void {
	 newNote2();
}

function newNote2(v:Number=-1,nt:int=-1):void {
	if (nt == -1) rs_vn2.push(scale_veil[int(Math.random()*scale_veil.length)]*tLen2);
	else rs_vn2.push(nt*tLen2);
	if (v == -1) rs_vol2.push(Math.random());
	else rs_vol2.push(v);
	rs_pan2.push(Math.random());//0*.5+.5);
	if (rs_vn2.length > dropLimit) {
		while (rs_vn2.length > dropLimit) {
			rs_vn2.shift();
			rs_vol2.shift();
			rs_pan2.shift();
		}
	}
}

var snd1:Sound;
var snd2:Sound;

var sc1:SoundChannel = new SoundChannel();
var sc2:SoundChannel = new SoundChannel();

var st1:SoundTransform = new SoundTransform();
var st2:SoundTransform = new SoundTransform();

var mySound_veil:Sound;

var L2:Shape = new Shape();
var l2:Graphics = L2.graphics;

var shLib:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>();

function newShape3(i:int):Vector.<Number> {
	var shape:Vector.<Number> = new Vector.<Number>();
	var d:Number = .1 + 5*(Math.random()-.5);
	var r:Number = 5+Math.random()*35;
	
	while (r < 360) {
		shape.push((d*.9)+5, r*0.017453292519943295);
		r += 5+Math.random()*35;
		d += 45*(Math.random()-.65);
		if (d < 0) d = -d;
	}
	
	shape[0] = shape[shape.length-2]+45*(Math.random()-.5);
	shape[2] = shape[0]+45*(Math.random()-.5);
	shape[4] = (shape[2]+shape[6])*.5;
	shape[4] += 45*(Math.random()-.5);
	if (shape[4] < 0) shape[4] *= -1;
	
	for (var n:int=shape.length; n>0; n-=2) {
		shape.push(shape[0]*Math.cos(shape[1]),
				   shape[0]*Math.sin(shape[1]));
		shape.shift(); shape.shift();
	}
	
	return shape;
}

function drawShape1(s:Vector.<Number>, x:Number, y:Number, sz:Number):void {
	dp1.push(x + (s[0]+s[s.length-2])*.5*sz, y + (s[1]+s[s.length-1])*.5*sz);
	dpc1.push(1);
	for (var n:uint=2; n<s.length; n+=2) {
		dp1.push(x+sz*s[n-2], y+sz*s[n-1], x + sz*.5*(s[n-2]+s[n]), y + sz*.5*(s[n-1]+s[n+1]));
		dpc1.push(3);
	}
	dp1.push(x + sz*s[n-2], y + sz*s[n-1], x + sz*.5*(s[n-2]+s[0]), y + sz*.5*(s[n-1]+s[1]));
	dpc1.push(3);
}
function drawShape2(s:Vector.<Number>, x:Number, y:Number, sz:Number):void {
	dp2.push(x + (s[0]+s[s.length-2])*.5*sz, y + (s[1]+s[s.length-1])*.5*sz);
	dpc2.push(1);
	for (var n:uint=2; n<s.length; n+=2) {
		dp2.push(x+sz*s[n-2], y+sz*s[n-1], x + sz*.5*(s[n-2]+s[n]), y + sz*.5*(s[n-1]+s[n+1]));
		dpc2.push(3);
	}
	dp2.push(x + sz*s[n-2], y + sz*s[n-1], x + sz*.5*(s[n-2]+s[0]), y + sz*.5*(s[n-1]+s[1]));
	dpc2.push(3);
}

////////////////////////////////////////////////////////

var ptpt:Vector.<int> = new Vector.<int>();
//x,y,xs,ys,t,a
var ptx:Vector.<Number> = new Vector.<Number>();
var pty:Vector.<Number> = new Vector.<Number>();
var ptxs:Vector.<Number> = new Vector.<Number>();
var ptys:Vector.<Number> = new Vector.<Number>();
var ptt:Vector.<Number> = new Vector.<Number>();
var pta:Vector.<Number> = new Vector.<Number>();

function newPt():void {
	var n:uint = ptx.length;
	ptx[n] = sW*.5 + (Math.random()-.5);
	pty[n] = sH*.5 + (Math.random()-.5);
	ptxs[n] = 0;
	ptys[n] = 0;
	ptt[n] = 0;
	pta[n] = uint(Math.random()*2);
	shLib.push(newShape3(pta[n]));
	
	xd = sW*.5 - ptx[n];
	yd = sH*.5 - pty[n];
	ptpt.push(int(100*Math.sqrt(xd*xd+yd*yd)/Math.sqrt(.5)));
}

var rs_veil:Vector.<Number> = new Vector.<Number>(100,true);
var rs2:Vector.<Number> = new Vector.<Number>(100,true);
var flws:Vector.<Number> = new Vector.<Number>(100,true);

var _n:int;
var _r:Number;

var clrs:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>();
clrs.push(new Vector.<Number>(), new Vector.<Number>());
clrs[0].push(51/360,0.567,0.988);
clrs[1].push(26/360,0.951,0.953);
var clr2:Vector.<Number> = new Vector.<Number>(3,true);
clr2[0] = 0.567;
clr2[1] = 0.951;
clr2[2] = 0.382;
var bgc:Vector.<Number> = new Vector.<Number>(3,true);

var cs1:Number = .0017;
var cs2:Number = .0007;

var t:uint;

var age:Number = 1000000;

var dp1:Vector.<Number> = new Vector.<Number>();
var dp2:Vector.<Number> = new Vector.<Number>();
var dpc1:Vector.<int> = new Vector.<int>();
var dpc2:Vector.<int> = new Vector.<int>();

var myTimer:Timer;
function timerListener (e:TimerEvent):void {
	ef_veil();
}

var flmt:Number = 3.5;
var flw_veil:Number = .2;
var spawn:Number = 0;
var fp:Number = (flw_veil-.2)/(flmt-.2);
var wt:uint = 0;

function ef_veil():void {
	age = 1032860-Math.random()*32860;
	
	spawn += flw_veil;
	while (spawn >= 3) {
		spawn -= 3;
		if (Math.random()<.3) newPt();
	}
	
	clrs[0][0] = (clrs[0][0]+(cs1+cs2)*.5) % 1;
	clrs[1][0] = (clrs[1][0]+cs1) % 1;
	bgc[0] = (bgc[0]+cs2) % 1;
	
	clrs[0][1] = clr2[0]*fp;
	clrs[1][1] = clr2[1]*fp;
	bgc[1] = clr2[2]*fp;
	
	clrs[1][2] = 0.988-.55*(1-fp);
	bgc[2] = 0.216*fp;
	
	for (_n=0; _n<ptx.length; _n++) {
		xd = ptx[_n] - sW*.5;
		yd = pty[_n] - sH*.5;
		_r = Math.atan2(yd,xd)*57.29577951308232;
		d = Math.sqrt(xd*xd+yd*yd);
		
		ptt[_n] += flws[ptpt[_n]];
		
		ptx[_n] += rs_veil[ptpt[_n]]*yd/d;
		pty[_n] -= rs_veil[ptpt[_n]]*xd/d;
		
		if (ptt[_n] > 180) {
			ptx.splice(_n,1);
			pty.splice(_n,1);
			ptxs.splice(_n,1);
			ptys.splice(_n,1);
			ptt.splice(_n,1);
			pta.splice(_n,1);
			ptpt.splice(_n,1);
			shLib.splice(_n,1);
			_n--;
		}
	}
	
	if (dn) {
		xd = sW*.5 - lx;
		yd = sH*.5 - ly;
		d = Math.atan2(yd,xd)*57.29577951308232;
		
		xd = sW*.5 - cx;
		yd = sH*.5 - cy;
		d = Math.atan2(yd,xd)*57.29577951308232 - d;
		_n = int(200*Math.sqrt(xd*xd+yd*yd)/Math.sqrt(sW*sW*.25+sH*sH*.25));
		
		if (_n < 100) {
			while (d > 180) d -= 360;
			while (d < -180) d += 360;
			
			rs_veil[_n] -= d*d*d*.00000003;
		}
	}
	
	if (dn) flws[0] = 3.5;
	else flws[0] += (0.2-flws[0])/7;
	
	flw_veil = flws[0];
	for (_n=1; _n<flws.length; _n++) {
		flws[_n] += (flws[_n-1]-flws[_n])/1.3;
		flw_veil += flws[_n];
	}
	flw_veil /= flws.length;
	fp = (flw_veil-.2)/3.8;
	
	v1 = v2 = 0;
	for (n=1; n<rs_veil.length-1; n++) {
		rs2[n] = (rs_veil[n] + rs_veil[n-1] + rs_veil[n+1])/3;
		
		if (n <= 25) v1 += rs2[n];
		else if (n < 75) v2 += rs2[n];
	}
	if (dn) {
		for (n=0; n<rs_veil.length; n++) {
			rs_veil[n] = rs2[n]*.999;
			if (rs_veil[n] > 0.0001) rs_veil[n] = 0.0001;
			else if (rs_veil[n] < -0.0001) rs_veil[n] = -0.0001;
		}
	} else {
		for (n=0; n<rs_veil.length; n++) rs_veil[n] = rs2[n];
	}
	
	AR = 0;
	AR2 = 0;
	for (_n=0; _n<rs_veil.length; _n++) {
		AR2 += Math.abs(rs_veil[_n]);
		if (Math.abs(rs_veil[_n]) > Math.abs(AR)) AR = rs_veil[_n];
		if (rs_veil[_n] > 0) wia[int(wia.length*_n/rs_veil.length)] += rs_veil[_n];
		else wib[int(wib.length*_n/rs_veil.length)] -= rs_veil[_n];
	}
	
	AR2 *= 30;
	if (dn) {
		if (AR > 0) {
			st1.volume += (VOLUME*(1-fading/END)*AR2-st1.volume)/50;
			sc1.soundTransform = st1;
			st2.volume -= st2.volume/50;
			sc2.soundTransform = st2;
		} else {
			st2.volume += (VOLUME*(1-fading/END)*AR2-st2.volume)/50;
			sc2.soundTransform = st2;
			st1.volume -= st1.volume/50;
			sc1.soundTransform = st1;
		}
	} else {
		st2.volume -= st2.volume/10;
		sc2.soundTransform = st2;
		st1.volume -= st1.volume/10;
		sc1.soundTransform = st1;
	}
	
	if (dn) {
		for (_n=0; _n<wia.length; _n++) {
			if (wia[_n] > amt_veil) {
				newNote2(1.5*(1-Math.random()*.7), wheelA[int(Math.random()*wheelA.length)]);
				newNote2(1.5*(.5*(1-Math.random()*.7)), wheelA[int(Math.random()*wheelA.length)]);
				wia[_n] = wia[_n]%amt_veil;
			}
			if (wib[_n] > amt_veil) {
				newNote2(1.5*(1-Math.random()*.7), wheelB[int(Math.random()*wheelB.length)]);
				newNote2(1.5*(.5*(1-Math.random()*.7)), wheelB[int(Math.random()*wheelB.length)]);
				wib[_n] = wib[_n]%amt_veil;
			}
		}
	}
	
	lx = cx;
	ly = cy;
	cx = mouseX;
	cy = mouseY;
}

var AR:Number = 0;
var AR2:Number = 0;

var amt_veil:Number = .015;

var v1:Number = 0;
var v2:Number = 0;

function ef2_veil(e:Event):void {
	dp1.length = 0;
	dpc1.length = 0;
	dp2.length = 0;
	dpc2.length = 0;
	
	
	for (_n=0; _n<ptx.length; _n++) {
		xd = ptx[_n] - sW*.5;
		yd = pty[_n] - sH*.5;
		_r = Math.atan2(yd,xd)*57.29577951308232;
		d = Math.sqrt(xd*xd+yd*yd);
		
		fp = (flws[ptpt[_n]]-.2)/3.8;
		
		if (pta[_n] == 1) {
			drawShape1(shLib[_n], 
					   sW*.5+sz_tm*(200+fp*400)*d*Math.cos(0.017453292519943295*360*_r),
					   sH*.5+sz_tm*(200+fp*400)*d*Math.sin(0.017453292519943295*360*_r),
					   sz_tm*.035*(100-ptpt[_n])*Math.sin(ptt[_n]*0.017453292519943295)*(.5+fp*.5)
			);
		} else {
			drawShape2(shLib[_n], 
					   sW*.5+sz_tm*(200+fp*400)*d*Math.cos(0.017453292519943295*360*_r),
					   sH*.5+sz_tm*(200+fp*400)*d*Math.sin(0.017453292519943295*360*_r),
					   sz_tm*.035*(100-ptpt[_n])*Math.sin(ptt[_n]*0.017453292519943295)*(.5+fp*.5)
			);
		}
	}
	
	fp = (flw_veil-.2)/3.8;
	
	l.beginFill(clr_veil(clrs[0][0],clrs[0][1],clrs[0][2]));
	l.drawPath(dpc1, dp1, "nonZero");
	l.endFill();
	l2.beginFill(clr_veil(clrs[1][0],clrs[1][1],clrs[1][2]));
	l2.drawPath(dpc2, dp2, "nonZero");
	l2.endFill();
	
	bitMappin3();
}

var cx:Number = mouseX;
var cy:Number = mouseY;
lx = mouseX; ly = mouseY;

var MY:uint = 0;
var MX:uint = 0;

function md_veil(e:MouseEvent):void {
	dn = true;
	MX = uint(4*mouseX/sW);
	MY = uint(4*mouseY/sH);
	newNote2(1);
	newNote2(1);
	newNote2(1);
}
function mu_veil(e:MouseEvent):void {
	dn = false;
}

////////////////////////////////////////////////////////

function clr_veil(h:Number,s:Number,v:Number):uint {
	var r:Number, g:Number, b:Number;
	var i:int;
	var f:Number, p:Number, q:Number, t:Number;
	
	if (s == 0) {
		v = int(v*255 + .5);
		return (v << 16) | (v << 8) | v;
	}
	
	h *= 6;
	i = int(h);
	f = h - i;
	p = v * (1 - s);
	q = v * (1 - s * f);
	t = v * (1 - s * (1 - f));
	
	switch (i) {
		case 0:
			r = v;
			g = t;
			b = p;
			break;
		case 1:
			r = q;
			g = v;
			b = p;
			break;
		case 2:
			r = p;
			g = v;
			b = t;
			break;
		case 3:
			r = p;
			g = q;
			b = v;
			break;
		case 4:
			r = t;
			g = p;
			b = v;
			break;
		default: //case 5:
			r = v;
			g = p;
			b = q;
			break;
	}
	return (int(r*255 + .5) << 16) | (int(g*255 + .5) << 8) | int(b*255 + .5);
}

////////////////////////////////////////////////

var M:Matrix = new Matrix();

const thir:Number = 360/13;

function bitMappin3():void {
	M = null;
	M = new Matrix();
	tempBitmap.fillRect(tempBitmap.rect, 0xff000000 + clr_veil(bgc[0],bgc[1],bgc[2]));
	
	for (n=0; n<12; n++) {
		tempBitmap.draw(L2, M);
		M.translate( -sW*.5, -sH*.5);
		M.rotate(27.692307692307693*0.017453292519943295);
		M.translate(sW*.5, sH*.5); 
	}
	tempBitmap.draw(L2, M);
	
	for (n=0; n<7; n++) {
		tempBitmap.draw(L, M);
		M.translate( -sW*.5, -sH*.5);
		M.rotate(45*0.017453292519943295);
		M.translate(sW*.5, sH*.5); 
	}
	tempBitmap.draw(L, M);
	
	l.clear();
	l2.clear();
	
	//bitmapHolder = null;
	//bitmapHolder = new Bitmap(tempBitmap);
}

//FORM//////////////////////////////////////////////////

function form_fade():void {
	stage.removeEventListener(Event.ENTER_FRAME,rend);
	stage.removeEventListener(MouseEvent.MOUSE_DOWN,ck_form);
	stage.removeEventListener(MouseEvent.MOUSE_UP,mu_form);
	
	newTran("l1",5,0);
	newTran("l2",5,0);
	newTran("l3",5,0);
	newTran("l4",5,0);
	newTran("l5",5,0);
	newTran("l6",5,0);
	newTran("l7",5,0);
	newTran("l8",5,0);
	
	stage.addEventListener(Event.ENTER_FRAME,ef_form_fade);
	fading = 0;
	addChild(OPTL);
}

function ef_form_fade(e:Event):void {
	rend(e);
	
	fading++;
	optL.clear();
	optL.beginFill(0,fading/END);
	optL.drawRect(0,0,sW,sH);
	optL.endFill();
	
	if (fading >= END) {
		killTrack(trackAt("l1"));
		killTrack(trackAt("l2"));
		killTrack(trackAt("l3"));
		killTrack(trackAt("l4"));
		killTrack(trackAt("l5"));
		killTrack(trackAt("l6"));
		killTrack(trackAt("l7"));
		killTrack(trackAt("l8"));
		l.clear();
		l2.clear();
		removeChild(L3);
		removeChild(L4);
		stage.removeEventListener(Event.ENTER_FRAME,tef);
		stage.removeEventListener(Event.ENTER_FRAME,snd_ef);
		stage.removeEventListener(Event.ENTER_FRAME,msc_mng);
		stage.removeEventListener(Event.ENTER_FRAME,ef_form_fade);
		init_menu();
	}
}

var sw:Number = sW/100;
var sh:Number = sH/100;
var sz:Number = 1200;

var cz:Number = 0;

var crx:Number;
var cry:Number;

var m1:Number;
var m2:Number;
var b1:Number;
var b2:Number;

var zd:Number;

var sz_tm:Number;

function pt2D(x:Number,y:Number,z:Number):Array {
	var xPos:Number = 0;
	var yPos:Number = 0;
	
	m1 = ((y - cy)/(x - cx));
	xPos = (cy - m1*cx - sz) / m1;
	
	m1 = ((y - cy)/(z - cz));
	yPos = (cy - m1*cz - sz) / m1;
	
	return [sz_tm*xPos*Math.min(sW/700,sH/500), sz_tm*yPos*Math.min(sW/700,sH/500)];
}

var L3:Shape = new Shape();
var l3:Graphics = L3.graphics;

var L4:Shape = new Shape();
var l4:Graphics = L4.graphics;

var plane:Array = [[-50,-200,100],[50,-200,100],[-50,-300,100],[-50,-200,-100],[50,-200,-100],[-50,-300,-100]];
var plane2:Array;
var pts:Array;

var spX:Number = 0;
var spY:Number = 0;
var spZ:Number = 0;

var drawPlane:Boolean = false;

var toDraw:Array = new Array();
var tPt:Vector.<Number> = new Vector.<Number>(3,true);

function rend(e:Event):void {
	sz_tm += (1-sz_tm)/70;
	
	l.clear();
	l2.clear();
	l3.clear();
	l4.clear();
	l2.lineStyle(1);
	
	curPlane = -1;
	
	toDraw = [];
	
	for (n2=0; n2<shape.length; n2++) {
		plane2 = shape[n2];
		
		xd = yd = zd = 0;
		for (n=0; n<plane2.length; n++) {
			xd += plane2[n][0];
			yd += plane2[n][1];
			zd += plane2[n][2];
		}
		xd /= plane2.length;
		yd /= plane2.length;
		zd /= plane2.length;
		pts = [];
		pts.push(pt2D(xd, yd, zd));
		pts.push(pt2D(spX, spY, spZ));
		tPt[0] = xd;
		tPt[1] = yd;
		tPt[2] = zd;
		
		trail[n2].push(pts[0][0],pts[0][1]);
		//l2.moveTo(trail[n2][0]+(sW*.5),trail[n2][1]+(sH*.5));
		//l2.lineTo(trail[n2][2]+(sW*.5),trail[n2][3]+(sH*.5));
		trail[n2].splice(0,2);
		
		l2.lineStyle(1,0xDD2020,.5);
		l2.moveTo(pts[1][0] + (sW*.5), pts[1][1] + (sH*.5));
		l2.lineTo(pts[0][0] + (sW*.5), pts[0][1] + (sH*.5));
		pts = [xd,yd,zd];
		xd = pts[0] - spX;
		yd = pts[1] - spY;
		zd = pts[2] - spZ;//3
		pts.push(Math.sqrt(xd*xd + yd*yd + zd*zd));
		xd = cx - spX;
		yd = cy - spY;
		zd = cz - spZ;//4
		pts.push(Math.sqrt(xd*xd + yd*yd + zd*zd));
		xd = pts[0] - cx;
		yd = pts[1] - cy;
		zd = pts[2] - cz;//5
		pts.push(Math.sqrt(xd*xd + yd*yd + zd*zd));
		d = Math.sqrt(pts[3]*pts[3] + pts[5]*pts[5]);
		drawPlane = d < pts[4];
		
		l2.lineStyle(1,0xF4B640,.3);
		
		if (light[n2] > 0) {
			light[n2] -= .004;
			if (light[n2] < 0) light[n2] = 0;
		}
		
		toDraw.push([1-(pts[4]-d)/pts[3], n2]);
		
		//0x9DA33D
		//0x4A653A
		if (drawPlane) {
			//yd = clrMix(0x335147, 0xB6CC5B, light[n2]);
			//zd = clrMix(0x292B32, 0x4A8468, light[n2]);
			//xd = clrMix(yd, zd, 1-(pts[4]-d)/pts[3]);
			//d = clrMix(0x335147, 0x292B32, 1-(pts[4]-d)/pts[3]);
			//l.beginFill(xd);
			//l.lineStyle(1,xd);
			//l.lineStyle(1,0xff0000);
			
			testP = [];
			for (n=0; n<plane2.length; n++) {
				if (n == 0) {
					pts = pt2D(plane2[4][0],plane2[4][1],plane2[4][2]);
					testP.push(pts);
					//l.moveTo(pts[0]+(sW*.5), pts[1]+(sH*.5));
					//l2.moveTo(pts[0]+(sW*.5), pts[1]+(sH*.5));
					pts = pt2D(plane2[n][0],plane2[n][1],plane2[n][2]);
					testP.push(pts);
					//l.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5)-1);
					//l2.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5)-1);
				} else {
					pts = pt2D(plane2[n][0],plane2[n][1],plane2[n][2]);
					testP.push(pts);
					//l.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5)-1);
					//l2.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5)-1);
				}
			}
			
			if (pPoly_form(testP,mouseX-(sW*.5),mouseY-(sH*.5))) curPlane = n2;
			
			l.endFill();
		}
	}
	
	toDraw = toDraw.sort(drawSort);
	for (n=0; n<toDraw.length; n++) {
		if (toDraw[n][0] >= 1) {
			plane2 = shape[toDraw[n][1]];
			
			tPt[0] = plane2[0][0];
			tPt[1] = plane2[0][1];
			tPt[2] = plane2[0][2];
			for (n2=0; n2<plane2.length; n2++) {
				tPt[0] += plane2[n2][0];
				tPt[1] += plane2[n2][1];
				tPt[2] += plane2[n2][2];
			}
			tPt[0] *= .2;
			tPt[1] *= .2;
			tPt[2] *= .2;
			
			xd = tPt[0] - spX;
			yd = tPt[1] - spY;
			zd = tPt[2] - spZ;
			d = Math.sqrt(xd*xd+yd*yd+zd*zd);
			ofx = xd/d;
			ofy = yd/d;
			ofz = zd/d;
			ofd = 200*light[toDraw[n][1]];
			
			for (n2=0; n2<plane2.length; n2++) {
				l3.lineStyle(1,0x4A8468);
				if (n2 == 0) {
					l3.beginFill(0x4A8468);
					pts = pt2D(plane2[4][0]+ofx*ofd, plane2[4][1]+ofy*ofd, plane2[4][2]+ofz*ofd);
					l3.moveTo(pts[0]+(sW*.5), pts[1]+(sH*.5));
					
					pts = pt2D(plane2[0][0]+ofx*ofd, plane2[0][1]+ofy*ofd, plane2[0][2]+ofz*ofd);
					l3.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5)-1);
					
					pts = pt2D(plane2[0][0], plane2[0][1], plane2[0][2]);
					l3.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5)-1);
					
					pts = pt2D(plane2[4][0], plane2[4][1], plane2[4][2]);
					l3.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5));
					l3.endFill();
				} else {
					l3.beginFill(0x4A8468);
					pts = pt2D(plane2[n2-1][0]+ofx*ofd, plane2[n2-1][1]+ofy*ofd, plane2[n2-1][2]+ofz*ofd);
					l3.moveTo(pts[0]+(sW*.5), pts[1]+(sH*.5));
					
					pts = pt2D(plane2[n2][0]+ofx*ofd, plane2[n2][1]+ofy*ofd, plane2[n2][2]+ofz*ofd);
					l3.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5)-1);
					
					pts = pt2D(plane2[n2][0], plane2[n2][1], plane2[n2][2]);
					l3.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5)-1);
					
					pts = pt2D(plane2[n2-1][0], plane2[n2-1][1], plane2[n2-1][2]);
					l3.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5));
					l3.endFill();
				}
			}
		} else {
			plane2 = shape[toDraw[n][1]];
			
			tPt[0] = plane2[0][0];
			tPt[1] = plane2[0][1];
			tPt[2] = plane2[0][2];
			for (n2=0; n2<plane2.length; n2++) {
				tPt[0] += plane2[n2][0];
				tPt[1] += plane2[n2][1];
				tPt[2] += plane2[n2][2];
			}
			tPt[0] *= .2;
			tPt[1] *= .2;
			tPt[2] *= .2;
			
			xd = tPt[0] - spX;
			yd = tPt[1] - spY;
			zd = tPt[2] - spZ;
			d = Math.sqrt(xd*xd+yd*yd+zd*zd);
			ofx = xd/d;
			ofy = yd/d;
			ofz = zd/d;
			ofd = 200*light[toDraw[n][1]];
			
			if (ofd > 0) {
				l4.lineStyle(1, clrMix(0xB6CC5B, 0x4A8468, toDraw[n][0]));
				for (n2=0; n2<plane2.length; n2++) {
					if (n2 == 0) {
						l4.beginFill(clrMix(0xB6CC5B, 0x4A8468, toDraw[n][0]));
						pts = pt2D(plane2[4][0]+ofx*ofd, plane2[4][1]+ofy*ofd, plane2[4][2]+ofz*ofd);
						l4.moveTo(pts[0]+(sW*.5), pts[1]+(sH*.5));
						
						pts = pt2D(plane2[0][0]+ofx*ofd, plane2[0][1]+ofy*ofd, plane2[0][2]+ofz*ofd);
						l4.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5)-1);
						
						pts = pt2D(plane2[0][0], plane2[0][1], plane2[0][2]);
						l4.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5)-1);
						
						pts = pt2D(plane2[4][0], plane2[4][1], plane2[4][2]);
						l4.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5));
						l4.endFill();
					} else {
						l4.beginFill(clrMix(0xB6CC5B, 0x4A8468, toDraw[n][0]));
						pts = pt2D(plane2[n2-1][0]+ofx*ofd, plane2[n2-1][1]+ofy*ofd, plane2[n2-1][2]+ofz*ofd);
						l4.moveTo(pts[0]+(sW*.5), pts[1]+(sH*.5));
						
						pts = pt2D(plane2[n2][0]+ofx*ofd, plane2[n2][1]+ofy*ofd, plane2[n2][2]+ofz*ofd);
						l4.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5)-1);
						
						pts = pt2D(plane2[n2][0], plane2[n2][1], plane2[n2][2]);
						l4.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5)-1);
						
						pts = pt2D(plane2[n2-1][0], plane2[n2-1][1], plane2[n2-1][2]);
						l4.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5));
						l4.endFill();
					}
				}
			}
			l4.lineStyle(1,clrMix(0x335147, 0x292B32, toDraw[n][0]));
			for (n2=0; n2<plane2.length; n2++) {
				if (n2 == 0) {
					l4.beginFill(clrMix(0x335147, 0x292B32, toDraw[n][0]));
					pts = pt2D(plane2[4][0]+ofx*ofd, plane2[4][1]+ofy*ofd, plane2[4][2]+ofz*ofd);
					l4.moveTo(pts[0]+(sW*.5), pts[1]+(sH*.5));
					
					pts = pt2D(plane2[0][0]+ofx*ofd, plane2[0][1]+ofy*ofd, plane2[0][2]+ofz*ofd);
					l4.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5)-1);
				} else {
					pts = pt2D(plane2[n2][0]+ofx*ofd, plane2[n2][1]+ofy*ofd, plane2[n2][2]+ofz*ofd);
					l4.lineTo(pts[0]+(sW*.5), pts[1]+(sH*.5)-1);
					if (n2 == 4) l4.endFill();
				}
			}
		}
	}
	
	for (n=0; n<plane.length; n++) {
		xd = spZ - plane[n][2];
		yd = spY - plane[n][1];
		d = Math.sqrt(xd*xd+yd*yd);
		r = Math.atan2(yd,xd)-180*Ci;
		r += Ci*ys;
		plane[n][2] = spZ + d*Math.cos(r);
		plane[n][1] = spY + d*Math.sin(r);
		
		xd = spX - plane[n][0];
		yd = spY - plane[n][1];
		d = Math.sqrt(xd*xd+yd*yd);
		r = Math.atan2(yd,xd)-180*Ci;
		r += Ci*xs;
		plane[n][0] = spX + d*Math.cos(r);
		plane[n][1] = spY + d*Math.sin(r);
	}
	
	xs *= .99;
	ys *= .99;
	
	if (drag) {
		xs -= .02*(mouseX - lx);
		ys -= .02*(mouseY - ly);
	}
	lx = mouseX;
	ly = mouseY;
	
	//bitMappin();
}

function drawSort(a:Array, b:Array):Number {
	if (a[0] > b[0]) return -1;
	else if (a[0] < b[0]) return 1;
	return 0;
}

var ofx:Number, ofy:Number, ofz:Number;
var ofd:Number;

var testP:Array;
function pPoly_form(p:Array, x:Number, y:Number):Boolean {
	var n:int = 0;
	var n2:int = 0;
	var c:Boolean = false;
	n2 = p.length-1;
	for (n=0; n<p.length; n2 = n++) {
		if (((p[n][1]>y) != (p[n2][1]>y)) && (x < (p[n2][0]-p[n][0])*(y-p[n][1])/(p[n2][1]-p[n][1]) + p[n][0])) {
			c = !c;
		}
	}
	return c;
}

var curPlane:int = -1;

function clrMix(c1:uint,c2:uint,p:Number):uint {
	var r1:uint = c1 >> 16;
	var g1:uint = c1 >> 8 & 0xFF;
	var b1:uint = c1 & 0xFF;
	
	return (r1+((c2 >> 16)-r1)*p) << 16 | (g1+((c2 >> 8 & 0xFF)-g1)*p) << 8 | (b1+((c2 & 0xFF)-b1)*p);
}

//radius / 1.40125853844407 = edge length

var Dv:Number = Math.sqrt(3)/(Math.sqrt(5)-1);

var deca:Array = [[0.607, 0.000, 0.795], 
				[ 0.188, 0.577, 0.795],
				[-0.491, 0.357, 0.795],
				[-0.491,-0.357, 0.795],
				[ 0.188,-0.577, 0.795],
				[ 0.982, 0.000, 0.188],
				[ 0.304, 0.934, 0.188],
				[-0.795, 0.577, 0.188],
				[-0.795,-0.577, 0.188],
				[ 0.304,-0.934, 0.188],
				[ 0.795, 0.577,-0.188],
				[-0.304, 0.934,-0.188],
				[-0.982, 0.000,-0.188],
				[-0.304,-0.934,-0.188],
				[ 0.795,-0.577,-0.188],
				[ 0.491, 0.357,-0.795],
				[-0.188, 0.577,-0.795],
				[-0.607, 0.000,-0.795],
				[-0.188,-0.577,-0.795],
				[ 0.491,-0.357,-0.795]];

var siz:Number = 500;
function genDoce(r:Number):void {
	plane = [];
	for (var n:uint=0; n<deca.length; n++) 
		plane.push([r*deca[n][0],r*deca[n][1],r*deca[n][2]]);
}

var shape:Array = new Array();

var dst:Number = 0;

var light:Array = new Array();
var trail:Array = new Array();
var clrs_form:Array = new Array();

function sort2(a:*,b:*):Number {
	return uint(Math.random()*3)-1;
}

/*stage.addEventListener(MouseEvent.MOUSE_MOVE,mm);
function mm(e:MouseEvent):void {
	ys = -4*(mouseY - (sH*.5))/250;
	xs = -4*(mouseX - (sW*.5))/250;
}*/

var drag:Boolean = false;

function ck_form(e:MouseEvent):void {
	if (curPlane != -1) {
		light[curPlane] = 1;
		tList_form.push(int(946.5*.25), curPlane);
		tList_form.push(int(946.5*.5), curPlane);
		tList_form.push(int(946.5*.75), curPlane);
		newSound(scale_form[curPlane], (1-Math.random()*.5)*(1-fading/END), Math.random()*2-1);
	}
	xs *= .6;
	ys *= .6;
	drag = true;
}
function mu_form(e:MouseEvent):void {
	drag = false;
}

var tList_form:Array = new Array();
function tef(e:Event):void {
	for (n=0; n<tList_form.length; n+=2) {
		tList_form[n]--;
		if (tList_form[n] < 0) {
			newSound(scale_form[tList_form[n+1]], (1-Math.random()*.5)*(1-fading/END), Math.random()*2-1);
			light[tList_form[n+1]] = 1;
			tList_form.splice(n,2);
			n -= 2;
		}
	}
}

//music manager/////////////////////////////////

var s0:N0 = new N0();
var s1:N1 = new N1();
var s2:N2_2 = new N2_2();
var s3:N3 = new N3();
var s4:N4 = new N4();
var s5:N5 = new N5();
var s6:N6 = new N6();
var s7:N7 = new N7();
var s8:N8 = new N8();
var s9:N9 = new N9();
var s10:N10 = new N10();
var s11:N11 = new N11();
var s12:N12 = new N12();
var s13:N13 = new N13();
var s14:N14 = new N14();
var s15:N15 = new N15();
var s16:N16 = new N16();
var s17:N17 = new N17();
var s18:N18 = new N18();
var s19:N19 = new N19();
var s20:N20 = new N20();
var s21:N21 = new N21();
var s22:N22 = new N22();
var s23:N23 = new N23();

var loop:Loop = new Loop();

var LP1:loop1 = new loop1();
var LP2:loop2 = new loop2();
var LP3:loop3 = new loop3();
var LP4:loop4 = new loop4();
var LP5:loop5 = new loop5();
var LP6:loop6 = new loop6();
var LP7:loop7 = new loop7();
var LP8:loop8 = new loop8();

var scale_form:Array = new Array();

var snds:Vector.<Sound> = new Vector.<Sound>();

//["#ID", sName, volume, pan, transition, transTime]
var msc_tracks:Array = new Array();
var msc_st:Vector.<SoundTransform> = new Vector.<SoundTransform>();
var msc_sc:Vector.<SoundChannel> = new Vector.<SoundChannel>();

var vol:Number = 2;

/*
trans - 
 0 - none
 1 - fade in
 2 - fade out
 3 - delayed fade in
*/

function newTrack(str:String, snd:Sound, v:Number=1, p:Number=0, t1:uint=0, t2:uint=60):void {
	var n:int = trackAt(str);
	if (n == -1) {
		n = msc_st.length;
		msc_st.push(new SoundTransform());
		msc_sc.push(new SoundChannel());
		msc_tracks.push([str,snd,v,p,t1,t2]);
		msc_sc[n] = snd.play(0,99999);
	} else {
		msc_tracks[n][2] = v;
		msc_tracks[n][3] = p;
		msc_tracks[n][4] = t1;
		msc_tracks[n][5] = t2;
	}
	
	msc_st[n].volume = msc_tracks[n][2]*vol;
	msc_st[n].pan = msc_tracks[n][3];
	msc_sc[n].soundTransform = msc_st[n];
}
//newTrack("name", loop, 0, 0, 1, 60*3);

var ind_form:Number = 0;
var sList:Array = new Array();

function snd_ef(e:Event):void {
	ind_form += ys*.01;
	if (ind_form < 0) ind_form += 8;
	else if (ind_form > 8) ind_form -= 8;
	for (n=0; n<sList.length; n++) {
		d = ind_form-n;
		if (d > 4) d -= 8;
		else if (d < -4) d += 8;
		if (d < 0) d = -d;
		d *= .4;
		d = 1-d;
		if (d < 0) d = 0;
		Vol(sList[n], MMODE ? d*1.25*sz_tm : d*2.5*sz_tm);
	}
}

function newSound(snd:Sound, v:Number=1, p:Number=0):void {
	msc_st.push(new SoundTransform());
	msc_sc.push(new SoundChannel());
	
	msc_tracks.push(["#"+String(Math.random()),snd,v,p,4,0]);
	var n:uint = msc_st.length-1;
	msc_sc[n] = snd.play(0,1);
	
	msc_st[n].volume = msc_tracks[n][2]*vol;
	msc_st[n].pan = msc_tracks[n][3];
	msc_sc[n].soundTransform = msc_st[n];
}

function trackAt(str:String):int {
	for (var n:uint=0; n<msc_tracks.length; n++) if (msc_tracks[n][0] == str) return n;
	return -1;
}

function newTran(str:String,t1:uint=0,t2:uint=0):void {
	var n:int = trackAt(str);
	if (n != -1) {
		msc_tracks[n][4] = t1
		msc_tracks[n][5] = t2;
	}
}

function Vol(str:String,v:Number):void {
	var n:int = trackAt(str);
	if (n != -1) {
		msc_tracks[n][2] = v;
		msc_st[n].volume = v*vol*.1;
		msc_sc[n].soundTransform = msc_st[n];
	}
}

function killTrack(n:int):void {
	if (n != -1) {
		msc_st[n] = null;
		msc_sc[n].stop();
		msc_sc[n] = null;
		msc_st.splice(n,1);
		msc_sc.splice(n,1);
		msc_tracks.splice(n,1);
	}
}

function msc_mng(e:Event):void {
	//H
	for (var n:uint=0; n<msc_tracks.length; n++) {
		if (msc_tracks[n][4] == 0) {
			// do nothing
		} else if (msc_tracks[n][4] == 1) {
			msc_tracks[n][2] += 1/msc_tracks[n][5];
			msc_st[n].volume = msc_tracks[n][2]*vol*.1;
			msc_sc[n].soundTransform = msc_st[n];
			if (msc_tracks[n][2] >= 1) msc_tracks[n][4] = 0;
		} else if (msc_tracks[n][4] == 2) {
			msc_tracks[n][2] -= 1/msc_tracks[n][5];
			msc_st[n].volume = msc_tracks[n][2]*vol*.1;
			msc_sc[n].soundTransform = msc_st[n];
			if (msc_tracks[n][2] <= 0) killTrack(n);
		} else if (msc_tracks[n][4] == 3) {
			msc_tracks[n][2] += 1/msc_tracks[n][5];
			msc_st[n].volume = Math.max(0,2*(msc_tracks[n][2]-.5)*vol*.1);
			msc_sc[n].soundTransform = msc_st[n];
			if (msc_tracks[n][2] >= 1) msc_tracks[n][4] = 0;
		} else if (msc_tracks[n][4] == 4) {
			if (msc_sc[n].position == msc_tracks[n][1].length) killTrack(n);
		} else if (msc_tracks[n][4] == 5) {
			msc_st[n].volume = msc_tracks[n][2]*vol*.1*(1-fading/END);
			msc_sc[n].soundTransform = msc_st[n];
			if (msc_tracks[n][2] <= 0) killTrack(n);
		}
	}
}

//END OF PROGRAM////////////////////////////////////////

init_menu();



	}
	
}