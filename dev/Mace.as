class Mace extends MovieClip{
	public var ID:Number = 0;	
	public var angle:Number = 0;
	public var velocity = 0;
	private var xSpeed:Number = 0;
	private var ySpeed:Number = 0;
	public var damage:Number = 0;
	public var distance:Number = 0;
	private var switcher:Switcher;
	private static var MaceCount:Number = 0;
	private static var AllMaceCount:Number = 0;
	public static var MaceMass:Array = new Array();
	
	public static function get count():Number{
		return MaceCount;
	}
	public static function get AllCount():Number{
		return AllMaceCount;
	}
	
	public function get xS():Number{
		return this.xSpeed;
	}
	public function get yS():Number{
		return this.ySpeed;
	}
	
	private var parentMovieClip;
	public function set pmc(pmc){
		this.parentMovieClip = pmc;
	}
	public function get pmc(){
		return this.parentMovieClip;
	}
	// Жив ли объект?
	//======================================================
	private var life:Boolean = true;
	private function lifeOrDie(){
		if(!this.life){
			//trace("1) trace");
			if(!this.counter.notOver){ 
				//trace("2) trace");
				this.remov();
			}
		}
	}
	
	// Блокировка анимации
	//=======================================================
	private var counter:Counter;
	
	// Ссылка на разрешитель столкновений и законов физики
	//=======================================================
	private var lawRef:AbstractLaw; 
	public function set law(lawRef:AbstractLaw){
		this.lawRef = lawRef;
	}
	
	public function get law():AbstractLaw{
		return this.lawRef;
	}

	
	public function set ang(angle:Number){
		this.angle = angle;
		this.xSpeed = this.velocity*Math.cos((this.angle*Math.PI)/180);
		this.ySpeed = -this.velocity*Math.sin((this.angle*Math.PI)/180);
		this._rotation = angle;
	}
	public function get ang():Number{
		return this.angle;
	}
	public function set vel(velocity:Number){
		this.velocity = velocity;
		this.xSpeed = this.velocity*Math.cos((this.angle*Math.PI)/180);
		this.ySpeed = -this.velocity*Math.sin((this.angle*Math.PI)/180);
		this._rotation = angle;
	}
	public function get vel():Number{
		return this.velocity;
	}
	
	public function StartMace(angle:Number, velocity:Number, x:Number, y:Number, d:Number, dd:Number, parentMovieClip:MovieClip){
		this.parentMovieClip = parentMovieClip;
		//this._xscale = this.parentMovieClip._xscale;
		//this._yscale = this.parentMovieClip._yscale;
		this._x = x;
		this._y = y;
		this.angle = angle;
		this.velocity = velocity;
		this.xSpeed = this.velocity*Math.cos((this.angle*Math.PI)/180);
		this.ySpeed = -this.velocity*Math.sin((this.angle*Math.PI)/180);
		this._alpha = 100;
		this.switcher.state = 1;
		this._rotation = -angle;
		this.damage = d;
		this.distance = dd;
	}
	
	public function Mace(){
		this.counter = new Counter();
		this.switcher = new Switcher(3,this,this.counter);
		AllMaceCount++;
		this.ID = MaceCount++;
		this._name = "mace"+(ID);
		MaceMass[ID] = this;
		if(_root["CenterOfWorld"].abstractLaw!=undefined){
			this.law = _root["CenterOfWorld"].abstractLaw;
		}
		this._alpha = 0;
		this.xSpeed = this.velocity*Math.cos((this.angle*Math.PI)/180);
		this.ySpeed = -this.velocity*Math.sin((this.angle*Math.PI)/180);

		//trace(this._name+" created");
	}
	
	private static var myDepth:Number=-1;
	public static function get ropeDepth(){
		if(myDepth==-1){
			myDepth = _root.getNextHighestDepth();
		}
		return myDepth;
	}
	
	private function drawSpring(xpos1:Number, ypos1:Number, xpos2:Number, ypos2:Number, visible:Boolean){
//		var alpha = 30;
//		if(!visible){
//			alpha = 0;
//		}
		_root.createEmptyMovieClip("line_mc", ropeDepth);
		//_root.line_mc.lineStyle(2, 70, alpha, true, "normal", "round", "miter", 1);
		_root.line_mc.moveTo(xpos1, ypos1);
		//длина линии
		var ln:Number = Math.sqrt(Math.pow((xpos2-xpos1),2) + Math.pow((ypos2 - ypos1),2));
		var d = ln/20;
		if(d<1){
			d=1;
		}
		var d = ln/20;
		//синус косинус
		var sin:Number = (ypos2 - ypos1)/ln;
		var cos:Number = (xpos2 - xpos1)/ln;
		var sin0:Number = Math.sin(Math.asin(sin)*180/Math.PI+90);
		var cos0:Number = Math.cos(Math.asin(sin)*180/Math.PI+90);
		var lastxPos1:Number = xpos1;
		var lastyPos1:Number = ypos1;
				
		lastxPos1 += d*cos;
		lastyPos1 += d*sin;
				
		xpos2 -= 4*d*cos;
		ypos2 -= 4*d*sin;
		var alpha = 0;
		_root.line_mc.lineStyle(2, 70, alpha, true, "normal", "round", "miter", 1);
		for(var i=0; (i+2)*(d*2)<=ln; i++){
			if(visible){
				alpha+=2;
				_root.line_mc.lineStyle(2, 70, alpha, true, "normal", "round", "miter", 1);
			}

			_root.line_mc.moveTo(xpos1, ypos1);
			xpos1 += d*cos-(10*cos0);
			ypos1 += d*sin+(10*sin0);
			_root.line_mc.lineTo(xpos1, ypos1);
			
			xpos1 += d*cos+(10*cos0);
			ypos1 += d*sin-(10*sin0);
			_root.line_mc.lineTo(xpos1, ypos1);
			
			_root.line_mc.moveTo(lastxPos1, lastyPos1);
			lastxPos1 += d*cos-(10*cos0);
			lastyPos1 += d*sin+(10*sin0);
			_root.line_mc.lineTo(lastxPos1, lastyPos1);
			
			lastxPos1 += d*cos+(10*cos0);
			lastyPos1 += d*sin-(10*sin0);
			_root.line_mc.lineTo(lastxPos1, lastyPos1);

		}
		//_root.line_mc.lineTo(xpos2, ypos2);
	}
	private function drawRope(visible:Boolean){
		drawSpring(this._x,this._y,this.parentMovieClip._x, this.parentMovieClip._y,visible);
	}
	
	public function remov(){
		//trace("I wont be removed!");
		if((Math.abs(this._x-this.parentMovieClip._x)<100) && (Math.abs(this._y-this.parentMovieClip._y)<200)){
		//trace("MaceCount-1 = " + (MaceCount-1) + " ID = " + this.ID);
			this.parentMovieClip.cmc = null;
			this.drawRope(false);
			if(this.ID!=(MaceCount-1)){
				//trace(this._name+" deleted");
				var del = this;
				var moved = MaceMass[MaceCount-1];
				moved._name = del._name;
				moved.ID = del.ID;
				MaceMass[this.ID] = moved;
				this.removeMovieClip();
				delete(del);
				MaceCount--;
			} else {
				//trace(this._name+" deleted");
				this.removeMovieClip();
				delete(this);
				MaceMass[this.ID]=null;
				MaceCount--;
			}
		}else{
		
			this.life = false;
			this.HomewardBound();
		}
	}
	// Извинения за бредовую функцию, лень было её переписывать((
	private function HomewardBound(){
		var w:Number = Math.abs(this._x - this.parentMovieClip._x);
		var h:Number = Math.abs(this._y - this.parentMovieClip._y);
		var g:Number = Math.pow(Math.pow(w,2)+Math.pow(h,2),0.5);
		var sinm:Number = w/g;
		var cosm:Number = h/g;
		var angle:Number=0;
		if(this._x>this.parentMovieClip._x){
			if(this._y>this.parentMovieClip._y){
				angle = Math.abs(Math.asin(sinm)*180/Math.PI-90);
			}else{
				angle = -Math.abs(Math.asin(sinm)*180/Math.PI-90);
			}
		}else{
			if(this._y>this.parentMovieClip._y){
				angle = Math.abs(Math.asin(sinm)*180/Math.PI+90);
			}else{
				angle = -Math.abs(Math.asin(sinm)*180/Math.PI+90);
			}
		}
		this._rotation = angle;
		if(this._x<this.parentMovieClip._x){
			this.xSpeed = this.velocity*sinm;	
		}else{
			this.xSpeed = -this.velocity*sinm;
		}
		if(this._y<this.parentMovieClip._y){
			this.ySpeed = this.velocity*cosm;	
		}else{
			this.ySpeed = -this.velocity*cosm;
		}
		
	}
	
	private function explosion(){
		this.xSpeed = 0;
		this.ySpeed = 0;
		this.switcher.state = 2;
		_root.attachMovie("BlowEffect", "blowEffect0", _root.getNextHighestDepth());
		_root.blowEffect0._x = this._x;
		_root.blowEffect0._y = this._y;
		_root.blowEffect0._rotation = this._rotation;
		_root.blowEffect0._xscale = this._xscale/3;
		_root.blowEffect0._yscale = this._yscale/3;
		_root.blowEffect0._alpha = 50;
		this.counter.delay = 2;
		this.life = false;
	}
	
	public function onIterate():Boolean{
		var temp:Boolean = false;
		if((this._x < (this.lawRef.borderX1-this.lawRef.widthWindow*(3/5)))
		|| (this._x > this.lawRef.borderX2+this.lawRef.widthWindow*(3/5))
		|| (this._y < this.lawRef.borderY1-this.lawRef.heightWindow*(3/5))
		|| (this._y > this.lawRef.borderY2+this.lawRef.heightWindow*(3/5))
		){
			trace("this._x = "+ this._x);
			this.remov();
		}
		var nWidth = this._width;
		var nHeight = this._height;
		var temp1 = this.getBounds(_root);
		for(var i=0; i<GameObject.count || i<this.lawRef.length; i++){	
			if(this.lawRef[i]!= this.pmc && this.lawRef[i]!= this.pmc.pmc && this.lawRef[i]!=null){
				var nXMin = temp1.xMin;
				var nYMin = temp1.yMin;
				var temp2 = this.lawRef[i].getBounds(_root);
				
				if((nXMin >= temp2.xMin - nWidth)&&(nYMin >= temp2.yMin - nHeight)
				&&(nXMin <= temp2.xMax)&&(nYMin <= temp2.yMax)&&(this.lawRef[i].life)){
					temp = true;
					if(this.lawRef[i].getType()==2){
						if(temp2.xMin<=nXMin){
							this.lawRef[i].setDamage(this.damage,true);
						}else{
							this.lawRef[i].setDamage(this.damage,false);
						}
					}
					this.lawRef[i].xA = this.xS/2;
					this.lawRef[i].yA = this.yS/2;
					break;
				}
			}
		}
		return temp;
	}
	
	// Переопределение
	public function onEnterFrame() {
		//trace("Cycle trace");
		this._x+=this.xSpeed;
		this._y+=this.ySpeed;
		if((this.life)&&(this.onIterate())){
			//trace("3) Counter = " + this.counter.delay + " (" + this.counter.notOver + ")");
			explosion();
		} else {
			//trace("4) Counter = " + this.counter.delay + " (" + this.counter.notOver + ")");
			this.lifeOrDie();
		}
		this.counter.iterateCounter();
		if(this.life){
			this.distance--;
			if(this.distance<=0){
				this.xSpeed = 0;
				this.ySpeed = 0;
				this.life=false;
			}
		}
		this.drawRope(true);
	}
}
