class EscMenu extends MovieClip {
	private var abstractLaw:AbstractLaw;
	private var kEsk:Number = 27;	
	private var counter:Counter;
	
	public function EscMenu(){
		this._alpha = 0;
		this._name = "EscMenu";
		this.counter = new Counter();
		if(_root["CenterOfWorld"]) this.abstractLaw = _root["CenterOfWorld"].abstractLaw;
		this.abstractLaw.MenuPlace = this;
	} 
	
	public function onEnterFrame() {
		this.counter.iterateCounter();
		if(!this.counter.notOver && Key.isDown(kEsk)){
			_global.doPause = !_global.doPause;
			this.counter.delay = 30;
		}
		if(_global.doPause && this._alpha<100){
			this._alpha += 5;
		}else if(!_global.doPause && this._alpha>0){
			this._alpha -= 5;
		}
	}
}
