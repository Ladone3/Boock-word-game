class Ghost extends Computer{
	// Характеристики персонажа
	//===============================
	private var jumpPower:Number = 35;
	private var runPower:Number = 10;
	public var damage:Number = 50;
	public var radius:Number = 15;
	public var hpmax:Number = 360;
	public var stunDelay:Number = 10;
	private var ACTIVE_K_X_DIST = 3;
	private var ACTIVE_K_Y_DIST = 3;
	
	// Переопределение
	public function getBrain():Intellect{
		return new GhostIntellect(this);
	}

	//Переопределение
	public function onEnterFrameAction(){
		super.onEnterFrameAction();
		this.hpline.treatment(0.2);
		if(this.xA!=0){
			if(this.xA>0){
				this.xA--;
			}else{
				this.xA++;
			}
		}
		if(this.yA!=0){
			if(this.yA>0){
				this.yA--;
			}else{
				this.yA++;
			}
		}
	}

	public function createBullet(){
		var chieldBullet = _root.attachMovie("GhostBullet", "ghostbullet"+(Bullet.count), _root.getNextHighestDepth());
		chieldBullet._xscale = this._xscale;
		chieldBullet._yscale = this._yscale;
		var d = _global.abstractLaw.getOffsets(this);
		/*var angl = (Math.atan2(
				(brain.getDistance().xo),
				(brain.getDistance().yo)
			)*180/Math.PI-90);*/
		var angl = (Math.atan2(
				(d.xo),
				(d.yo)
			)*180/Math.PI-90);
		//trace("xd: "+brain.getDistance().xo+"\nyd: "+brain.getDistance().yo+"\nangl: "+angl);
		chieldBullet.StartBullet(
			angl,
			15,
			this._x,
			this._y,
			this.damage,
			this,
			true);
	}

	//Переопределение
	public function blow(){
		if(stayOrNo!=0){
			fastBlow();
		}else{
			dblow();
		}
		stayOrNo++;
		if(stayOrNo>3)stayOrNo=0;
	}

	//Переопределение
	public function fastBlow(){
		if(this.direct){
			if(brain.getDistance().xo>=0){
				this.switcher.state = 11;
				this.createBullet();
			}
		}else{
			if(brain.getDistance().xo<=0){
				this.switcher.state = 12;
				this.createBullet();
			}
		}
		this.counter.delay=10;
	}

	//Переопределение
	private function aeroState(nameValue:String, lastState:Boolean, newState:Boolean, dop):Boolean{
		this.inAero = false;
		return this.inAero;
	}

	public function setfreeState(){
		super.setfreeState();
		this.xA=0;
		this.yA=0;
	}

	//Переопределение
	private var lock:Boolean = true;
	public function set yA(yBoost:Number){
		if(!this.lock){
			super.yA = yBoost;
		}
	}

	//Переопределение
	public function landing(){
		if(this.yBoost<runPower){
			this.yBoost = jumpPower;
		} else if(this.yBoost<0){
			this.yBoost += runPower/1.5;
		}
	}

	//Переопределение
	public function jump(){
		if(this.yBoost>-runPower){
			this.yBoost = -runPower;
		} else if(this.yBoost>0){
			this.yBoost -= runPower/1.5;
		}
	}

	public function keyReading(){
		if(!this.counter.notOver){
			if(kLeft||kRight||kJump||kFight||kDown){
				//============================================================
					if(kJump && !kDown){
						this.jump();
					}

					if(kDown && !kJump){
						this.landing();
					}

					if(kFight){
						this.blow();
					}else{
						stayOrNo = 0;
					}

					if(kLeft
						&& (!(kRight||kJump))
					){
						this.runLeft();
					}
					if(kRight
						&& (!(kLeft||kJump))
					){
						this.runRight();
					}
					if(kRight && kLeft && (!kJump)){
						setfreeState();
					}
				//============================================================
			}else{
				setfreeState();
			}
			if(this.frameOutDamage>5000){
				this.teleport();
			}else{
				this.frameOutDamage++;
			}
		}
	}
	
	private frameoutTeleport:Number = 0;
	private frameoutDamageTeleport:Number = 0;
	public function setDamage(d:Number,dd:Boolean){
		super.setDamage(d,dd);
		if(this.frameOutDamage>4){
			this.teleport();
		}else{
			this.frameOutDamage++;
		}
	}
	
	public function teleport(){
		var animation1 = _root.attachMovie("AnyAnimation", "SimpleAnimation", _root.getNextHighestDepth());
		animation1._xscale = this._xscale;
		animation1._yscale = this._yscale;
		animation1._x = this._x;
		animation1._y = this._y;
		
		this.frameOutDamage=0;
		var coord = this.brain.getNeededDistance();
		this._x = coord.dx;
		this._y = coord.dy;
		
		var animation2 = _root.attachMovie("AnyAnimation", "SimpleAnimation", _root.getNextHighestDepth());
		animation2._xscale = this._xscale;
		animation2._yscale = this._yscale;
		animation2._x = this._x;
		animation2._y = this._y;
	}

}
