class Ghost extends FlyingEnemy{
	// Характеристики
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

	public function keyReading(){
		super.keyReading();
		if(this.frameoutTeleport>5000 && !this.counter.notOver){
			this.teleport();
		}else{
			this.frameoutTeleport++;
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
