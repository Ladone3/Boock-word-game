class Ladone3Tray extends LifePlayer{
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
	public var frictionModificator:Number = 2;

	// Характеристики персонажа
	//===============================
	private var jumpPower:Number = 30;
	private var runPower:Number = 6;
	public var damage:Number = 30;
	public var radius:Number = 10;
	public var hpmax:Number = 150;
	
	// Переопределение	
	public function getType():Number{
		return 5;
	}
			
	public function Ladone3Tray(){
	}
	
	//Переопределение
	public function initHPLine(){
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
		super.remove();
	}
	
	public function planLeft(){
		if(this.runState){
			if(this.xBoost>-runPower*2.5  && this.xBoost<=0){
				this.xBoost = -runPower*2.5;
			}else if(this.xBoost>0){
				this.xBoost -= runPower*2.5;
			}
		}else{
			if(this.xBoost>-runPower  && this.xBoost<=0){
				this.xBoost = -runPower;
			}else if(this.xBoost>0){
				this.xBoost -= runPower;
			}
		}
		this.direct = false;
	}
	
	public function planRight(){
		if(this.runState){
			if(this.xBoost<runPower*2.5  && this.xBoost>=0){
				this.xBoost = runPower*2.5;
			}else if(this.xBoost<0){
				this.xBoost += runPower*2.5;
			}
		}else{
			if(this.xBoost<runPower && this.xBoost>=0){
				this.xBoost = runPower;
			}else if(this.xBoost<0){
				this.xBoost += runPower;
			}
		}
		this.direct = true;
	}
	
	// Переопределение
	//==============================================	
	public function runLeft(){
		if(this.direct){
			this.direct = false;
			//this.saveRun1 = 0;
			//this.saveRun2 = 0;
			//this.runState = false;
		}
		if(this.runState){
			if(this.xBoost>-runPower*2.5  && this.xBoost<=0){
				this.xBoost = -runPower*2.5;
			}else if(this.xBoost>0){
				this.xBoost -= runPower*2.5;
			}
			this.switcher.state = 20;
		}else{
			if(this.xBoost>-runPower  && this.xBoost<=0){
				this.xBoost = -runPower;
			}else if(this.xBoost>0){
				this.xBoost -= runPower;
			}
			this.switcher.state = 4;
		}
		this.readyToJump = true;
	}
	
	// Переопределение
	//==============================================
	public function runRight(){
		if(!this.direct){
			this.direct = true;
			//this.saveRun1 = 0;
			//this.saveRun2 = 0;
			//this.runState = false;
		}
		if(this.runState){
			if(this.xBoost<runPower*2.5  && this.xBoost>=0){
				this.xBoost = runPower*2.5;
			}else if(this.xBoost<0){
				this.xBoost += runPower*2.5;
			}
			this.switcher.state = 19;
		}else{
			if(this.xBoost<runPower && this.xBoost>=0){
				this.xBoost = runPower;
			}else if(this.xBoost<0){
				this.xBoost += runPower;
			}
			this.switcher.state = 3;
		}
		this.readyToJump = true;
	}
	
	// Можно будет выделить в отдельный универсальный модуль - пока копипаст будет
	//==========================================================================
	private var bufferCounter:Number = 0;
	private var blowBuffer:Boolean = false;
	private function getFightConclusion(fight:Boolean):Boolean{
		if(fight){
			if(this.counter.notOver && !this.blowing){
				this.blowBuffer = true;
				this.bufferCounter=20;
			}
		}else{
			if(bufferCounter>0){
				this.bufferCounter--;
			}else{
				this.blowBuffer = false;
			}
		}
		return (fight || this.blowBuffer);
		//return fight;
	}
	
	// Можно будет выделить в отдельный универсальный модуль - пока копипаст будет
	//==========================================================================
	private var stateBlow:Number = 0;
	private var comboCounter:Number = 0;
	private function blowCatching(fight:Boolean){
		if(fight){
			this.stateBlow++;
			if(this.stateBlow>4){
				this.stateBlow = 1;
			}
			this.comboCounter=5;
		}else{
			if(comboCounter>0){
				this.comboCounter--;
			}else{
				this.stateBlow = 0;
			}
		}
	}
	
	public function comboBlow(){

		switch (this.stateBlow) {
			case (1): 
				this.blow();
				break;
			case (2): 
				this.blow1();
				break;	
			case (3): 
				this.blow2();
				break;	
			case (4): 
				this.blow3();
				break;	
			default:
				this.blow();
		}
	}
	// Переопределение
	//==============================================
	public function blow(){
		var b = _root.attachMovie("TrayBlow1Bullet", "b", (Bullet.AllCount+GameObject.AllCount+2));
		b._yscale=this._yscale;
		if(this.direct){
			b._xscale=this._xscale;
			this.switcher.state = 11;
			b.StartBullet(0, 5, this._x+(!this.runState ? 0 : 50), this._y,this.damage,this,20);
		}else{
			b._xscale=-this._xscale;
			this.switcher.state = 12;
			b.StartBullet(0, -5, this._x-(!this.runState ? 0 : 50), this._y,this.damage,this,20);
		}
		this.counter.delay=20;
	}
	public function blow1(){
		var b = _root.attachMovie("TrayBlow2Bullet", "b", (Bullet.AllCount+GameObject.AllCount+2));
		b._yscale=this._yscale;
		if(this.direct){
			b._xscale=this._xscale;
			this.switcher.state = 21;
			b.StartBullet(0, 1, this._x+(!this.runState ? 50 : 75), this._y,this.damage,this,20);
		}else{
			b._xscale=-this._xscale;
			this.switcher.state = 22;
			b.StartBullet(0, -1, this._x-(!this.runState ? 50 : 75), this._y,this.damage,this,20);
		}
		this.counter.delay=20;
	}
	public function blow2(){
		var b = _root.attachMovie("TrayBlow3Bullet", "b", (Bullet.AllCount+GameObject.AllCount+2));
		b._yscale=this._yscale;
		if(this.direct){
			b._xscale=this._xscale;
			this.switcher.state = 23;
			b.StartBullet(0, 1, this._x+(!this.runState ? 50 : 75), this._y,this.damage*2,this,25);
		}else{
			b._xscale=-this._xscale;
			this.switcher.state = 24;
			b.StartBullet(0, -1, this._x-(!this.runState ? 50 : 75), this._y,this.damage*2,this,25);
		}
		this.counter.delay=30;
	}
	
	/* // не забудь об этой фишке
	public function blow3(){
		var b = _root.attachMovie("TrayBlow4Bullet", "b", (Bullet.AllCount+GameObject.AllCount+2));
		b._yscale=this._yscale;
		if(this.direct){
			b._xscale=this._xscale;
			this.xBoost = jumpPower*2;
			this.switcher.state = 5;
			b.StartBullet(0, jumpPower/2, this._x+(!this.runState ? 50 : 100), this._y,this.damage,this,30);
		}else{
			b._xscale=-this._xscale;
			this.xBoost = -jumpPower*2;
			this.switcher.state = 6;
			b.StartBullet(0, -jumpPower/2, this._x-(!this.runState ? 50 : 100), this._y,this.damage,this,30);
		}
		this.yBoost = -jumpPower;
		this.counter.delay = 4;
		this.readyToJump = true;
	}
	*/
	
	public function blow3(){
		this.counter.delay = 15;
	}
	public function aeroBlow(){
		var b = _root.attachMovie("TrayBlow1Bullet", "b", (Bullet.AllCount+GameObject.AllCount+2));
		b._yscale=this._yscale;
		if(this.direct){
			b._xscale=this._xscale;
			this.switcher.state = 25;
			b.StartBullet(0, 5, this._x+(!this.runState ? 0 : 50), this._y,this.damage,this,20);
		}else{
			b._xscale=-this._xscale;
			this.switcher.state = 26;
			b.StartBullet(0, -5, this._x-(!this.runState ? 0 : 50), this._y,this.damage,this,20);
		}
		this.counter.delay=20;
	}
	
	// Можно будет выделить в отдельный универсальный модуль - пока копипаст будет
	//==========================================================================
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
	
	
	// Переопределение
	//==============================================
	private var blowing:Boolean=false;
	public function keyReading(){
		var fight:Boolean = this.getFightConclusion(Key.isDown(kFight));
		if(!this.counter.notOver && this.life){
		
			this.blowCatching(fight && !this.blowing);
			this.runRunCatching(Key.isDown(kLeft),Key.isDown(kRight));
			//if(Key.isDown(kDown)) this.runState = false;
			//else this.runState = true;
			
			if((Key.isDown(kLeft)||Key.isDown(kRight)||Key.isDown(kJump))
			||(fight && !this.blowing)){
				if(this.inAero){
				//============================================================
					if(Key.isDown(kJump)){
						this.jump();
					}
					if(Key.isDown(kLeft) 
						&& (!Key.isDown(kRight))
					){
						this.planLeft();
					}
					if(Key.isDown(kRight) 
						&& (!Key.isDown(kLeft))
					){
						this.planRight();
					}
					if(fight && !this.blowing
						//&&!(Key.isDown(kLeft)||Key.isDown(kRight)||Key.isDown(kJump))
					){
						this.aeroBlow();
					}
					
					if(Key.isDown(kRight) 
						&& Key.isDown(kLeft) && !(Key.isDown(kJump))
					){
						this.setfreeState();
					}
					
				//============================================================
				}else{
				//============================================================
					if(Key.isDown(kJump)){
						this.jump();
					}
					if(Key.isDown(kLeft) 
						&& (!(Key.isDown(kRight)||Key.isDown(kJump)||Key.isDown(kFight)))
					){
						this.runLeft();
					}
					if(Key.isDown(kRight)
						&& (!(Key.isDown(kLeft)||Key.isDown(kJump)||Key.isDown(kFight)))
					){
						this.runRight();
					}
					if(fight && !this.blowing
						//&&!(Key.isDown(kLeft)||Key.isDown(kRight)||Key.isDown(kJump))
					){
						this.comboBlow();
					}
					if(Key.isDown(kRight) 
						&& Key.isDown(kLeft) && !(Key.isDown(kJump))
					){
						setfreeState();
					}
				//============================================================
				}
			}else{
				setfreeState();
			}
			
		}		
		this.blowing = Key.isDown(kFight);
		
	}
	
	//Переопределение
	public function setTreatment(t:Number){
		this.hpline.treatment(t);
		this.auraContainer.useAura("TreatmentEffectTray");
	}
	
	//Переопределение
	public function setDie(){
		super.setDie();
		this.ladoneHandL.Iteraion(false,false,false,false,false,this.direct);
		this.ladoneHandR.Iteraion(false,false,false,false,false,this.direct);
	}
}

