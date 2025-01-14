﻿class KeyGhost extends Ghost{
	public var hpmax:Number = 520;
	// Переопределение
	public function getBrain():Intellect{
		this.ghostIntellect = new GhostIntellect(this);
		return this.ghostIntellect;
	}
	
	/*
	//Переопределение
	private function lifeOrDie(){
		if((!life)&&(!this.counter.notOver) && (this.onlyOneSpawn)){
			if(!this.counter.notOver && _global.abstractLaw.creatures.length<2){
				super.lifeOrDie();
				_root["CenterOfWorld"].goToAndStopToNextFrame();
			}
		}
	}
	*/
	//Переопределение
	private var onlyOneSpawn:Boolean = true;
	public function setDie(){
		this.counter.delay = 0;
		if(this.direct){
			this.switcher.state = 13;
		}else{
			this.switcher.state = 14;
		}
		
		var egg = _root.attachMovie("GhostSpawn", "GhostSpawn", _root.getNextHighestDepth());
		egg.visible = false;
		egg._x = this._x;
		egg._y = this._y-100;
			
		this.counter.delay=34;
	}
	
	private var frameoutTeleport:Number = 0;
	private var frameoutDamageTeleport:Number = 0;
	public function setDamage(d:Number,dd:Boolean){
		super.setDamage(d,dd);
		if(this.frameoutDamageTeleport>4){
			this.teleport();
		}else{
			this.frameoutDamageTeleport++;
		}
	}
	
	public function keyReading(){
		super.keyReading();
		///*
		if(this.frameoutTeleport>100){
			this.teleport();
		}else{
			this.frameoutTeleport++;
		}
		//*/
	}
	
	public function teleport(){
		/*
		var animation1 = _root.attachMovie("GhostPortal", "SimpleAnimation", _root.getNextHighestDepth());
		animation1._xscale = this._xscale;
		animation1._yscale = this._yscale;
		animation1._x = this._x;
		animation1._y = this._y;
		*/
		this.frameoutDamageTeleport = 0;
		this.frameoutTeleport = 0;
		var coord = {x:_global.Player._x+Math.round(Math.random()*200)-100, 
					 y:_global.Player._y+Math.round(Math.random()*200)-100}; 
					 //this.ghostIntellect.getNeededXY();
		//trace("coord.dx="+coord.dx+" coord.dy="+coord.dy)
		this._x = coord.x;
		this._y = coord.y;
		/*
		var animation2 = _root.attachMovie("AnyAnimation", "SimpleAnimation", _root.getNextHighestDepth());
		animation2._xscale = this._xscale;
		animation2._yscale = this._yscale;
		animation2._x = this._x;
		animation2._y = this._y;
		*/
	}
}

