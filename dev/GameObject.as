//import flash.display.MovieClip;
class GameObject extends MovieClip { 
	// Подсчет количества объектов класса 
	//=======================================================
	private static var GameObjectCount:Number=0;
	private static var AllGameObjectCount:Number=0;
	public static function get count():Number{
		return GameObjectCount;
	}
	public static function get AllCount():Number{
		return AllGameObjectCount;
	}
	public var ID:Number;
	
	public function getType():Number{
		return 0;
	}
	
	// Жив ли объект?
	//======================================================
	private var lifeState:Boolean = true;
	public function set life(b:Boolean){
		this.lifeState=b;
	}
	public function get life():Boolean{
		return this.lifeState;
	}
	
	// Обрабатывать ли объект
	//======================================================
	private var calculateObject:Boolean = true;
	public function set calcObj(b:Boolean){
		this.calculateObject=b;
	}
	public function get calcObj():Boolean{
		return this.calculateObject;
	}
	
	// Обрабатывался ли объект
	//======================================================
	private var isCalculated:Boolean = true;
	public function set isCalc(b:Boolean){
		this.isCalculated=b;
	}
	public function get isCalc():Boolean{
		return this.isCalculated;
	}
	
	private function lifeOrDie(){
		if(!this.lifeState){
			this.remove();
		}
	}
		
	public static var objectsList:Array = new Array();
	
	// Ускорение по X
	//=======================================================
	private var xBoost:Number; 
	public function set xA(xBoost:Number){
		this.xBoost = xBoost;

	}
	public function get xA():Number{
		return this.xBoost;
	}
	
	// Ускорение по Y
	//=======================================================
	private var yBoost:Number; 
	public function set yA(yBoost:Number){
		this.yBoost = yBoost;
	}
	public function get yA():Number{
		return this.yBoost;
	}
	
	// Скорость по X
	//=======================================================
	private var xSpeed:Number; 
	// Скорость по Y
	//=======================================================
	private var ySpeed:Number; 
	
	public var touchLeft :Boolean = false;
	public var touchRight:Boolean = false;
	public var touchUp   :Boolean = false;
	public var touchDown :Boolean = false;
	
	// Проверка уперлись ли мы в объект, если да скидываем значение скорости в этом направлении в ноль
	//=======================================================
	private function stopOnDirection(){
		if(touchUp && yBoost<0){
			yBoost = 0;
			//trace("touchUp");
		}
		if(touchDown && yBoost>0){
			yBoost = 0;
			//trace("touchDown");
		}
		if(touchLeft && xBoost<0){
			xBoost = 0;
			//trace("touchLeft");
		}
		if(touchRight && xBoost>0){
			xBoost = 0;
			//trace("touchRight");
		}
	}	
	
	// Удалить объект
	//=========================================================
	public function remove(){
		//trace("GameObjectCount-1 = " + (GameObjectCount-1) + " ID = " + this.ID);
		/*
		if(this.ID!=(GameObjectCount-1)){
			trace(this._name+" deleted");
			var del = this;
			var moved = _global.abstractLaw[GameObjectCount-1];
			moved._name = del._name;
			moved.ID = del.ID;
			_global.abstractLaw[this.ID] = moved;
			_global.abstractLaw[GameObjectCount-1] = null;
			this.removeMovieClip();
			delete(del);
			GameObjectCount--;
		} else {
			trace(this._name+" deleted");
			this.removeMovieClip();
			delete(this);
			_global.abstractLaw[this.ID]=null;
			GameObjectCount--;
		}
		*/
		trace(this._name+" deleted");
		_global.abstractLaw[this.ID]=null;
		this.swapDepths(100000);
		this.removeMovieClip();
		delete(this);	
	}
	
	// Можно ли перемещать игровой объект
	//=======================================================
	private var moveble:Boolean;
	public function set mov(moveble:Boolean){
		this.moveble = moveble;
	}
	public function get mov():Boolean{
		return this.moveble;
	}
	public function goToAndStop(a:Number){
		this._currentframe = a;
	}
	
	public function GameObject(){
		this.xBoost = 0;
		this.yBoost = 0;
		this.xSpeed = 0;
		this.ySpeed = 0;
		this.moveble = false;
		this.ID = GameObjectCount++;
		AllGameObjectCount++;
		this._name = "gameobject"+(ID);
		if(_global.abstractLaw) _global.abstractLaw[ID]=this; 
	}
	
	public function deinit():Boolean{
		return false;
	}
	
	public function onEventActivity(minX:Number, minY:Number, maxX:Number, maxY:Number){
		trace(" minX=" + minX + " minY=" + minY + " maxX=" + maxX + " maxY=" + maxY);
	}

	// Рассчет текущей скорости
	//=======================================================
	private function calcSpeeds(){
			this.xSpeed = /*this.xSpeed + */this.xBoost;
			this.ySpeed = /*this.ySpeed + */this.yBoost;
	}
	
