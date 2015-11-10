class MovedPlatform extends GameObject{
	private var triggerX:Boolean=false;
	private var triggerY:Boolean=false;
	private var minX:Number = -100;
	private var maxX:Number = 100;
	private var minY:Number = -5;
	private var maxY:Number = 5;
	private var startX;
	private var startY;
	private var speedX:Number = 3;
	private var speedY:Number = 3;
	private var areaObject:MovieClip;
	private var additionalName:String = "";
	private var areaXName:String = "";
	
	public function getAreaObjectX():MovieClip{
		if(!this.areaObject && _root[this.areaXName]){
			this.areaObject =_root[this.areaXName];
			var bounds = this.areaObject.getBounds(_root);
			this.minX = bounds.xMin;
			this.minY = bounds.yMin;
			this.maxX = bounds.xMax;
			this.maxY = bounds.yMax;
		}else if(this.areaObject){
			var bounds = this.areaObject.getBounds(_root);
			//trace("x:"+this._x + " y:" + this._y);
			//trace("x1:"+bounds.xMin + " y1:" + bounds.yMin);
			//trace("x2:"+bounds.xMax + " y2:" + bounds.yMax);
		}
		return this.areaObject;
	}
	
	public function MovedPlatform(){
		this.startX = this._x;
		this.startY = this._y;
		
		this.triggerX = (Math.round(Math.random()*10)>5);
		this.triggerY = (Math.round(Math.random()*10)>5);
		//this.speedX = 1+Math.round(Math.random()*9);
		//this.speedY = 1+Math.round(Math.random()*4);

		if(this.lastname.length>=4)this.additionalName = this.lastname.substr(0,4);
		if(this.lastname.length>=8)this.areaXName = this.lastname.substr(4,8);
		this.getAreaObjectX();
		//trace(this.additionalName + "|" + this.areaXName+"|"+ this.lastname);
	}
	
	public function onEnterFrameNoAction() {
		super.onEnterFrameNoAction();
		this.getAreaObjectX();
		var myBounds = this.getBounds(_root);
		
		var myMinX = myBounds.xMin;
		var myMinY = myBounds.yMin;
		var myMaxX = myBounds.xMax;
		var myMaxY = myBounds.yMax;
		
		if(myMaxX<=this.maxX || myMinX>=this.minX){
			if(triggerX){
				this._x+=speedX;
				this.xA=speedX;
				if(myMaxX>this.maxX)triggerX=false;
			}else{
				this._x-=speedX;
				this.xA=-speedX;
				if(myMinX<this.minX)triggerX=true;
			}
		}
		if(myMaxY<=this.maxY || myMinY>=this.minY){
			if(triggerY){
				this._y+=speedY;
				this.yA=speedY;
				if(myMaxY>this.maxY)triggerY=false;
			}else{
				this._y-=speedY;
				this.yA=-speedY;
				if(myMinY<this.minY)triggerY=true;
			}
		}
	}
}