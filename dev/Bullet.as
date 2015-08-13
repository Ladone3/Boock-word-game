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
		if(_root["CenterOfWorld"].abstractLaw!=undefined){
			this.law = _root["CenterOfWorld"].abstractLaw;
		}
		this._alpha = 0;
		this.xSpeed = this.velocity*Math.cos((this.angle*Math.PI)/180);
		this.ySpeed = -this.velocity*Math.sin((this.angle*Math.PI)/180);

		//trace(this._name+" created");
	}
	
	public function remov(){
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
		if((this._x < (this.lawRef.borderX1-this.lawRef.widthWindow*(3/5)))
		|| (this._x > this.lawRef.borderX2+this.lawRef.widthWindow*(3/5))
		|| (this._y < this.lawRef.borderY1-this.lawRef.heightWindow*(3/5))
		|| (this._y > this.lawRef.borderY2+this.lawRef.heightWindow*(3/5))
		){
			this.remov();
		}
		var nWidth = this._width;
		var nHeight = this._height;
		var temp1 = this.getBounds(_root);
		for(var i=0; i<GameObject.count || i<this.lawRef.length; i++){	
			if(this.lawRef[i]!= this.pmc && this.lawRef[i]!= this.pmc.pmc 
			&& this.lawRef[i]!=null && ((takeWall)||((!takeWall) && this.lawRef[i].getType()!=0))){
				var nXMin = temp1.xMin;
				var nYMin = temp1.yMin;
				var temp2 = this.lawRef[i].getBounds(_root);
				
				if(this.hitTest(this.lawRef[i])
				&&(this.lawRef[i].life)){
					temp = true;
					//trace("this.lawRef[i].name"+this.lawRef[i]._name);
					if(this.lawRef[i].getType()==2){
						if(temp2.xMin<=nXMin){
							this.lawRef[i].setDamage(this.damage,true);
						}else{
							this.lawRef[i].setDamage(this.damage,false);
						}
					}
					this.lawRef[i].xA = (this.xS/10)*this.damage;
					this.lawRef[i].yA = (this.yS/10)*this.damage;
					break;

				}
			}
		}
		return temp;
	}
	
	// Переопределение
	public function onEnterFrame() {
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
