class TargetObject extends GameObject{
	private var additionalName:String;
	private var doTriger:Boolean=false;
	private var doTriger2:Boolean=false;
	
	public function TargetObject(){
		this.startX = this._x;
		this.startY = this._y;
		if(this._name.length>=4)this.additionalName = this._name.substr(4,this._name.length);
		//trace("My additional name "+additionalName);
	}
	
	public function onKeyObject(){
		//trace("I go, how I can");
		if(!this.doTriger){
			this.doTriger = true;
		}else{
			this.doTriger = false;
			this.doTriger2 = true;
		}
	}
	
	
	private var startX;
	private var startY;
	public function onEnterFrameNoAction() {
		super.onEnterFrameNoAction();
		
		//this.mov = true;
		//permissionToMov(new Point(this._x+this.xA, this._y+this.yA));
		//this.mov = false;
		
		if(this.doTriger){
			if((startX-this._x>400) && (this._y-startY>400)){
				this.doTriger = false;
				this.doTriger2 = true;
				this.xA=0;
				this.yA=0;
			}
			if(startX-this._x<=400){
				this._x-=1;
				this.xA=-1;
			}
			if(this._y-startY<=400){
				this._y+=1;
				this.yA=1;
			}
			if((startX-this._x>400) && (this._y-startY>400)){
				this.doTriger = false;
			}
		}else if(this.doTriger2){
			if(startX-this._x>0){
				this._x+=1;
				this.xA=1;
			}
			if(this._y-startY>0){
				this._y-=1;
				this.yA=-1;
			}
			if((startX-this._x<=0) && (this._y-startY<=0)){
				this.doTriger2 = false;
				this.xA=0;
				this.yA=0;
			}
		}else{
			this.xA=0;
			this.yA=0;
		}
	}
}