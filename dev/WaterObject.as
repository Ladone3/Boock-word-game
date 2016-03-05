class WaterObject extends ForegroundObject{
	private var ejectionForce:Number = 2;
	//private var recistanceForce:Number = 2;
	
	public function WaterObject(){
		this.ejectionForce = _global.abstractLaw.AttractiveForce;// /2;
	}
	
	public function doSomething(){
		super.doSomething();
		for(var i=0; i<_global.abstractLaw.creatures.length; i++){
			var curObject = _global.abstractLaw.creatures[i];
			if(curObject.mov && this.hitTest(curObject)){
				curObject.xA -= (curObject.xA/2);
				curObject.yA -= (curObject.yA>0 ? curObject.yA/2: 0);
				//curObject.yA -= this.ejectionForce;
			}
		}
	}
}