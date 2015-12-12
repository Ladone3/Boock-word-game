class Ghost extends Computer{
	// Характеристики персонажа
	//===============================
	private var jumpPower:Number = 35;
	private var runPower:Number = 10;
	public var damage:Number = 50;
	public var radius:Number = 20;
	public var hpmax:Number = 360;
	public var stunDelay:Number = 10;

	// Переопределение
	public function getBrain():Intellect{
		return new GhostIntellect(this);
	}

	//Переопределение
	public function onEnterFrameAction(){
		super.onEnterFrameAction();
		this.hpline.treatment(0.4);
	}

	public function createBullet(){
		var chieldBullet = _root.attachMovie("GhostBullet", "ghostbullet"+(Bullet.count), _root.getNextHighestDepth());
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
			25,
			this._x,
			this._y,
			this.damage,
			this,
			true);
	}

	//Переопределение
	/*public function blow(){
		if(stayOrNo!=0){
			fastBlow();
		}else{
			dblow();
		}
		stayOrNo++;
		if(stayOrNo>3)stayOrNo=0;
	}*/

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
		}
	}

}
