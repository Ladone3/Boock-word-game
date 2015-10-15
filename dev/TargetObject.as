class TargetObject extends GameObject{
	private var additionalName:String;
	private var doTriger:Boolean=false;
	private var doTriger2:Boolean=false;
	
	public function TargetObject(){
		this.startX = this._x;
		this.startY = this._y;
		this.additionalName = this.lastname.substr(4,this._name.length);
		trace("My additional name "+additionalName);
	}
	
	public function onKeyObject(){
		trace("I go, how I can");
		this.doTriger = true;
	}
	
	private var startX;
	private var startY;
	public function onEnterFrame() {
		super.onEnterFrame();
		if(this.doTriger){
			if((startX-this._x>400) && (this._y-startY>400)){
				this.doTriger = false;
				this.doTriger2 = true;
			}
			if(startX-this._x<=400) this._x-=1;
			if(this._y-startY<=400) this._y+=1;
			if((startX-this._x>400) && (this._y-startY>400)){
				this.doTriger = false;
			}
		}
		if(this.doTriger2){
			if(startX-this._x>0) this._x+=1;
			if(this._y-startY>0) this._y-=1;
			if((startX-this._x<=0) && (this._y-startY<=0)){
				this.doTriger2 = false;
			}
		}
	}
}