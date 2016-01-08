class TimedMultiSpawn extends MonstrSpawn{
	private var counter:Counter;
	private var notStateSpawn:Boolean = true;
	private var period = 350;
	private var spawnDistCatch = 400;
	private var mMC2:String;
	private var mClass2:String;
	private var switcher:Switcher;
	
	public function init(){
		this.mCount=6;
		this.mMC="RatMonstr";
		this.mClass="Computer";
		this.mMC2="RatMonstr2";
		this.mClass2="Rat2";
	}
	
	public function TimedMultiSpawn(){
		this.switcher = new Switcher(2,this, new Counter());
		this.switcher.state = 1;
		this.counter = new Counter();
		this.setMCS(new Array());
	}
	
	public var allSpawnersTrue:Boolean = true;
	public function onEnterFrameCatchPlayer(){
		if(this.notStateSpawn){
			if(_global.player!=null && this.onRadius(_global.player, this.spawnDistCatch)){
				//this.spawn();
				this.notStateSpawn=false;
			}	
		}else{
			if(this.mCount<=0 || (allSpawnersTrue && this.getMCS().length==this.mCount)){
				complete = true;
				this.switcher.state = 2;
				trace("EndSpawn");				
			}
			if(this.getMCS().length<this.mCount && !this.counter.notOver){
				this.addToSpawn();
				this.counter.delay=this.period;
			}
			allSpawnersTrue = true;
			for(var i=0; i<this.mCount; i++){
				if(this.getMCS()[i] && this.getMCS()[i].hpline && this.getMCS()[i].hpline.HP>0 && this.getMCS()[i]._alpha<100){
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
			var newMonstr;
			if(rand<90){
				newMonstr = _root.attachMovie(this.mMC, this.mClass, _root.getNextHighestDepth());
			}else{
				newMonstr = _root.attachMovie(this.mMC2, this.mClass2, _root.getNextHighestDepth());
			}
			this.getMCS().push(_global.abstractLaw.getGameObject(newMonstr._name));
			this.configurateMC(newMonstr);
			this.getMCS()[i]._alpha=0;
	}
}