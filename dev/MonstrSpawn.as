class MonstrSpawn extends GameObject{
	private var countOfMonstr:Number=0;
	private var monstrClass:String=null;
	private var monstrMC:String=null;
	private var once:Boolean=true;
	private var scale:Number=1;
	private var mcs:Array;
	private var complete:Boolean=false;
	
	public function set mMC(monstrMC:String){
		this.monstrMC = monstrMC;
	}
	
	public function get mMC():String{
		return this.monstrMC;
	}
	
	public function set mCount(countOfMonstr:Number){
		this.countOfMonstr = countOfMonstr;
	}
	
	public function get mCount():Number{
		return this.countOfMonstr;
	}
	
	public function set mClass(monstrClass:String){
		this.monstrClass = monstrClass;
	}
	
	public function get mClass():String{
		return this.monstrClass;
	}
	
	public function init(){
		this.mMC="RatMonstr";
		this.mCount=2;
		this.mClass="Computer";
	}
	
	public function MonstrSpawn(){
		this.init();
	}
	
	//Переопределение
	public function onEnterFrame(){
		super.onEnterFrame();
		this.onEnterFrameCatchPlayer();
	}
	
	// Переопределение
	public function takeObject(object:GameObject):Boolean{
		return false;
	}
	
	// Переопределение
	public function deinit(){
		this._alpha=100;
		this.once=true;
		//for(var i=0; i<this.mCount; i++){
		//	this.mcs[i].removeMovieClip();
		//}
		return false;
	}
	
	public function onEnterFrameCatchPlayer(){
		if(this.once){
			if(_global.player!=null && this.onRadius(_global.player, 400)){
				this.spawn();
				this.once=false;
			}	
		}else{
			if(this.mCount>0 && this.mcs[0]._alpha<100){
				for(var i=0; i<this.mCount; i++){
					this.mcs[i]._alpha+=10;
					this._alpha-=10;
					if(this.mcs[0]._alpha>=100) this.complete=true;
				}	
			}else{
				if(complete) this.remove();
			}
		}
	}
	
	public function spawn(){
		this.mcs = new Array(this.mCount);
		for(var i=0; i<this.mCount; i++){
			this.mcs[i]=_root.attachMovie(this.mMC, this.mClass, _root.getNextHighestDepth());
			this.configurateMC(this.mcs[i]);
			this.mcs[i]._alpha=0;
		}
		return this.mcs;
	}
	
	private function configurateMC(a:GameObject){
		a._x=this._x + Math.round(Math.random()*100)-50;
		a._y=this._y;
		var k:Number=(Math.random()*0.4+0.2);
		a.setScale(k);
	}
	
	// Переопределение
	public function getType():Number{
		return 100;
	}
}