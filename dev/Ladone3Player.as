class Ladone3Player extends LifePlayer{
	//Рука LadoneHandL
	//===============================
	private var ladoneHandL;
	private var ladoneHandR;

	// Коды клавиш
	//===============================
	private var kUp:Number    = 87;
	private var kDown:Number  = 83;
	private var kLeft:Number  = 65;
	private var kRight:Number = 68;
	private var kFight:Number = 75;//32;//97;
	private var kJump:Number = 76;//18;//98;

	// Характеристики персонажа
	//===============================
	private var jumpPower:Number = 30;
	private var runPower:Number = 10;
	public var radius:Number = 25;
	public var damage:Number = 20;
	public var hpmax:Number = 200;
	
	// Переопределение	
	public function getType():Number{
		return 3;
	}
			
	// Переопределение
	//================================================
	public function blow(){
		if(!this.blowing){
			if(this.direct){
				if(_global.abstractLaw.blowPermission(this.radius, this.damage*2, 1)){
					this.switcher.state = 11;
					this.counter.delay=10;
					this.blowing = Key.isDown(kFight);
				}
			}else{
				if(_global.abstractLaw.blowPermission(this.radius, this.damage*2, 1)){
					this.switcher.state = 12;
					this.counter.delay=10;
					this.blowing = Key.isDown(kFight);
				}
			}
		}
	}
	
	public function Ladone3Player(){
		this.ladoneHandL = _root.attachMovie("Ladone3HandL", "WarHandLeft", _root.getNextHighestDepth());
		this.ladoneHandL.create(this, this.switcher, (this.direct), this.damage);
		this.ladoneHandR = _root.attachMovie("Ladone3HandR", "WarHandRight", _root.getNextHighestDepth());
		this.ladoneHandR.create(this, this.switcher, !(this.direct), this.damage);
		this.ladoneHandR.swapDepths(this.ladoneHandL);
		this.ladoneHandR.swapDepths(this);
		this.hpline = _root.attachMovie("LineOfHealth", "HPLineView", _root.getNextHighestDepth());
		this.hpline._xScale =30;
		this.hpline._yScale =30;
		this.hpline.setHPLineView(hpmax);
		this.hpline._x=200;
		this.hpline._y=70;
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
	//==============================================	
	public function runLeft(){
		if(!this.runState){
			if((!this.inAero)&&(Math.abs(this.xBoost)<Math.abs(runPower))&&(this.xBoost>-runPower)){
				this.xBoost = -runPower;
			}else if(this.xBoost>0){
				this.xBoost -= runPower;
			}
			this.switcher.state = 4;
		}else{
			if((!this.inAero)&&(Math.abs(this.xBoost)<runPower*2.5)&&(this.xBoost>-runPower*2.5)){
				this.xBoost = -runPower*2.5;
			}else if(this.xBoost>0){
				this.xBoost -= runPower*2.5;
			}
			this.switcher.state = 18;
		}
		if(this.direct){
			this.direct = false;
			this.saveRun1 = 0;
			this.saveRun2 = 0;
			this.runState = false;
		}
		this.readyToJump = true;
	}
	
	// Переопределение
	//==============================================
	public function runRight(){
		if(!this.runState){
			if((!this.inAero)&&(Math.abs(this.xBoost)<Math.abs(runPower))&&(this.xBoost<runPower)){
				this.xBoost = runPower;
			}else if(this.xBoost<0){
				this.xBoost += runPower;
			}
			this.switcher.state = 3;
		}else{
			if((!this.inAero)&&(Math.abs(this.xBoost)<runPower*2.5)&&(this.xBoost<runPower*2.5)){
				this.xBoost = runPower*2.5;
			}else if(this.xBoost<0){
				this.xBoost += runPower*2.5;
			}
			this.switcher.state = 19;
		}
		if(!this.direct){
			this.direct = true;
			this.saveRun1 = 0;
			this.saveRun2 = 0;
			this.runState = false;
		}
		this.readyToJump = true;
	}
	
	private var runState:Boolean = false;
	private var saveRun1:Number = 0;
	private var saveRun2:Number = 0;
	private var comboBlock:Boolean = false;
	private function runRunCatching(left:Boolean, right:Boolean){
		if(left || right){
			if(!comboBlock){
				if(saveRun2==0){
					saveRun1++;
					if(saveRun1>10){
						saveRun1 = 0;
						this.comboBlock = true;
					}
				}else{
					runState = true;
				}
			}
		}else{
			this.comboBlock = false;
			if(!runState){
				if(saveRun1==0){
					saveRun2=0;
					runState=false;
				}else{
					saveRun2++;
					if(saveRun2>10){
						saveRun2=0;
						saveRun1=0;
						runState=false;
					}
				}
			}else{
				saveRun2=0;
				saveRun1=0;
				runState=false;
			}
		}
	}
	
	private var readyBoost:Boolean=true;
	private var countBoost:Number=0;
	private function breakBoost(){
		if(this.readyBoost && this.runState){
			this.readyBoost = false;
			this.countBoost = 20;
		}else if(!this.readyBoost){
			this.countBoost --;
			if(this.countBoost<0){
				this.runState = false;
				this.saveRun1 = 0;
				this.saveRun2 = 0;
				this.comboBlock = false;
			}
			if(this.countBoost<-20){
				this.countBoost = 0;
				this.readyBoost=true;
			}
		}
	}
	
	// Переопределение
	//==============================================
	private var blowing:Boolean=false;
	public function keyReading(){
		if(!this.counter.notOver && this.life){
			
			this.breakBoost();
			if(this.readyBoost){
				this.runRunCatching(Key.isDown(kLeft),Key.isDown(kRight));
			}
			if(Key.isDown(kLeft)||Key.isDown(kRight)||Key.isDown(kJump)||(Key.isDown(kFight)&&!this.blowing)){
				if(this.inAero){
				//============================================================
					if(Key.isDown(kJump)){
						this.jump();
					}
					if(Key.isDown(kLeft) && (!Key.isDown(kRight))){
						this.planLeft();
					}
					if(Key.isDown(kRight) && (!Key.isDown(kLeft))){
						this.planRight();
					}
					if(Key.isDown(kRight) && Key.isDown(kLeft) && (!Key.isDown(kJump))){
						setfreeState();
					}
					
				//============================================================
				}else{
				//============================================================
					if(Key.isDown(kJump)){
						this.jump();
					}
					if(Key.isDown(kFight)){
						this.blow();
					}
					if(Key.isDown(kLeft) 
						&& (!(Key.isDown(kRight)||Key.isDown(kJump)))
					){
						this.runLeft();
					}
					if(Key.isDown(kRight)
						&& (!(Key.isDown(kLeft)||Key.isDown(kJump)))
					){
						this.runRight();
					}
					if(Key.isDown(kRight) && Key.isDown(kLeft) && (!Key.isDown(kJump))){
						setfreeState();
					}
				//============================================================
				}
			}else{
				setfreeState();
			}
		}
		this.ladoneHandL.Iteraion(Key.isDown(kUp), Key.isDown(kDown), Key.isDown(kLeft), Key.isDown(kRight), (this.ladoneHandL.cmc==null && this.ladoneHandR.cmc==null && !this.blowing ? Key.isDown(kFight) : false), this.direct);
		this.ladoneHandR.Iteraion(Key.isDown(kUp), Key.isDown(kDown), Key.isDown(kLeft), Key.isDown(kRight), (this.ladoneHandL.cmc==null && this.ladoneHandR.cmc==null && !this.blowing ? Key.isDown(kFight) : false), this.direct);
		this.blowing = Key.isDown(kFight);
	}
	
	//Переопределение
	public function setTreatment(t:Number){
		this.hpline.treatment(t);
		this.auraContainer.useAura("TreatmentEffect");
	}
	
	//Переопределение
	public function setDie(){
		super.setDie();
		this.ladoneHandL.Iteraion(false,false,false,false,false,this.direct);
		this.ladoneHandR.Iteraion(false,false,false,false,false,this.direct);
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
}

