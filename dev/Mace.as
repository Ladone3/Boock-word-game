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
				this.remove();
			}
		}
	}
	
	// Блокировка анимации
	//=======================================================
	private var counter:Counter;
	
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
		this._visible = true;
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
		this._visible = false;
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
	}
	private function drawRope(visible:Boolean){
		drawSpring(this._x,this._y,this.parentMovieClip._x, this.parentMovieClip._y,visible);
	}
	
	public function remove(){
		if((Math.abs(this._x-this.parentMovieClip._x)<100) && (Math.abs(this._y-this.parentMovieClip._y)<200)){
			this.parentMovieClip.cmc = null;
			this.drawRope(false);
			if(this.ID!=(MaceCount-1)){
				var del = this;
				var moved = MaceMass[MaceCount-1];
				moved._name = del._name;
				moved.ID = del.ID;
				MaceMass[this.ID] = moved;
				this.removeMovieClip();
				delete(del);
				MaceCount--;
			} else {
				this.removeMovieClip();
				delete(this);
				MaceMass[this.ID]=null;
				MaceCount--;
			}
		}else{
			this.life = false;
			this.homewardBound();
		}
	}
	// Извинения за бредовую функцию, лень было её переписывать((
	private function homewardBound(){
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
		//trace("this._x: "+this._x);
		//trace("this._y: "+this._y);
		this.xSpeed = 0;
		this.ySpeed = 0;
		this.switcher.state = 2;
		var blowEffect = _root.attachMovie("BlowEffect", "blowEffect_"+this._name, _root.getNextHighestDepth());
		blowEffect._x = (this ? this._x : _global.player._x);
		blowEffect._y = (this ? this._y : _global.player._y);
		blowEffect._rotation = this._rotation;
		blowEffect._xscale = this._xscale/3;
		blowEffect._yscale = this._yscale/3;
		//blowEffect._alpha = 50;
		this.counter.delay = 2;
		this.life = false;
	}
	
	public function onIterate():Boolean{
		var temp:Boolean = false;
		if((this._x < (_global.abstractLaw.borderX1-_global.abstractLaw.widthWindow*(3/5)))
		|| (this._x > _global.abstractLaw.borderX2+_global.abstractLaw.widthWindow*(3/5))
		|| (this._y < _global.abstractLaw.borderY1-_global.abstractLaw.heightWindow*(3/5))
		|| (this._y > _global.abstractLaw.borderY2+_global.abstractLaw.heightWindow*(3/5))
		){
			trace("this._x = "+ this._x);
			this.remove();
		}
		var nWidth = this._width;
		var nHeight = this._height;
		var temp1 = this.getBounds(_root);
		for(var i=0; i<GameObject.count || i<_global.abstractLaw.length; i++){	
			if(_global.abstractLaw[i]!= this.pmc && _global.abstractLaw[i]!= this.pmc.pmc && _global.abstractLaw[i]!=null
				&& _global.abstractLaw[i].calcObj){
				var nXMin = temp1.xMin;
				var nYMin = temp1.yMin;
				var temp2 = _global.abstractLaw[i].getBounds(_root);
				
				if((nXMin >= temp2.xMin - nWidth)&&(nYMin >= temp2.yMin - nHeight)
				&&(nXMin <= temp2.xMax)&&(nYMin <= temp2.yMax)&&(_global.abstractLaw[i].life)){
					temp = true;
					if(_global.abstractLaw[i].getType()==2){
						if(temp2.xMin<=nXMin){
							_global.abstractLaw[i].setDamage(this.damage,true);
						}else{
							_global.abstractLaw[i].setDamage(this.damage,false);
						}
					}
					if(_global.abstractLaw[i].mov){
						_global.abstractLaw[i].xA = this.xS/2;
						_global.abstractLaw[i].yA = this.yS/2;
					}
					break;
				}
			}
		}
		return temp;
	}
	
	// Переопределение
	public function onEnterFrame() {
		if(!_global.doPause){
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
}
