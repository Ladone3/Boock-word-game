class PortalToLevel extends GameObject{
	private var nocatch:Boolean = true;
	public function PortalToLevel(){
		this.calcObj = false;
	}
	
	//Переопределение
	public function onEnterFrame(){
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
				if(this.hitTest(_global.player)&&(_root._color.brightness>=100)){
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
	public function getType():String{
		return "PortalToLevel";
	}
}