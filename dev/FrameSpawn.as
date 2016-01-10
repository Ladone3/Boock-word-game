﻿class FrameSpawn extends TimedMultiSpawn{
	private var period = 100;
	
	public function init(){
		this.mCount=6;
		this.mMC="RatMonstr";
		this.mClass="Computer";
		this.mMC2="RatMonstr2";
		this.mClass2="Rat2";
	}
	
	public function FrameSpawn(){
	}
	
	public function onEnterFrameCatchPlayer(){
		if(this.notStateSpawn){
			if(_global.player!=null && this.hitTest(_global.player)){
				this.notStateSpawn=false;
				_global.abstractLaw.stopFrame = true;
			}	
		}else{
			if(this.mCount<=0 || (allSpawnersTrue && this.getMCS().length==this.mCount)){
				complete = true;
				this.switcher.state = 2;
				trace("EndSpawn");		
				_global.abstractLaw.stopFrame = false;
			}
			if(this.getMCS().length<this.mCount && !this.counter.notOver){
				this.addToSpawn();
				this.counter.delay=this.period;
			}
			allSpawnersTrue = true;
			for(var i=0; i<this.mCount; i++){	
				if(this.getMCS()[i] && this.getMCS()[i].hpline && this.getMCS()[i].hpline.HP>0){
					this.allSpawnersTrue = false;
					if(this.getMCS()[i]._alpha<100){
						this.getMCS()[i]._alpha+=10;
					}
				}
			}
		}
	}
	
	// Переопределение
	public function deinit(){
		super.deinit();
		this.notStateSpawn = true;
		return false;
	}
	
	private function configurateMC(a){
		var rand = Math.round(Math.random()*2);
		if(rand==2){
			a._x = _global.abstractLaw.stageBounds.xMax;
			a.direct=false;
			a.xA = 50;
			a.yA = -50;
		}else{
			a._x = _global.abstractLaw.stageBounds.xMin;
			a.direct=true;
			a.xA = -50;
			a.yA = -50;
		}
		a._y=this._y;
		var k:Number=(Math.random()*0.4+0.2);
		a.setScale(k);
	}
}