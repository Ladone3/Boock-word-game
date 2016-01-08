class AbstractLaw extends Array{ 
	public var MaxAttractiveSpeed:Number=55;
	public var AttractiveForce:Number=4;
	public var FrictionForce:Number=1;
	
	public function forceIteration(){
		for(var i=0; i<this.length; i++){
			this.attractiveForce(i);
			this.frictionForce(i);
		}
	}
	
	public function deinit(){
		var tempArray = new Array();
		for(var i=0; i<this.length; i++){
			if(this[i] instanceof Player) this[i].breakCounter();
			if(this[i].deinit()){
				tempArray[tempArray.length]=this[i];
			}
		}
		for(var i=0; i<tempArray.length; i++){
			tempArray[i].remove();
			tempArray[i] = null;
		}
	}
	
	private function attractiveForce(i:Number) {
		//trace("1) Yahooo i'm in!");
			if(this[i].mov && this[i]!=null){
				if(this[i].yA<=this.MaxAttractiveSpeed)this[i].yA+=AttractiveForce;
			}
	}
	private function frictionForce(i:Number) {
		//trace("2) Yahooo i'm in!");
		if((this[i].mov) && (this[i].touchDown) && (this[i])){
			var nullBoost = 0;
			if(this[i].downObject && this[i].downObject.xA) nullBoost = this[i].downObject.xA;
			if(this[i].xA!=nullBoost){
				var k:Number = 1;
				if(this[i].frictionModificator) k = this[i].frictionModificator;
				if(this[i].xA>nullBoost){
					if(this[i].xA-FrictionForce*k>=nullBoost){
						this[i].xA-=FrictionForce*k; 
					}else{
						this[i].xA = nullBoost;
					}
				}else{
					if(this[i].xA+FrictionForce*k<nullBoost){
						this[i].xA+=FrictionForce*k; 
					}else{
						this[i].xA = nullBoost;
					}
				}
			}
		}
	}
	
	public function addObject(go:GameObject){
		this[this.length]=go;
	}
	
	public function getGameObject(id:String){
		for(var i=0; i<this.length; i++){
			if(this[i]._name===id){
				trace("id: "+id+" this[i]:"+this[i]+" this[i].life:"+this[i].life);
				return this[i];
			}
		}
		return null;
	}
	
	public function	AbstractLaw(){
		this._name = "AbstractLaw";
		//AsBroadcaster.initialize(this);
		for(var i=0; i<GameObject.count; i++){	
			if(_root["gameobject"+i])this.addObject(_root["gameobject"+i]);
		}
		if(_root["FonImage"]){
			this.fonImage = _root["FonImage"];
		}
		if(_root["CameraBorder"]){
			this.cameraBorder = _root["CameraBorder"].getBounds(_root);
			
		}
		if(_root["EscMenu"]){
			this.MenuPlace = _root["EscMenu"];
		}
	} 
			

	// Работа камеры
	//=============================================================================
	public var fonImage:MovieClip=null;
	public var xfonOffsetDelay = 0.8;
	public var yfonOffsetDelay = 0.5;
	public var MenuPlace:MovieClip=null;
	public var cameraBorder:Object=0;
	public var borderXMin:Number = Stage.width*(2/5);
	public var borderXMax:Number = Stage.width*(3/5);
	public var borderYMin:Number = Stage.height*(2/5);
	public var borderYMax:Number = Stage.height*(3/5);
	public var stageBounds = { xMax: (Stage.width), xMin: (0), yMax: (Stage.height), yMin: (0)};
	public var stopFrame:Boolean = false;
	
	//public var traceClip1; public var traceClip2;
	public function chaseCamera(){
		this.stageBounds = { xMax: (Stage.width-_root._x), xMin: (-_root._x), yMax: (Stage.height-_root._y), yMin: (-_root._y)};
		/*		
		if(!traceClip1){
			traceClip1 = _root.attachMovie("Target", "TraceTarget1", _root.getNextHighestDepth());
		}else{
			traceClip1._x = this.stageBounds.xMin+200;
			traceClip1._y = this.stageBounds.yMin+200;
		}
		if(!traceClip2){
			traceClip2 = _root.attachMovie("Target", "TraceTarget2", _root.getNextHighestDepth());
		}else{
			traceClip2._x = this.stageBounds.xMax-200;
			traceClip2._y = this.stageBounds.yMax-200;
		}
		*/
		if(stopFrame){
			var pbounds = _global.player.getBounds(_root);
			if(pbounds.xMin<stageBounds.xMin){
				_global.player._x += stageBounds.xMin - pbounds.xMin;
			}
			if(pbounds.xMax>stageBounds.xMax){
				_global.player._x += stageBounds.xMax - pbounds.xMax;
			}
			/*
			if(pbounds.yMin<stageBounds.yMin){
				_global.player._y += stageBounds.yMin - pbounds.yMin;
			}
			if(pbounds.yMax>stageBounds.yMax){
				_global.player._y += stageBounds.yMax - pbounds.yMax;
			}
			*/
		}else{
			if(_global.player._x < this.borderXMin){
				//trace("stageBounds.xMin = "+stageBounds.xMin + " this.cameraBorder.xMin = "+this.cameraBorder.xMin);
				if(this.cameraBorder==0 || this.cameraBorder.xMin < stageBounds.xMin){
					var xoffset = (this.borderXMin - _global.player._x);
					_root._x+=xoffset;
					
					_global.player.hpline._x -= xoffset;
					this.MenuPlace._x -= xoffset;
					this.fonImage._x -= (xoffset)*xfonOffsetDelay;
					this.borderXMin -= xoffset;
					this.borderXMax -= xoffset;
				}
			}
			if(_global.player._x > this.borderXMax){
				//trace("stageBounds.xMax = "+stageBounds.xMax + " this.cameraBorder.xMax = "+this.cameraBorder.xMax);
				if(this.cameraBorder==0 || this.cameraBorder.xMax > stageBounds.xMax){
					var xoffset = (_global.player._x - this.borderXMax);
					_root._x-=xoffset;
					
					_global.player.hpline._x += xoffset;
					
					this.MenuPlace._x += xoffset;
					this.fonImage._x += (xoffset)*xfonOffsetDelay;
					this.borderXMin += xoffset;
					this.borderXMax += xoffset;
				}
			}
			if(_global.player._y < this.borderYMin){
				if(this.cameraBorder==0 || this.cameraBorder.yMin < stageBounds.yMin){
					var yoffset = (this.borderYMin-_global.player._y);
					_root._y+= yoffset;
				
					_global.player.hpline._y -= yoffset;
					this.MenuPlace._y -= yoffset;
					this.fonImage._y -= (yoffset)*yfonOffsetDelay;
					this.borderYMin -= yoffset;
					this.borderYMax -= yoffset;
				}
			}
			if(_global.player._y > this.borderYMax){
				if(this.cameraBorder==0 || this.cameraBorder.yMax > stageBounds.yMax){
					var yoffset = (_global.player._y-this.borderYMax);
					_root._y-= yoffset;
				
					_global.player.hpline._y += yoffset;
					this.MenuPlace._y += yoffset;
					this.fonImage._y += (yoffset)*yfonOffsetDelay;
					this.borderYMin += yoffset;
					this.borderYMax += yoffset;
				}
			}
		}
	}
	
	
	// Поиск игрока в радиусе (Пока одного)
	//=============================================================================	
	public function findObject(go:MovieClip):Number{	
		if(_global.player){
			var x1 = go._x;
			var x2 = _global.player._x;
			var y1 = go._y;
			var y2 = _global.player._y;
			if(Math.abs(y1-y2)>go._height) return Number.POSITIVE_INFINITY;
			return (x2 - x1);
		}else{
			return Number.POSITIVE_INFINITY;
		}
	}
	
	public function getOffsets(go:MovieClip):Object{	
		if(_global.player){
			/*
			var obj2 = go.getBounds(_root);
			var obj1 = _global.player.getBounds(_root);
			
			var x1 = (obj1.xMin-obj1.xMax)/2;
			var y1 = (obj1.yMin-obj1.yMax)/2;
			var x2 = (obj2.xMin-obj2.xMax)/2;
			var y2 = (obj2.yMin-obj2.yMax)/2;
			
			return {xo: (x2-x1), yo: (y1-y2) };
			*/
			var x1 = go._x;
			var y1 = go._y;
			var x2 = _global.player._x;
			var y2 = _global.player._y;
			
			return {xo: (x2-x1), yo: (y2-y1) };
		}else{
			return Number.POSITIVE_INFINITY;
		}
	}
}
