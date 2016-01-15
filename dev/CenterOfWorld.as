class CenterOfWorld extends MovieClip {
	private var kEsk:Number = 27;	
	
	public function CenterOfWorld(){
		_global.abstractLaw = new AbstractLaw();
		this._name = "CenterOfWorld";
		_root._color.brightness=0;
		this._visible=false;
	} 
			
	private var startFrame=true;
	
	public function onEnterFrame() {
		if(!_global.doPause){
			_global.abstractLaw.forceIteration();
			_global.abstractLaw.chaseCamera();
			if(this.startFrame && _root._color.brightness<100){
				_root._color.brightness+=10;
			}

			if(!this.startFrame && _root._color.brightness>0){
				_root._color.brightness-=10;
				if(_root._color.brightness<=0){
					this.startFrame=true;
					_global.player.hpline._x += _root._x;
					_global.player.hpline._y += _root._y;
					_global.abstractLaw.MenuPlace._x += _root._x;
					_global.abstractLaw.MenuPlace._y += _root._y;
					_root._x = 0;
					_root._y = 0; 
					_global.abstractLaw.deinit();
					_global.abstractLaw = null;
					_root.clear();
					_root.gotoAndStop(_global.clearFrame);
				}
			}
		}
	}
	
	public function goToAndStopFrame(frame:Number){
		_global.last_level = _root._currentframe;
		_global.player.youMayTuchMe();
		_global.player._alpha = 100;
		this.startFrame = false;
		_global.nextframe=frame;
	}
	public function goToAndStopToNextFrame(){
		_global.player.hpline._visible = true;
		this.goToAndStopFrame(_root._currentframe+1);
	}
	
	public function goToAndStopToPrevFrame(){
		_global.player.hpline._visible = true;
		this.goToAndStopFrame(_root._currentframe-1);
	}

	public function goToLastLevel(){
		_global.player.hpline._visible = true;
		this.goToAndStopFrame(_global.last_level);
	}

	public function goToLimbo(){
		_global.player.hpline._visible = false;
		_global.player.life = true;
		_global.player.hpline.treatment(_global.player.hpline.HPM);
		this.goToAndStopFrame(_global.limbo_level);
	}
	
	public function goToMenu(){
		this.goToAndStopFrame(_global.menu_frame);
		_global.player.hpline.removeMovieClip();
		_global.player.hpline = null;
		_global.player.remove();
		_global.player = null;
	}
}
