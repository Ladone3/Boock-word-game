class PortalToLevel extends GameObject{
	private var nocatch:Boolean = true;
	public function PortalToLevel(){
	}
	
	//Переопределение
	public function onEnterFrame(){
		super.onEnterFrame();
		if(this.nocatch)this.onEnterFrameCatchPlayer();
	}
	
	// Переопределение
	public function takeObject(object:GameObject):Boolean{
		return true;
	}
	
	// Переопределение
	public function deinit(){
		this.nocatch = true;
		return false;
	}
	
	//Переопределение
	public function onEnterFrameCatchPlayer(){
		var nWidth = this._width;
		var nHeight = this._height;
		var temp1 = this.getBounds(_root);
		if(this.lawRef.Target!=null){
				if(this.hitTest(this.lawRef.Target)&&(_root._alpha>=100)){
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