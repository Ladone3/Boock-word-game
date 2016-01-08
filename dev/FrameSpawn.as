class FrameSpawn extends TimedMultiSpawn{
	private var period = 200;
	
	public function init(){
		this.mCount=6;
		this.mMC="RatMonstr";
		this.mClass="Computer";
		this.mMC2="RatMonstr2";
		this.mClass2="Rat2";
	}
	
	public function FrameSpawn(){
	}
	
	var frameStoped
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
				if(this.getMCS()[i] && this.getMCS()[i]._alpha<100){
					this.getMCS()[i]._alpha+=10;
					allSpawnersTrue = false;
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
		var offs = Math.round(Math.random()*Stage.width/2)-Stage.width/4;
		a._x=this._x + offs;
		a._y=this._y;
		if(offs>=0){
			a.direct=false;
			a.xA = 10;
			a.yA = 10;
		}else{
			a.direct=true;
			a.xA = -10;
			a.yA = -10;
		}
		var k:Number=(Math.random()*0.4+0.2);
		a.setScale(k);
	}
}