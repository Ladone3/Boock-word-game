class Bullet extends MovieClip{
	public var ID:Number = 0;	
	public var angle:Number = 0;
	public var velocity = 0;
	private var xSpeed:Number = 0;
	private var ySpeed:Number = 0;
	public var damage:Number = 0;
	public var takeWall:Boolean = true;
	private var switcher:Switcher;
	
	private static var BulletCount:Number = 0;
	private static var AllBulletCount:Number = 0;
	
	public static var BulletMass:Array = new Array();
	
	public static function get count():Number{
		return BulletCount;
	}
	public static function get AllCount():Number{
		return AllBulletCount;
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
		if((!this.life)){
			//trace("1) Counter = " + this.counter.delay + " (" + this.counter.notOver + ")");
			if(!this.counter.notOver){ 
				//trace("2) Counter = " + this.counter.delay + " (" + this.counter.notOver + ")");
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
	
	public function StartBullet(angle:Number, velocity:Number, x:Number, y:Number, d:Number, parentMovieClip:MovieClip, takeWall:Boolean){
		this.takeWall = takeWall;
		this.parentMovieClip = parentMovieClip;
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
	}
	
	public function Bullet(){
		this.counter = new Counter();
		this.switcher = new Switcher(3,this,this.counter);
		AllBulletCount++;
		this.ID = BulletCount++;
		this._name = "bullet"+(ID);
		BulletMass[ID] = this;
		this._alpha = 0;
		this.xSpeed = this.velocity*Math.cos((this.angle*Math.PI)/180);
		this.ySpeed = -this.velocity*Math.sin((this.angle*Math.PI)/180);

		//trace(this._name+" created");
	}
	
	public function remove(){
		//trace("BulletCount-1 = " + (BulletCount-1) + " ID = " + this.ID);
		if(this.ID!=(BulletCount-1)){
			//trace(this._name+" deleted");
			var del = this;
			var moved = BulletMass[BulletCount-1];
			moved._name = del._name;
			moved.ID = del.ID;
			BulletMass[this.ID] = moved;
			this.removeMovieClip();
			delete(del);
			BulletCount--;
		} else {
			//trace(this._name+" deleted");
			this.removeMovieClip();
			delete(this);
			BulletMass[this.ID]=null;
			BulletCount--;
		}
	}
	
	public function explosion(){
		//trace("!!!!!!!!!!!!");
		this.xSpeed = 0;
		this.ySpeed = 0;
		this.switcher.state = 2;
		this.counter.delay = 10;
		this.life = false;
	}
	
	public function onIterate():Boolean{
		var temp:Boolean = false;
		if((this._x < (_global.abstractLaw.borderX1-_global.abstractLaw.widthWindow*(3/5)))
		|| (this._x > _global.abstractLaw.borderX2+_global.abstractLaw.widthWindow*(3/5))
		|| (this._y < _global.abstractLaw.borderY1-_global.abstractLaw.heightWindow*(3/5))
		|| (this._y > _global.abstractLaw.borderY2+_global.abstractLaw.heightWindow*(3/5))
		){
			this.remove();
		}
		var nWidth = this._width;
		var nHeight = this._height;
		var temp1 = this.getBounds(_root);
		for(var i=0; i<GameObject.count || i<_global.abstractLaw.length; i++){	
			if(_global.abstractLaw[i]!= this.pmc && _global.abstractLaw[i]!= this.pmc.pmc 
			&& _global.abstractLaw[i]!=null && ((takeWall)||((!takeWall) && _global.abstractLaw[i].getType()!=0))){
				var nXMin = temp1.xMin;
				var nYMin = temp1.yMin;
				var temp2 = _global.abstractLaw[i].getBounds(_root);
				
				if(this.hitTest(_global.abstractLaw[i])
				&&(_global.abstractLaw[i].life)){
					temp = true;
					if(_global.abstractLaw[i].getType()==2){
						if(temp2.xMin<=nXMin){
							_global.abstractLaw[i].setDamage(this.damage,true);
						}else{
							_global.abstractLaw[i].setDamage(this.damage,false);
						}
					}
					_global.abstractLaw[i].xA = (this.xS/10)*this.damage;
					_global.abstractLaw[i].yA = (this.yS/10)*this.damage;
					break;

				}
			}
		}
		return temp;
	}
	
	// Переопределение
	public function onEnterFrame() {
		if(!_global.doPause){
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
		}
	}
}
