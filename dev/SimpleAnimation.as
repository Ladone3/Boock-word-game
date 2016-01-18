class SimpleAnimation extends MovieClip{
	public function SimpleAnimation(){
		this.stop();
	}
	
	// Переопределение
	public function onEnterFrame() {
		if(this._currentframe == this._totalframes){
			this.stop();
			this.removeMovieClip();
		}else{
			this.nextFrame();
			this.stop();
		}
	}
}