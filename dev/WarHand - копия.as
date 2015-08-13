class WarHand extends MovieClip{
	private var counter:Counter;
	private var switcher:Switcher;
	private var parentMovieClip:MovieClip;
	private var direction:Boolean;
	public var damage:Number;
	
	private var parentSwitcher:Switcher;
	public function set parent(parentSwitcher:Switcher){
		this.parentSwitcher = parentSwitcher;
		var MaxState:Number = (this.parentSwitcher.Max) + 8;
		this.switcher = new Switcher(MaxState,this,this.counter);
	}

	public function WarHand(){
		this.counter = new Counter();
	}
	
	public function create(parentMovieClip:MovieClip, parentSwitcher:Switcher, direction:Boolean, d:Number){
		this.parentSwitcher = parentSwitcher;
		this.damage = d;
		var MaxState:Number = (this.parentSwitcher.Max) + 8;
		this.switcher = new Switcher(MaxState,this,this.counter);
		this.parentMovieClip = parentMovieClip;
		this._x = this.parentMovieClip._x;
		this._y = this.parentMovieClip._y;
		this._xscale = this.parentMovieClip._xscale;
		this._yscale = this.parentMovieClip._yscale;
		this.direction = direction;
	}
	
	public function blow(direction:Boolean){
		var b = _root.attachMovie("Bullet", "bullet"+(Bullet.count), (Bullet.AllCount+GameObject.AllCount+2));
		if(this.direction == direction){
			if(this.direction){
				this.switcher.state = 11;
				b.StartBullet(0, 25, this._x+100, this._y,this.damage);
			}else{
				this.switcher.state = 12;
				b.StartBullet(180, 25, this._x-100, this._y,this.damage);
			}
		}
		this.counter.delay = 10;
	}
	
	public function blowUp(direction:Boolean){
		var b = _root.attachMovie("Bullet", "bullet"+(Bullet.count), (Bullet.AllCount+GameObject.AllCount+2));
		if(this.direction == direction){
			if(this.direction){
				this.switcher.state = 17;
				b.StartBullet(90, 25, this._x+20, this._y-100,this.damage);
			}else{
				this.switcher.state = 18;
				b.StartBullet(90, 25, this._x-50, this._y-100,this.damage);
			}
		}
		this.counter.delay = 10;
	}
	
	public function blowDown(direction:Boolean){
		var b = _root.attachMovie("Bullet", "bullet"+(Bullet.count), (Bullet.AllCount+GameObject.AllCount+2));
		if(this.direction == direction){
			if(this.direction){
				this.switcher.state = 19;
				b.StartBullet(270, 25, this._x-50, this._y+100,this.damage);
			}else{
				this.switcher.state = 20;
				b.StartBullet(270, 25, this._x+25, this._y+100,this.damage);
			}
		}
		this.counter.delay = 10;
	}
	
	public function blowDownAndForward(direction:Boolean){
		var b = _root.attachMovie("Bullet", "bullet"+(Bullet.count), (Bullet.AllCount+GameObject.AllCount+2));
		if(this.direction == direction){
			if(this.direction){
				this.switcher.state = 21;
				b.StartBullet(315, 25, this._x+100, this._y+100,this.damage);
			}else{
				this.switcher.state = 22;
				b.StartBullet(225, 25, this._x-100, this._y+100,this.damage);
			}
		}
		this.counter.delay = 10;
	}
	
	public function blowUpAndForward(direction:Boolean){
		var b = _root.attachMovie("Bullet", "bullet"+(Bullet.count), (Bullet.AllCount+GameObject.AllCount+2));
		if(this.direction == direction){
			if(this.direction){
				this.switcher.state = 15;
				b.StartBullet(45, 25, this._x+100, this._y-100,this.damage);
			}else{
				this.switcher.state = 16;
				b.StartBullet(135, 25, this._x-100, this._y-100,this.damage);
			}
		}
		this.counter.delay = 10;
	}

	
	public function Iteraion(up:Boolean, down:Boolean, left:Boolean, right:Boolean, fight:Boolean, direction:Boolean){
		
if(this.direction != direction) this.counter.delay = -1; 
		if(!this.counter.notOver && parentMovieClip.life){
			if((fight)&&(this.direction == direction)){
				//parentMovieClip.hpline.damage(10);
				//parentMovieClip.hpline.treatment(10);
				if((!up) && (!down)){
					this.blow(direction);
				}
				
				if((up) && (!down) && (left || right)){
					this.blowUpAndForward(direction);
				}
				
				if((up) && (!down) && (!left) && (!right)){
					this.blowUp(direction);
				}
				if((up) && (down)){
					this.switcher.state = this.parentSwitcher.state;
				}
				if((!up) && (down) && (!right) && (!left)){
					this.blowDown(direction);
				}
				if((!up) && (down) && (right || left)){
					this.blowDownAndForward(direction);
				}
				//if((fight) && (up) && (left || right) && (!down)){
				//if(this.direction == direction)
			} else {
				this.switcher.state = this.parentSwitcher.state;
			}
		}else{
			if(!parentMovieClip.life){
				this.switcher.counter.delay = 0;
				this.switcher.state = this.parentSwitcher.state;
			}
		}
		this.counter.iterateCounter();
		this._x = this.parentMovieClip._x;
		this._y = this.parentMovieClip._y;
	}
}

			//this.switcher.state = this.parentSwitcher.state;
			//if(Key.isDown(kUp)){
			//this.yBoost = 5;
			//}
			//if(Key.isDown(kDown)){
			//this.yBoost = 5;
			//}