class MonstrSpawn extends GameObject{
	private var countOfMonstr:Number=0;
	private var monstrClass:String=null;
	private var monstrMC:String=null;
	private var once:Boolean=true;
	private var scale:Number=1;
	private var mcs:Array;
	private var complete:Boolean=false;
	private var stopBounds = null;
	private var additionalName:String = "";
	private var areaXName:String = "";
	private var areaObject:AreaObject = null;
	private var EFFECTIVE_RADIUS = 1000;
	
	public function getMCS():Array{
		return this.mcs;
	}
	
	public function setMCS(newMCS:Array){
		this.mcs = newMCS;
	}
	
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
		this.mCount=2;
		this.mMC="RatMonstr";
		this.mClass="Computer";
	}
		
	public function compileBounds(areaObject){
		trace("=======> Compile "+areaObject._name);
		if(areaObject){
			this.areaObject=areaObject;
			this.stopBounds = {};
			var bounds = areaObject.getBounds(_root);
			this.stopBounds.minX = bounds.xMin;
			this.stopBounds.minY = bounds.yMin;
			this.stopBounds.maxX = bounds.xMax;
			this.stopBounds.maxY = bounds.yMax;
		}
	}
	private var objectListForBounds:Array = null;
	public function getPrivateListForBounds():Array{
		if(!this.areaObject) return null;
		if(!this.objectListForBounds){
			this.objectListForBounds = new Array();
			for(var i=0; i<_global.abstractLaw.length; i++){
				var obj = _global.abstractLaw[i];
				if(obj.hitTest(this.areaObject))this.objectListForBounds.push(obj);
			}
		}
		return this.objectListForBounds;
	}
	
	public function MonstrSpawn(){
		this.areaNeeded = true;
		for(var i in _root){	
			var object = _root[i];
			if(object  
			&& (object instanceof AreaObject || object.isArea)
			&& this.hitTest(object)){//&& object instanceof GameObject){
				this.compileBounds(object);
			}
		}	
		this.calcObj = false;
		this.init();
	}
	
	//Переопределение
	public function onEnterFrame(){
		if(!_global.doPause){			
			this.onEnterFrameCatchPlayer();
		}
	}
	
	// Переопределение
	public function takeObject(object:GameObject):Boolean{
		return false;
	}
	
	// Переопределение
	public function deinit(){
		this._alpha=100;
		this.once=true;
		this.complete = false;
		return false;
	}
	
	
	public function onEnterFrameCatchPlayer(){
		if(this.once){
			if(_global.player!=null && this.onRadius(_global.player, EFFECTIVE_RADIUS)){
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
		var created:Number = 0;
		for(var i=0; i<this.mCount; i++){
			if(_global.abstractLaw.canICreateOneMoreCreatures()){
				this.mcs[i]=_root.attachMovie(this.mMC, this.mClass+"_"+i, _root.getNextHighestDepth());
				this.configurateMC(this.mcs[i]);
				created++;
			}
		}
		if(created==0){
			deinit();
		}
		return this.mcs;
	}
	
	private function configurateMC(a:GameObject){
		a._x=this._x + Math.round(Math.random()*100)-50;
		a._y=this._y;
		var k:Number=(Math.random()*0.4+0.2);
		a.setScale(k);
		a._alpha=0;
		if(this.stopBounds){
			trace("1111");
			a.stopBounds = this.stopBounds;
			a.myPrivateObjList = this.getPrivateListForBounds();
		}else{
			trace("2222");
			a.myPrivateObjList = _global.abstractLaw;
		}
	}
	
	// Переопределение
	public function getType():String{
		return "MonstrSpawn";
	}
}