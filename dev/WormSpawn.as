class WormSpawn extends MonstrSpawn{
	// Переопределение
	public function init(){
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
			k = (Math.random()*0.5+0.2);
		}
		this.mcounter++;
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
	public function deinit(){
		this.mcounter = 0;
		return super.deinit();
	}
}