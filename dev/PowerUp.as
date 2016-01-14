class PowerUp extends PortalToLevel{
	var String mMC="Ladone3Player";
	var String mClass="Ladone3Player";
	var state:Number = 0;
	
	// Переопределение
	public function doTeleportation(){
		this.steppedSpawn();
	}
	
	//Переопределение
	public function onEnterFrame(){
		super.onEnterFrame();
		this.objectAction();
	}
	
	// Переопределение
	public function deinit(){
		this.nocatch = true;
		this._alpha = 100;
		this.state = 0;
		return false;
	}
	
	public function steppedSpawn(){
		var player = _root.attachMovie(this.mMC, this.mClass, _root.getNextHighestDepth());
		player._x=_global.player._x;
		player._y=_global.player._y;
		player.xA = _global.player.xA;
		player.yA = _global.player.yA;
		_global.player.hpline.removeMovieClip();
		_global.player.hpline = null;
		_global.player.remove();
		_global.player = player;
		_global.player._color.brightness = 200;
		this.state++;
	}
	
	public function objectAction(){
		switch(this.state){
			case 1:
				if(this._alpha>0){
					this._alpha-=10;
					_global.player._color.brightness-=10;
				}else{
					this.state++;
					_global.player._color.brightness = 100;
				}
				break;	
		}		
	}
}