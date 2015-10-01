class Computer extends Player{
	//Мозг
	//===============================
	private var brain:Intellect;

	// Характеристики персонажа
	//===============================
	private var jumpPower:Number = 30;
	private var runPower:Number = 7;
	public var damage:Number = 30;
	public var radius:Number = 15;
	public var hpmax:Number = 160;
	public var stunDelay:Number = 20;
	public var defaultScale:Number = 1;
	
	public function getBrain():Intellect{
		return new Intellect(this);
	}
	
	public function setDamage(d:Number,dd:Boolean){
		super.setDamage(d,dd);
		stayOrNo = 0;
	}
	
	// Переопределение	
	private var stayOrNo:Number = 0;
	public function blow(){
		if(stayOrNo!=0){
			fastBlow();
		}else{
			dblow();
		}
		stayOrNo++;
		if(stayOrNo>3)stayOrNo=0;
	}
	
	public function fastBlow(){
		if(this.direct){
				this.switcher.state = 11;
				this.blowPermission(this.radius,this.damage,0.5);
			}else{
				this.switcher.state = 12;
				this.blowPermission(this.radius,this.damage,0.5);
			}
			this.counter.delay=10;
	}
	
	public function dblow(){
		if(this.direct){
			this.switcher.state = 19;
		}else{
			this.switcher.state = 20;
		}
		this.counter.delay=30;
	}
	
	// Переопределение	
	public function getSwitcher():Switcher{
		return new Switcher(20,this,this.counter);
	}
	
	// Переопределение	
	public function setScale(s:Number){
		super.setScale(s);
		var scale = this.hpline._width/this._width;
		this.hpline._height/=scale;
		this.hpline.setHPLineView(hpmax*s);
		this.hpline._width=this._width;
	}
	
	public function Computer(){
		trace("I am alive("+this._name+") and its my HPLINE:");
		this.hpline = _root.attachMovie("LineComputerOfHealth", "HPLineComputerView", _root.getNextHighestDepth());
		//this.hpline = _root.attachMovie("LineComputerOfHealth", "HPLineComputerView", (this.getDepth()<0 ? -_root.getNextHighestDepth() : _root.getNextHighestDepth()));
		if(this.getDepth()<=0){
			var hpscale = this.hpline._width/this._width;
			this.hpline._height/=hpscale;
			this.hpline.setHPLineView(hpmax*(this._xscale/100));
			this.hpline._width=this._width;
		}
		
		this.hpline._alpha = 50;
		
		this.brain=this.getBrain();
	}
	
	// Переопределение	
	public function getType():Number{
		return 2;
	}
	
	// Переопределение
	public function deinit():Boolean{
		if(this.getDepth()<0){
			this.hpline.removeMovieClip();
			this.hpline = null;
			return false;
		}
		return true;
	}
	
	// Переопределение
	//==============================================
	public  var kUp:Boolean    = false;
	public  var kDown:Boolean  = false;
	public  var kLeft:Boolean  = false;
	public  var kRight:Boolean = false;
	public  var kFight:Boolean = false;
	public  var kJump:Boolean  = false;
	//==============================================
	public function keyReading(){
		if(!this.counter.notOver){
			if(kLeft||kRight||kJump||kFight){
				if(this.inAero){
				//============================================================
					if(kJump){
						this.jump();
					}
					if(kLeft && (!kRight)){
						this.planLeft();
					}
					if(kRight && (!kLeft)){
						this.planRight();
					}
					if(kRight && kLeft && (!kJump)){
						setfreeState();
					}

					stayOrNo = 0;
				//============================================================
				}else{
				//============================================================
					if(kJump){
						this.jump();
					}

					if(kFight){
						this.blow();
					}else{
						stayOrNo = 0;
					}
					
					if(kLeft 
						&& (!(kRight||kJump))
					){
						this.runLeft();
					}
					if(kRight
						&& (!(kLeft||kJump))
					){
						this.runRight();
					}
					if(kRight && kLeft && (!kJump)){
						setfreeState();
					}
				//============================================================
				}
			}else{
				setfreeState();
			}
		}
	}
	
	//Переопределение
	public function remove(){
		trace("--does not removed yet");
		if(!this.counter.notOver()){
			trace("--this removed");
			this.hpline.removeMovieClip();
			this.hpline = null;
			super.remove();
		}
	}
		
	//Переопределение
	public function onEnterFrameAction(){
		super.onEnterFrameAction();		
		this.brain.activitys();
		this.hpline._x = this.getBounds(_root).xMax-this._width;
		this.hpline._y = this.getBounds(_root).yMin-20;
	}

	// Переопределение
	public function takeObject(object:GameObject):Boolean{
		return (object.getType()==0 || object.getType()==2);// || object.getType()==4 || object.getType()==6 || object.getType()==3 || object.getType()==5);
	}
		
	// Переопределение
	public function blowPermission(radius:Number, damage:Number,k:Number):Boolean{
		var nWidth = this.radius*2; //this._x+100,this._y,50,this.damage
		var nHeight = nWidth;
		if(_global.player!=null){
			var offset:Number = 0;
			if(direct){
				offset = 100;
			}else{
				offset = -100;
			}
			var temp1 = this.getBounds(_root);
			var nXMin = temp1.xMin + this._width/2 - radius + offset;
			var nYMin = temp1.yMin + this._height/2 - radius;
			var temp2 = _global.player.getBounds(_root);
			if((nXMin >= temp2.xMin - nWidth)&&(nYMin >= temp2.yMin - nHeight)&&(nXMin <= temp2.xMax)&&(nYMin <= temp2.yMax)&&(_global.player.life)){                                                                                              
					_global.player.setDamage(damage,(_global.player.direct!=direct));
					if(direct){
						_global.player.xA = damage/2*k;
					}else{
						_global.player.xA = -damage/2*k;
					}
					return true;
			}
		}
		return false;
	}
}

