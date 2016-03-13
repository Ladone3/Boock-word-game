class WaterObject extends ForegroundObject{
	private var ejectionForce:Number = 2;
	//private var recistanceForce:Number = 2;
	
	public function WaterObject(){
		this.ejectionForce = _global.abstractLaw.AttractiveForce;// /2;
	}
	
	public function h20counter(object, thisBounds){
		var bounds = object.getBounds(_root);
		if(bounds.yMin >= thisBounds.yMin){
			if(object.h2oReserv==undefined) object.h2oReserv = 250;
			if(object.h2oReserv<=0){
				trace("!!!!");
				object.hpline.damage(0.2);
			}else{
				trace("///// H20:"+object.h2oReserv);
				object.h2oReserv--;
			}

		}else{
			object.h2oReserv = 250;
		}
	}
	
	public function doSomething(){
		super.doSomething();
		var thisBounds = this.getBounds(_root);
		for(var i=0; i<_global.abstractLaw.creatures.length; i++){
			var curObject = _global.abstractLaw.creatures[i];
			if(curObject.mov && this.hitTest(curObject)){
				h20counter(curObject,thisBounds);
				var curBounds = curObject.getBounds(_root);
				var curObjCenter = curBounds.yMax+curBounds.yMin/2
				if(curObjCenter>thisBounds.yMin){
					curObject.xA -= (curObject.xA/2);
					curObject.yA -= (curObject.yA>0 ? curObject.yA/2: 0);
					//curObject.yA -= this.ejectionForce;
				}
			}
		}
	}
}