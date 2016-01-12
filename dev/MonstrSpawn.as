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
		
	public function compileBounds(areaObject:AreaObject){
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
		if(this.lastname.length>=4)this.additionalName = this.lastname.substr(0,4);
		if(this.lastname.length>=8)this.areaXName = this.lastname.substr(4,8);	
		this.calcObj = false;
		compileBounds(_root[areaXName]);
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
			a.stopBounds = this.stopBounds;
			var l = this.getPrivateListForBounds();
			a.myPrivateObjList = (l.length>0 ? l : _global.abstractLaw);
		}else{
			a.myPrivateObjList = _global.abstractLaw;
		}
	}
	
	// Переопределение
	public function getType():Number{
		return 100;
	}
}