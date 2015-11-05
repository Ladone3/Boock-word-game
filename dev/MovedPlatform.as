class MovedPlatform extends GameObject{
		
	public function MovedPlatform(){
		this.startX = this._x;
		this.trigger = (Math.round(Math.random()*10)>5);
		this.speed = Math.round(Math.random()*5);
	}
	private var trigger:Boolean=false;;
	private var minX:Number = -100;
	private var maxX:Number = 100;
	private var startX;
	private var speed:Number = 5;
	public function onEnterFrameNoAction() {
		super.onEnterFrameNoAction();
		if(trigger){
			this._x+=speed;
			this.xA=speed;
			if(this._x-this.startX>maxX)trigger=false;
		}else{
			this._x-=speed;
			this.xA=-speed;
			if(this._x-this.startX<minX)trigger=true;
		}
	}
}