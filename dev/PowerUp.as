class PowerUp extends PortalToLevel{
	var mMC:String="Ladone3Player";
	var mClass:String="Ladone3Player";
	var stateNumber:Number = 0;
	var SCALE:Number = 0.5;
	
	// Переопределение
	public function doTeleportation(){
		this.stateNumber++;
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
		this.varIterator = 100;
		this.stateNumber = 0;
		return false;
	}
	
	public function steppedSpawn(){
		var params = { x:_global.player._x,
					   y:_global.player._y,
					   hpx:_global.player.hpline._x,
					   hpy:_global.player.hpline._y,
					   xA:_global.player.xA,
					   yA:_global.player.yA,
					   scale: SCALE,
					   state: _global.player.getSwitcher().state
					   };
		
		_global.player.hpline.removeMovieClip();
		_global.player.hpline = null;
		_global.player.remove();
		_global.player = null;
		
		_global.LOT = !_global.LOT;
		trace("Change player!");
		
		var newPlayer = _root.attachMovie(this.mMC, this.mClass, _root.getNextHighestDepth());
		newPlayer._x = params.x;
		newPlayer._y = params.y;
		newPlayer.xA = params.xA;
		newPlayer.yA = params.yA;
		newPlayer.hpline._x = params.hpx;
		newPlayer.hpline._y = params.hpy;
		//newPlayer.getSwitcher().state = params.state;
		newPlayer.setScale(params.scale);
		_global.player = newPlayer;
		_global.player._color.brightness = this.varIterator;

		this.stateNumber++;
	}
	
	private var varIterator = 100;
	public function objectAction(){
		switch(this.stateNumber){
			case 1:
				if(this.varIterator<500){
					this._alpha-=1;
					_global.player._color.brightness = (this.varIterator+=10);
				}else{
					this.stateNumber++;
					_global.player._color.brightness = 500;
				}
				break;
			case 2:
				if(!_global.LOT){
					this.steppedSpawn();
				}else{
					this.stateNumber++;
				}
				break;
			case 3:
				if(this.varIterator>100 || _global.player.hpline.HP<_global.player.hpline.HPM){
					this._alpha-=1;
					_global.player._color.brightness = (this.varIterator-=10);
					_global.player.ladoneHandL._color.brightness = (this.varIterator);
					_global.player.ladoneHandR._color.brightness = (this.varIterator);
					_global.player.hpline.treatment(5);
				}else{             
					this.stateNumber++;
					_global.player._color.brightness = 100;
					_global.player.ladoneHandL._color.brightness = 100;
					_global.player.ladoneHandR._color.brightness = 100;
				}
				break;
			case 4:
				this.remove();
				break;
			default:
				break;
		}		
	}
}