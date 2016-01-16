class Deep extends GameObject{
	public function Deep(){
	}

	//Переопределение
	public function onEnterFrame(){
		super.onEnterFrame();
		this.onEnterFrameCatchPlayer();
	}

	// Переопределение
	public function takeObject(object:GameObject):Boolean{
		return true;
	}

	//Переопределение
	public function onEnterFrameCatchPlayer(){
		var nWidth = this._width;
		var nHeight = this._height;
		var temp1 = this.getBounds(_root);
		if(_global.player!=null){
				if(this.hitTest(_global.player)){
					_global.player.youMayTuchMe();
					_global.player.setDamage(_global.player.hpline.HPM/4);
					_global.abstractLaw.movePlayerToLastPlace();
				}
		}
	}

	// Переопределение
	public function getType():Number{
		return 101;
	}
}
