class PortalToLevel extends GameObject{
	private var nocatch:Boolean = true;
	public function PortalToLevel(){
	}
	
	//Переопределение
	public function onEnterFrame(){
		this.calcObj = false;
		if(this.nocatch)this.onEnterFrameCatchPlayer();
	}
	
	// Переопределение
	public function takeObject(object:GameObject):Boolean{
		return false;
	}
	
	// Переопределение
	public function deinit(){
		this.nocatch = true;
		return false;
	}
	
	//Переопределение
	public function onEnterFrameCatchPlayer(){
		if(_global.player!=null){
				if(this.hitTest(_global.player)&&(_root._alpha>=100)){
					this.nocatch = false;
					this.doTeleportation();
				}else{
					this.nocatch = true;
				}
		}	
	}

	public function doTeleportation(){
		_root["CenterOfWorld"].goToAndStopToNextFrame();
	}
	
	// Переопределение
	public function getType():Number{
		return 100;
	}
}