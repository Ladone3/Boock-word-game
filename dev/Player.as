class Player extends GameObject{
	// Коды клавиш
	//===============================
	private var kUp:Number    = 38;
	private var kDown:Number  = 40;
	private var kLeft:Number  = 37;
	private var kRight:Number = 39;
	private var kFight:Number = 32;
	private var kJump:Number  = 38;
	
	
	//private var kUp:Number    = 87;
	//private var kDown:Number  = 83;
	//private var kLeft:Number  = 65;
	//private var kRight:Number = 68;
	//private var kFight:Number = 97;
	//private var kJump:Number = 98;
	// Блокировка анимации
	//===============================
	private var counter:Counter;
	
	// Характеристики персонажа
	//===============================
	private var jumpPower:Number = 30;
	private var runPower:Number = 6;
	public var damage:Number = 10;
	public var radius:Number = 10;
	public var hpmax:Number = 20;
	public var stunDelay:Number = 25;
	public var hpline;
	// Состояние персонажа	
	//===============================
	private var readyToJump:Boolean = false;
	private var inAero:Boolean;
	private var switcher:Switcher;
	private var indic:MovieClip;
	private var auraContainer:AuraContainer;
	//===============================
	private var ACTIVE_K_X_DIST = 1;
	private var ACTIVE_K_Y_DIST = 1;
	
	private var direction:Boolean;
	public var active:Boolean = true;
	public function set direct(b:Boolean){
		if(!this.counter.notOver){ 
			this.direction = b;
		}
	}
	
	public function get direct():Boolean{
		return this.direction;
	}
	
	// Переопределение	
	public function getType():String{
		return "Player";
	}
	
	private function lifeOrDie(){
		if((!life)&&(!this.counter.notOver)){
			this.remove();
		}
	}
	
	// Переопределение	
	private function remove(){
		_global.abstractLaw.popCreature(this);
		super.remove();
	}
	
	
	//=====================================================
	public function breakCounter(){
		if(this.counter) this.counter.delay = 0;
	}
	
	//=====================================================
	//=====================================================
	public function setfreeState(){
		if(this.inAero){
			if(this.direct){
				this.switcher.state = 7;
			}else{
				this.switcher.state = 8;
			}
		}else{
			if(this.direct){
				this.switcher.state = 1;
			}else{
				this.switcher.state = 2;
			}
		}
		this.readyToJump = false;
	}
	
	public function runLeft(){
		if(this.xBoost>-runPower && this.xBoost<=0){
			this.xBoost = -runPower;
		} else if(this.xBoost>0){
			this.xBoost -= runPower;
		}
		this.switcher.state = 4;
		this.direct = false;
		this.readyToJump = true;
	}
	
	public function runRight(){
		if(this.xBoost<runPower && this.xBoost>=0){
			this.xBoost = runPower;
		} else if(this.xBoost<0){
			this.xBoost += runPower;

		}
		this.switcher.state = 3;
		this.direct = true;
		this.readyToJump = true;
	}
	
	public function planLeft(){
		if(this.xBoost>-runPower*1.5){
			this.xBoost = -runPower*1.5;
		} else if(this.xBoost>0){
			this.xBoost -= runPower;
		}
		this.direct = false;
	}
	
	public function planRight(){
		if(this.xBoost<runPower*1.5){
			this.xBoost = runPower*1.5;
		} else if(this.xBoost<0){
			this.xBoost += runPower;
		}
		this.direct = true;
	}

	public function landing(){
		if(this.direct){
			this.switcher.state = 9;
		}else{
			this.switcher.state = 10;
		}
		this.counter.delay = 10;
	}
	
	public function jump(){
		if(!this.inAero){
			if(this.readyToJump){
				this.yBoost = -jumpPower;
			}else{
				if(this.direct){
					this.switcher.state = 5;
				}else{
					this.switcher.state = 6;
				}
				this.counter.delay = 4;
				this.readyToJump = true;
			}
		}else{
			if(this.yBoost<-jumpPower/3){
				this.yBoost -= jumpPower/10;
			}
			setfreeState();
		}
	}

	public function blow(){
		if(this.direct){
			this.switcher.state = 11;
			this.blowPermission(this.radius,this.damage,0.5);
		}else{
			this.switcher.state = 12;
			this.blowPermission(this.radius,this.damage,0.5);
		}
		this.counter.delay=10;
	}
	
	public function setDie(){
		this.counter.delay = 0;
		if(this.direct){
			this.switcher.state = 13;
		}else{
			this.switcher.state = 14;
		}
		this.counter.delay=34;
	}
	
	public function setTreatment(t:Number){
		this.hpline.treatment(t);
	}
	
	public function setDamage(d:Number,dd:Boolean){
		if(!this.hpline) initHPLine();
		this.hpline.damage(d);
		if(this.switcher.state!= 13 && this.switcher.state!= 14){
			this.counter.delay = 0;
		}
		if(this.direct){
			this.switcher.state = 1;
			if(dd){
				this.switcher.state = 15;
			}else{
				this.switcher.state = 17;
			}
		}else{
			this.switcher.state = 2;
			if(dd){
				this.switcher.state = 16;
			}else{
				this.switcher.state = 18;
			}
		}
		this.counter.delay = this.stunDelay;
	}
	
	//=====================================================
	//=====================================================
	//=====================================================
	private var fallDamage = 15;
	public var fallDamageCounter = 0;
	private function aeroState(nameValue:String, lastState:Boolean, newState:Boolean, dop):Boolean{
		if(this.yBoost>=_global.abstractLaw.MaxAttractiveSpeed)fallDamageCounter++;
		else fallDamageCounter=0;
		var lastAeroState = this.inAero;
		this.inAero = ((!newState)&&(!lastState));
		if((lastAeroState) && (!this.inAero)){
			this.counter.delay=0;
			var fdc = fallDamageCounter-jumpPower/4;
			this.hpline.damage(fallDamage*((fdc)>0?fdc:0));
			fallDamageCounter = 0;
			if(this.yBoost>=(_global.abstractLaw.AttractiveForce*4))this.landing();
		}
		return newState;
	}	
	
	public function getSwitcher():Switcher{
		return this.switcher;
	}
	
	public function createSwitcher():Switcher{
		return new Switcher(26,this,this.counter);
	}
	
	public function Player(){
		this.auraContainer = new AuraContainer(this);
		this.counter = new Counter();
		this.switcher = createSwitcher();
		this.mov = true;
		this.inAero = true;
		this.direct = true;
		this.watch("touchDown", aeroState, 1);
		this.switcher.state = 1;
		this.initHPLine();
		if(_global.abstractLaw){
			_global.abstractLaw.addCreature(this);
		}
	}	
	
	public function initHPLine(){
		this.hpline = new HPLine();
		this.hpline.setHPLine(hpmax);
	}
	
	public function setScale(k:Number){
		this._xscale *= k;
		this._yscale *= k;
	}
	
	public function keyReading(){
		if(!this.counter.notOver && this.life){
			if(Key.isDown(kLeft)||Key.isDown(kFight)||Key.isDown(kRight)||Key.isDown(kJump)){
				if(this.inAero){
				//============================================================
					if(Key.isDown(kJump)){
						this.jump();
					}
					if(Key.isDown(kLeft) && (!Key.isDown(kRight))){
						this.planLeft();
					}
					if(Key.isDown(kRight) && (!Key.isDown(kLeft))){
						this.planRight();
					}
					if(Key.isDown(kRight) && Key.isDown(kLeft) && (!Key.isDown(kJump))){
						setfreeState();
					}
					
				//============================================================
				}else{
				//============================================================
					if(Key.isDown(kFight)){
						this.blow();
					}
					
					if(Key.isDown(kJump)){
						this.jump();
					}

					if(Key.isDown(kLeft) 
						&& (!(Key.isDown(kRight)||Key.isDown(kJump)))
					){
						this.runLeft();
					}
					if(Key.isDown(kRight)
						&& (!(Key.isDown(kLeft)||Key.isDown(kJump)))
					){
						this.runRight();
					}
					if(Key.isDown(kRight) && Key.isDown(kLeft) && (!Key.isDown(kJump))){
						setfreeState();
					}
				//============================================================
				}
			}else{
				setfreeState();
			}
		}
	}
	
	//private var traceClip;
	// Переопределение
	public function onEnterFrame() {
		/*if(!traceClip){
			traceClip = _root.attachMovie("Target", "TraceBullet", _root.getNextHighestDepth());
		}else{
			traceClip._x = this._x;
			traceClip._y = this._y;
		}*/
		this.counter.iterateCounter();
		super.onEnterFrame();
	}
	
	private function checkForDeath(){
		if(this.hpline && this.hpline.HP!=undefined && this.hpline.HP<=0 && this.life){
			this.life = false;
			this.setDie();
		}
	}
	
	//Переопределение
	public function onEnterFrameAction(){
		super.onEnterFrameAction();
		if(_global.player==this 
		|| (Math.abs(_global.player._x-this._x)<Stage.width*ACTIVE_K_X_DIST
			&& Math.abs(_global.player._y-this._y)<Stage.height*ACTIVE_K_Y_DIST
			)){
			this.active = true;
			this.keyReading();
			this.checkForDeath();
			this.auraContainer.handIteration();
		}else{
			this.active = false;
			//trace("I am far from you!!")
		}
	}
	
	//=============================================================================	
	public function blowPermission(radius:Number, damage:Number,k:Number):Boolean{
		var nWidth = this.radius*2; //this._x+100,this._y,50,this.damage
		var nHeight = nWidth;
		for(var i=0; i<_global.abstractLaw.length; i++){			
			if(_global.abstractLaw[i]!=this && _global.abstractLaw[i]!=null){
				var offset:Number = 0;
				if(direct){
					offset = 100;
				}else{
					offset = -100;
				}
				var temp1 = this.getBounds(_root);
				var nXMin = temp1.xMin + this._width/2 - radius + offset;
				var nYMin = temp1.yMin + this._height/2 - radius;
				var temp2 = _global.abstractLaw[i].getBounds(_root);
				if((nXMin >= temp2.xMin - nWidth)&&(nYMin >= temp2.yMin - nHeight)&&(nXMin <= temp2.xMax)&&(nYMin <= temp2.yMax)&&(this[i].life)){                                                                                              
						_global.abstractLaw[i].setDamage(damage,(_global.abstractLaw[i].direct!=direct));
						if(direct){
							_global.abstractLaw[i].xA = damage/2*k;
						}else{
							_global.abstractLaw[i].xA = -damage/2*k;
						}
						return true;
				}
			}
		}
		return false;
	}
}

