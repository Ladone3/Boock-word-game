class CenterOfWorld extends MovieClip {
	private var kEsk:Number = 27;	
	
	public function CenterOfWorld(){
		_global.abstractLaw = new AbstractLaw();
		this._name = "CenterOfWorld";
		_root._alpha=0;
		this._alpha=0;
	} 
			
	private var frame:Number=0;
	private var startFrame=true;
	
	public function onEnterFrame() {
		if(!_global.doPause){
			_global.abstractLaw.forceIteration();
			_global.abstractLaw.chaseCamera();
			if(this.startFrame && _root._alpha<100){
				_root._alpha+=10;
			}
			
			if(!this.startFrame && _root._alpha>0){
				_root._alpha-=10;
				if(_root._alpha<=0){
					this.startFrame=true;
					_global.player.hpline._x += _root._x;
					_global.player.hpline._y += _root._y;
					_global.abstractLaw.MenuPlace._x += _root._x;
					_global.abstractLaw.MenuPlace._y += _root._y;
					_root._x = 0;
					_root._y = 0; 
					_global.abstractLaw.deinit();
					_global.abstractLaw = null;
					_root.gotoAndStop(frame);
				}
			}
		}
	}
	
	
	public function goToAndStopFrame(frame:Number){
		_global.last_level = _root._currentframe;
		this.startFrame = false;
		this.frame=frame;
	}
	public function goToAndStopToNextFrame(){
		_global.player.hpline._alpha = 100;
		this.goToAndStopFrame(_root._currentframe+1);
	}
	
	public function goToAndStopToPrevFrame(){
		_global.player.hpline._alpha = 100;
		this.goToAndStopFrame(_root._currentframe-1);
	}

	public function goToLastLevel(){
		_global.player.hpline._alpha = 100;
		this.goToAndStopFrame(_global.last_level);
	}

	public function goToLimbo(){
		_global.player.hpline._alpha = 0;
		_global.player.life = true;
		_global.player.hpline.treatment(_global.player.hpline.HPM);
		this.goToAndStopFrame(_global.limbo_level);
	}
	
	public function goToMenu(){
		_global.player.hpline.removeMovieClip();
		_global.player.hpline = null;
		_global.player.remove();
		_global.player = null;
		this.goToAndStopFrame(_global.menu_frame);
	}
}
