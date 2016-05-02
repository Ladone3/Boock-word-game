class GhostSpawn extends MonstrSpawn{
	// Переопределение
	public function init(){
		this.mCount=4;
		this.mMC="GhostMonstrBoss";
		this.mClass="Ghost";
	}
	
	// Переопределение
	private function configurateMC(a:GameObject){
		a._x=this._x;
		a._y=this._y;
		var k:Number=0.2;
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
}