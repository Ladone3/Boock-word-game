class CenterOfWorld extends MovieClip {
	public var abstractLaw:AbstractLaw;
	public function CenterOfWorld(){
		this.abstractLaw = new AbstractLaw();
		this._name = "CenterOfWorld";
		_root._alpha=0;
		trace("New CenterOfWorld!");
	}

	private var frame:Number=0;
	private var startFrame=true;
	
	public function onEnterFrame() {
		this.abstractLaw.forceIteration();
		this.abstractLaw.chaseCamera();
		if(this.startFrame && _root._alpha<100){
			_root._alpha+=10;
		}
		
		if(!this.startFrame && _root._alpha>0){
			_root._alpha-=10;
			if(_root._alpha<=0){
				this.startFrame=true;
				this.abstractLaw.IndicatorPlace._x += _root._x;
				this.abstractLaw.IndicatorPlace._y += _root._y;
				_root._x = 0;
				_root._y = 0; 
				this.abstractLaw.deinit();
				_root.gotoAndStop(frame);
			}
		}
	}
	
	
	public function goToAndStopFrame(frame:Number){
		this.startFrame = false;
		this.frame=frame;
	}
	public function goToAndStopToNextFrame(){
		this.goToAndStopFrame(_root._currentframe+1);
	}
	
	public function goToAndStopToPrevFrame(){
		this.goToAndStopFrame(_root._currentframe-1);
	}
}
