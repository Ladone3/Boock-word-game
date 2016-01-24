class WarHand extends MovieClip{
	private var counter:Counter;
	private var switcher:Switcher;
	private var parentMovieClip:MovieClip;
	private var direction:Boolean;
	public var damage:Number;
	public var distance:Number = 6;	
	private var chieldBullet:MovieClip;
	// Объект трансформер цветов
	public var _color:ColorTransformer;
	
	public function get cmc():MovieClip{
		return this.chieldBullet;
	}
	public function set cmc(cmc:MovieClip){
		this.chieldBullet = cmc;
	}
	public function get pmc():MovieClip{
		return this.parentMovieClip;
	}
	
	private var parentSwitcher:Switcher;
	public function set parent(parentSwitcher:Switcher){
		this.parentSwitcher = parentSwitcher;
		var MaxState:Number = (this.parentSwitcher.Max) + 8;
		this.switcher = new Switcher(MaxState,this,this.counter);
	}

	public function WarHand(){
		this.counter = new Counter();
		this._color = new ColorTransformer(this);
	}
	
	public function create(parentMovieClip:MovieClip, parentSwitcher:Switcher, direction:Boolean, d:Number){
		this._name="Hand_"+this.getDepth();
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
		this.chieldBullet = _root.attachMovie("Mace", "mace"+(Mace.count), _root.getNextHighestDepth());
		if(this.direction == direction){
			if(this.direction){
				this.switcher.state = 11;
				this.chieldBullet.StartMace(0, 50, this._x+20, this._y,this.damage,this.distance, this);
			}else{
				this.switcher.state = 12;
				this.chieldBullet.StartMace(180, 50, this._x-20, this._y,this.damage,this.distance,this);
			}
		}
		this.counter.delay = 10;
	}
	
	public function blowUp(direction:Boolean){
		this.chieldBullet = _root.attachMovie("Mace", "mace"+(Mace.count), _root.getNextHighestDepth());
		if(this.direction == direction){
			if(this.direction){
				this.switcher.state = 17;
				this.chieldBullet.StartMace(90, 40, this._x+20, this._y-100,this.damage,this.distance,this);
			}else{
				this.switcher.state = 18;
				this.chieldBullet.StartMace(90, 40, this._x-50, this._y-100,this.damage,this.distance,this);
			}
		}
		this.counter.delay = 10;
	}
	
	public function blowDown(direction:Boolean){
		this.chieldBullet = _root.attachMovie("Mace", "mace"+(Mace.count), _root.getNextHighestDepth());
		if(this.direction == direction){
			if(this.direction){
				this.switcher.state = 19;
				this.chieldBullet.StartMace(270, 60, this._x, this._y,this.damage,this.distance,this);
			}else{
				this.switcher.state = 20;
				this.chieldBullet.StartMace(270, 60, this._x, this._y,this.damage,this.distance,this);
			}
		}
		this.counter.delay = 10;
	}
	
	public function blowDownAndForward(direction:Boolean){
		this.chieldBullet = _root.attachMovie("Mace", "mace"+(Mace.count), _root.getNextHighestDepth());
		if(this.direction == direction){
			if(this.direction){
				this.switcher.state = 21;
				this.chieldBullet.StartMace(315, 50, this._x+20, this._y+20,this.damage,this.distance,this);
			}else{
				this.switcher.state = 22;
				this.chieldBullet.StartMace(225, 50, this._x-20, this._y+20,this.damage,this.distance,this);
			}
		}
		this.counter.delay = 10;
	}
	
	public function blowUpAndForward(direction:Boolean){
		this.chieldBullet = _root.attachMovie("Mace", "mace"+(Mace.count), _root.getNextHighestDepth());
		if(this.direction == direction){
			if(this.direction){
				this.switcher.state = 15;
				this.chieldBullet.StartMace(45, 50, this._x+20, this._y-20,this.damage,this.distance,this);
			}else{
				this.switcher.state = 16;
				this.chieldBullet.StartMace(135, 50, this._x-20, this._y-20,this.damage,this.distance,this);
			}
		}
		this.counter.delay = 10;
	}

	public function Iteraion(up:Boolean, down:Boolean, left:Boolean, right:Boolean, fight:Boolean, direction:Boolean){
		if(this.direction != direction) this.counter.delay = -1; 
		
		if(!this.counter.notOver && parentMovieClip.life){
			if((fight)&&(this.direction == direction)){

				if((!up) && (!down)){
					this.blow(direction);
				}
						
				if((up) && (!down) && (left || right)){
					this.blowUpAndForward(direction);
				}
						
				if((up) && (!down) && (!left) && (!right)){
					//this.blowUp(direction);
					this.blowUpAndForward(direction);
				}
				if((up) && (down)){
					this.switcher.state = this.parentSwitcher.state;
				}
				if((!up) && (down) && (!right) && (!left)){
					//this.blowDown(direction);
					this.blowDownAndForward(direction);
				}
				if((!up) && (down) && (right || left)){
					this.blowDownAndForward(direction);
				}

			} else {
				if(this.parentSwitcher.state!=18 && this.parentSwitcher.state!=19){
					this.switcher.state = this.parentSwitcher.state;
				}else{
					if(this.parentSwitcher.state==18){
						this.switcher.state=24;
					}
					if(this.parentSwitcher.state==19){
						this.switcher.state=23;
					}
				}
			}
			//trace("==============================\nUp: "+up+"\nDown: "+down+"\nleft: "+left+"\nright: "+right+"\nfight: "+fight);
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

	public function removeMovieClip(){
		this.cmc.remove();
		super.removeMovieClip();
	}
}