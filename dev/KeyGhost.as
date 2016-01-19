class KeyGhost extends Ghost{
	public var hpmax:Number = 720;
	// Переопределение
	public function getBrain():Intellect{
		this.ghostIntellect = new GhostIntellect(this);
		return this.ghostIntellect;
	}
	
	//Переопределение
	private function lifeOrDie(){
		super.lifeOrDie();
		if((!life)&&(!this.counter.notOver)){
			if(!this.counter.notOver){
				_root["CenterOfWorld"].goToAndStopToNextFrame();
			}
		}
	}
	
	private var frameoutTeleport:Number = 0;
	private var frameoutDamageTeleport:Number = 0;
	public function setDamage(d:Number,dd:Boolean){
		super.setDamage(d,dd);
		trace(this.frameoutDamageTeleport);
		if(this.frameoutDamageTeleport>4){
			this.teleport();
		}else{
			this.frameoutDamageTeleport++;
		}
	}
	
	public function keyReading(){
		super.keyReading();
		if(this.frameoutTeleport>100){
			this.teleport();
		}else{
			this.frameoutTeleport++;
		}
	}
	
	public function teleport(){
		///*
		var animation1 = _root.attachMovie("GhostPortal", "SimpleAnimation", _root.getNextHighestDepth());
		animation1._xscale = this._xscale;
		animation1._yscale = this._yscale;
		animation1._x = this._x;
		animation1._y = this._y;
		//*/
		this.frameoutDamageTeleport = 0;
		this.frameoutTeleport = 0;
		var coord = this.ghostIntellect.getNeededXY();
		//trace("coord.dx="+coord.dx+" coord.dy="+coord.dy)
		this._x = coord.x;
		this._y = coord.y;
		///*
		var animation2 = _root.attachMovie("AnyAnimation", "SimpleAnimation", _root.getNextHighestDepth());
		animation2._xscale = this._xscale;
		animation2._yscale = this._yscale;
		animation2._x = this._x;
		animation2._y = this._y;
		//*/
	}
}

