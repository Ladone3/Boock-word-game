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
		//trace("AL Add: "+go._name);
		this[this.length]=go;
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
	public var MenuPlace:MovieClip=null;
	public var cameraBorder:Object=0;
	public var widthWindow:Number = 1024;
	public var heightWindow:Number = 768;
	public var borderX1:Number = widthWindow*(2/5);
	public var borderX2:Number = widthWindow*(3/5);
	public var borderY1:Number = heightWindow*(2/5);
	public var borderY2:Number = heightWindow*(3/5);
	
	public function chaseCamera(){
		if(_global.player._x < this.borderX1){
			if(this.cameraBorder==0 || this.cameraBorder.xMax>_root._x){
				_root._x+= this.borderX1 - _global.player._x;
				_global.player.hpline._x -= this.borderX1 - _global.player._x;
				this.MenuPlace._x -= this.borderX1 - _global.player._x;;
				this.fonImage._x -= (this.borderX1 - _global.player._x)*0.8;
				this.borderX1 = _global.player._x;
				this.borderX2 = _global.player._x+widthWindow*(1/5);
			}
		}
		if(_global.player._x > this.borderX2){
			if(this.cameraBorder==0 || this.cameraBorder.xMin<_root._x){
				_root._x -= _global.player._x - this.borderX2;
				_global.player.hpline._x += _global.player._x - this.borderX2;
				this.MenuPlace._x += _global.player._x - this.borderX2;
				this.fonImage._x += (_global.player._x - this.borderX2)*0.8;
				this.borderX2 = _global.player._x;
				this.borderX1 = _global.player._x-widthWindow*(1/5);
			}
		}
		
		if(_global.player._y < this.borderY1){
			if(this.cameraBorder==0 || this.cameraBorder.yMin<-_root._y){
				_root._y+=this.borderY1-_global.player._y;
				_global.player.hpline._y -= this.borderY1-_global.player._y;
				this.MenuPlace._y -= this.borderY1-_global.player._y;
				this.fonImage._y -= (this.borderY1-_global.player._y)*0.5;
				this.borderY1 = _global.player._y;
				this.borderY2 = _global.player._y+heightWindow*(1/5);
			}
		}
		if(_global.player._y > this.borderY2){
			if(this.cameraBorder==0 || this.cameraBorder.yMax>-_root._y){
				_root._y-=_global.player._y-this.borderY2;
				_global.player.hpline._y += _global.player._y-this.borderY2;
				this.MenuPlace._y += _global.player._y-this.borderY2;
				this.fonImage._y += (_global.player._y-this.borderY2)*0.5;
				this.borderY2 = _global.player._y;
				this.borderY1 = _global.player._y-heightWindow*(1/5);
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