	public function onEnterFrameAction(){
			calcSpeeds();
			var wantX = this.xSpeed;
			var wantY = this.ySpeed; 
			if(_global.abstractLaw){
				var p = this.permissionToMov(new Point(wantX, wantY));
				this._x = this._x + p.x;
				this._y = this._y + p.y;
				touchLeft = p.left;
				touchRight = p.right;
				touchUp = p.up;
				touchDown = p.down;
				stopOnDirection();
			} else {
				this._x = wantX;
				this._y = wantY;
			}
	}
	
	// Определяем обработчик onEnterFrame() 
	public function onEnterFrame() {
		if(!_global.doPause){
			if(moveble && life){
				onEnterFrameAction();
			}
			//tracr("this.lifeOrDie()");
			this.lifeOrDie();
		}
	}
	
	public function takeObject(object:GameObject):Boolean{
		return true;
	}
	
	public function clearCalc(){
		var i=0
		do{
			if(this==_global.abstractLaw[i]){
				for(var j=0; j<count || j<_global.abstractLaw.length; j++){
					if(_global.abstractLaw[j]!=null && _global.abstractLaw[j].calcObj){
						_global.abstractLaw[j].isCalc = true;
					}
				}
				break;
			}
			i++;
		}while((i<count || i<_global.abstractLaw.length)&&(!_global.abstractLaw[i].life));
	}
	
	public function permissionToMov(np:Point):Point{
		this.clearCalc();
		this.isCalc = false;
		var left:Boolean = false;
		var right:Boolean = false;
		var up:Boolean = false;
		var down:Boolean = false;
		var rx = np.x;
		var ry = np.y;
		var nWidth = this._width;
		var nHeight = this._height;
		var temp1 = this.getBounds(_root);
		for(var i=0; i<count || i<_global.abstractLaw.length; i++){
			if(_global.abstractLaw[i].calcObj && _global.abstractLaw[i].isCalc && _global.abstractLaw[i]!=null  && takeObject(_global.abstractLaw[i])){
				var nXMin = temp1.xMin + np.x;
				var nYMin = temp1.yMin + np.y;
				var temp2 = _global.abstractLaw[i].getBounds(_root);
				if((nXMin >= temp2.xMin - nWidth)&&(nYMin >= temp2.yMin - nHeight)&&(nXMin <= temp2.xMax)&&(nYMin <= temp2.yMax)){
					var razn1 = nXMin - (temp2.xMin - nWidth);
					var razn2 = nYMin - (temp2.yMin - nHeight);
					var razn3 = temp2.xMax - nXMin;
					var razn4 = temp2.yMax - nYMin;
					if((razn1 <= razn2)&&(razn1 <= razn3)&&(razn1 <= razn4)){
						rx = rx - razn1;
						right = true;
					}else{
						if((razn2 <= razn1)&&(razn2 <= razn3)&&(razn2 <= razn4)){
							ry = ry - razn2;
							down = true;
						}else{
							if((razn3 <= razn1)&&(razn3 <= razn2)&&(razn3 <= razn4)){
								rx = rx + razn3;
								left = true; 
							}else{
								if((razn4 <= razn1)&&(razn4 <= razn2)&&(razn4 <= razn3)){
									ry = ry + razn4;
									up = true;
								}
							}
						}
					}
				}else{
				// Это как-то не очень работает!
				//=============================================================================
				/*
					trace("====0====");
					if((temp1.yMin < temp2.yMax)&&(temp1.yMin > temp2.yMin - nHeight)){
						if(temp1.xMin <= temp2.xMin - nWidth && nXMin >= temp2.xMax){ 
							//nXMin = temp2.xMin - nWidth;
							rx = temp2.xMin - nWidth - temp1.xMin;
							trace("====1====");
						}else{
							if(temp1.xMin >= temp2.xMax && nXMin <= temp2.xMin - nWidth){ 
								//nXMin = temp2.xMax;
								rx = temp1.xMin - temp2.xMax;
								trace("====2====");
							}
						}
					}
					if((temp1.xMin < temp2.xMax)&&(temp1.xMin > temp2.xMin - nWidth)){
						if(temp1.yMin <= temp2.yMin - nHeight && nYMin >= temp2.yMax){ 
							//nYMin = temp2.yMin - nHeight;
							ry = temp2.yMin - nHeight - temp1.yMin
							temp1.yBoost=0;
							trace("====3====");
						}else{
							if(temp1.yMin >= temp2.yMax && nYMin <= temp2.yMin - nHeight){ 
								//nYMin = temp2.yMax;
								ry = temp1.yMin - temp2.yMax;
								temp1.yBoost=0;
								trace("====4====");
							}
						}
					}
					*/
				//=============================================================================
				}
			}	
		}
		return new Point(rx,ry,up,down,left,right);
	}
	
	// Поиск игрока в радиусе (Пока одного)
	//=============================================================================	
	public function onRadius(go:GameObject, radius:Number):Boolean{		
		if(go!=null){
				var x1 = this._x;
				var y1 = this._y;
				var x2 = go._x;
				var y2 = go._y;
				var dist = Math.pow(Math.pow(x1-x2,2)+Math.pow(y1-y2,2),0.5);
				if(dist<=radius){
					return true;
				}else{
					return false;
				}
		}else{
			return false;
		}
	}
}
