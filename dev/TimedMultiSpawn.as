class TimedMultiSpawn extends MonstrSpawn{
	private var counter:Counter;
	private var notStateSpawn:Boolean = true;
	private var period = 350;
	private var mMC2:String;
	private var mClass2:String;
	
	public function init(){
		this.mCount=6;
		this.mMC="RatMonstr";
		this.mClass="Computer";
		this.mMC2="RatMonstr2";
		this.mClass2="Rat2";
	}
	
	public function TimedMultiSpawn(){
		this.counter = new Counter();
		this.setMCS(new Array());
	}
	
	public function onEnterFrameCatchPlayer(){
		if(this.notStateSpawn){
			if(_global.player!=null && this.onRadius(_global.player, 400)){
				//this.spawn();
				this.notStateSpawn=false;
			}	
		}else{
			if(this.getMCS().length<this.mCount && !this.counter.notOver){
				this.addToSpawn();
				this.counter.delay=this.period;
			}
			if(this.mCount<0 || ((this.getMCS()[this.getMCS().length]._alpha>=100 || !this.getMCS()[this.getMCS().length]) && this.getMCS().length==this.mCount)){
				complete = true;
				trace("EndSpawn");				
			}else{
				for(var i=0; i<this.mCount; i++){
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
	
	//Переопределение
	public function onEnterFrame(){
		if(!_global.doPause && !complete){
			this.counter.iterateCounter();
			super.onEnterFrame();
		}
	}
	
	public function addToSpawn(){
			var rand = Math.round(Math.random()*100);
			var i = this.getMCS().length;
			if(rand<90){
				this.getMCS()[i] = _root.attachMovie(this.mMC, this.mClass, _root.getNextHighestDepth());
			}else{
				this.getMCS()[i] = _root.attachMovie(this.mMC2, this.mClass2, _root.getNextHighestDepth());
			}
			this.configurateMC(this.mcs[i]);
			this.mcs[i]._alpha=0;
	}
}