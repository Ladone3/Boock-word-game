class DethLine extends GameObject{
	private var nocatch:Boolean = true;
	public function DethLine(){
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
		if(_global.player!=null){
				if(this.hitTest(_global.player)&&(_root._color.brightness>=100)){
					this.nocatch = false;
					_global.player.stopTrigger();
					_global.player.setDamage(_global.player.hpline.HPM)
				}else{
					this.nocatch = true;
				}
		}
	}

	// Переопределение
	public function getType():Number{
		return 101;
	}
}
