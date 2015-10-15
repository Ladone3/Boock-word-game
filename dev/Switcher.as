class Switcher {
	// Ссылка на объект, состояние которого предстоит менять
	//======================================================
	private var timer:Counter;
	public function get counter():Counter{
		return this.timer;
	}
	
	private var movieClip:MovieClip;
	public function get mc():MovieClip{
		return this.movieClip;
	}
	
	private var MaxState:Number = 1;
	public function get Max():Number{
		return this.MaxState;
	}
	
	private	var movieClipState:Number = 0;
	public function get state():Number{
		return this.movieClipState;
	}
	public function set state(movieClipState:Number){
		if(this.timer && !this.timer.notOver){
			if((movieClipState>0)&&(movieClipState<=MaxState)){
				this.movieClipState = movieClipState;
			}else{
				this.movieClipState = 0;
			}
		}
	}
	
	public function Switcher(MaxState:Number, movieClip:MovieClip, counter:Counter){
		this.movieClip = movieClip;
		this.MaxState = MaxState;
		this.timer = counter;
		this.watch("movieClipState", onStateSelection, 1);
	}
	
	public function onStateSelection(nameValue:String, lastState:Number, newState:Number, dop){
			this.movieClip.gotoAndStop(newState);
			return newState;
	}
}