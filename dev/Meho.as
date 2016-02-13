class Meho extends Computer{
	//Руки
	//===============================
	private var ladoneHandL;
	private var ladoneHandR;

	public function getHandL(){ return this.ladoneHandL; }
	public function getHandR(){ return this.ladoneHandR; }
	
	//Мозг
	//===============================
	private var brain:Intellect;

	// Характеристики персонажа
	//===============================
	private var jumpPower:Number = 30;
	private var runPower:Number = 7;
	public var damage:Number = 30;
	public var radius:Number = 15;
	public var hpmax:Number = 1600;
	public var stunDelay:Number = 20;
	public var defaultScale:Number = 1;
		
	// Переопределение
	//==============================================
	public  var kUp:Boolean    = false;
	public  var kDown:Boolean  = false;
	public  var kLeft:Boolean  = false;
	public  var kRight:Boolean = false;
	public  var kFight:Boolean = false;
	public  var kJump:Boolean  = false;
	//==============================================
	public function Meho(){
		this.ladoneHandL = _root.attachMovie("MehoHandL", "WarHandLeft", _root.getNextHighestDepth());
		this.ladoneHandL.create(this, this.switcher, (this.direct), this.damage);
		this.ladoneHandR = _root.attachMovie("MehoHandR", "WarHandRight", _root.getNextHighestDepth());
		this.ladoneHandR.create(this, this.switcher, !(this.direct), this.damage);
		this.ladoneHandR.swapDepths(this.ladoneHandL);
		this.ladoneHandR.swapDepths(this);
	}
	
	//Переопределение
	public function remove(){
		this.hpline.removeMovieClip();
		this.hpline = null;
		this.ladoneHandL.removeMovieClip();
		this.ladoneHandL = null;
		this.ladoneHandR.removeMovieClip();
		this.ladoneHandR = null;
		super.remove();
	}
	
	// Переопределение
	//================================================
	public function blow(){
		if(!this.blowing){
			if(this.direct){
				if(_global.abstractLaw.blowPermission(this.radius, this.damage*2, 1)){
					this.switcher.state = 11;
					this.counter.delay=10;
					this.blowing = kFight;
				}
			}else{
				if(_global.abstractLaw.blowPermission(this.radius, this.damage*2, 1)){
					this.switcher.state = 12;
					this.counter.delay=10;
					this.blowing = kFight;
				}
			}
		}
	}
	
	//Переопределение
	public function setScale(k:Number){
		this._xscale *= k;
		this._yscale *= k;
		this.ladoneHandL._xscale *= k;
		this.ladoneHandL._yscale *= k;
		this.ladoneHandR._xscale *= k;
		this.ladoneHandR._yscale *= k;
	}
	
	//Переопределение
	public function setDie(){
		super.setDie();
		this.ladoneHandL.Iteraion(false,false,false,false,false,this.direct);
		this.ladoneHandR.Iteraion(false,false,false,false,false,this.direct);
	}
	
	private var blowing:Boolean=false;
	public function keyReading(){
		if(!this.counter.notOver){
			if(kLeft||kRight||kJump||kFight&&!this.blowing){
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
		this.ladoneHandL.Iteraion(kUp, kDown, kLeft, kRight, (this.ladoneHandL.cmc==null && this.ladoneHandR.cmc==null && !this.blowing ? kFight : false), this.direct);
		this.ladoneHandR.Iteraion(kUp, kDown, kLeft, kRight, (this.ladoneHandL.cmc==null && this.ladoneHandR.cmc==null && !this.blowing ? kFight : false), this.direct);
		this.blowing = kFight;
	}
}

