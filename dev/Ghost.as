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
	private	var ghostIntellect:GhostIntellect = null;
	
	private var bulletClass = "GhostBullet";
	
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
	
	// Переопределение
	
	public function getBrain():Intellect{
		this.ghostIntellect = new GhostIntellect(this);
		return this.ghostIntellect;
	}
	

	public function createBullet(){
		var chieldBullet = _root.attachMovie(bulletClass, "ghostbullet"+(Bullet.count++), _root.getNextHighestDepth());
		chieldBullet._xscale = this._xscale;
		chieldBullet._yscale = this._xscale;
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
}
