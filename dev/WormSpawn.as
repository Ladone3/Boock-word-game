class WormSpawn extends FrameSpawn{
	// Переопределение
	public function init(){
		this.period = 30;
		this.mCount=4;
		this.mMC="WormMonstr";
		this.mClass="WormMonstr";
	}
	
	// Переопределение
	private var mcounter = 0;
	private function configurateMC(a:GameObject){
		var k:Number = 1;
		if(mcounter<3){
			k = (Math.random()*0.3+0.1);
		}else{
			k = (Math.random()*0.4+0.2);
		}
		this.mcounter++;
		a._x=this._x + Math.round(Math.random()*100)-50;
		a._y=this._y;
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
	public function addToSpawn(){
			if(_global.abstractLaw.canICreateOneMoreCreatures()){
				var i = this.getMCS().length;
				var newMonstr = _root.attachMovie(this.mMC, this.mClass, _root.getNextHighestDepth());
				this.getMCS().push(_global.abstractLaw.getGameObject(newMonstr._name));
				this.configurateMC(newMonstr);
				this.getMCS()[i]._alpha=0;
			}
	}
	
	// Переопределение
	public function deinit(){
		this.mcounter = 0;
		return super.deinit();
	}
}