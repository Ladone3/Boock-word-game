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
	private var additionalName:String = "";
	private var areaXName:String = "";
	
	public function compileBounds(areaObject:AreaObject){
		if(areaObject){
			var bounds = areaObject.getBounds(_root);
			this.minX = bounds.xMin;
			this.minY = bounds.yMin;
			this.maxX = bounds.xMax;
			this.maxY = bounds.yMax;
		}
	}
	
	public function MovedPlatform(){
		this.areaNeeded = true;
		this.startX = this._x;
		this.startY = this._y;
		
		this.triggerX = (Math.round(Math.random()*10)>5);
		this.triggerY = (Math.round(Math.random()*10)>5);
		
		for(var i in _root){	
			var object = _root[i];
			if(object  
			&& (object instanceof AreaObject || object.isArea)
			&& this.hitTest(object)){//&& object instanceof GameObject){
				this.compileBounds(object);
			}
		}
		
		//trace(this.additionalName + "|" + this.areaXName+"|"+ this._name);
	}
	
	public function onEnterFrameNoAction() {
		super.onEnterFrameNoAction();
		//this.compileBounds();
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