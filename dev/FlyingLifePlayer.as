class FlyingLifePlayer extends Ladone3Tray{
	//public var flying:Boolean = true;
	private var runPower:Number = 8;
	public var stunDelay:Number = 1;
	
	// Переопределение	
	public function getType():String{
		return "FlyingLifePlayer";
	}
	
	//Переопределение
	private function aeroState(nameValue:String, lastState:Boolean, newState:Boolean, dop):Boolean{
		this.inAero = false;
		return this.inAero;
	}

	//Переопределение
	public function setfreeState(){
		super.setfreeState();
		this.xA=0;
		this.yA=0;
	}

	//Переопределение
	public function landing(){
		trace("DOWN");
		if(this.yBoost<runPower/2){
			if((this.yBoost+runPower/2)<=(runPower/2)){
				this.yBoost+=runPower/2;
			}else{
				this.yBoost=runPower/2;
			}
		}
		if(!Key.isDown(kUp) && !Key.isDown(kDown)){
			if(this.direct){
				this.switcher.state = 9;
			}else{
				this.switcher.state = 10;
			}
		}
	}

	//Переопределение
	public function jump(){
		trace("UP");
		if(this.yBoost>-runPower/2){
			if((this.yBoost-runPower/2)>=(-runPower/2)){
				this.yBoost-=runPower/2;
			}else{
				this.yBoost=-runPower/2;
			}
		}
		if(!Key.isDown(kUp) && !Key.isDown(kDown)){
			if(this.direct){
				this.switcher.state = 5;
			}else{
				this.switcher.state = 6;
			}
		}
	}

	public function keyReading(){
		if(!this.counter.notOver){
			if(Key.isDown(kLeft)||Key.isDown(kFight)||Key.isDown(kUp)||Key.isDown(kRight)||Key.isDown(kJump)||Key.isDown(kDown)){
				//============================================================
					if(Key.isDown(kUp) && !Key.isDown(kDown)){
						this.jump();
					}

					if(Key.isDown(kDown) && !Key.isDown(kUp)){
						this.landing();
					}

					if(Key.isDown(kFight)){
						this.blow();
					}
					
					if(Key.isDown(kLeft) && !Key.isDown(kRight)){
						this.runLeft();
					}
					if(Key.isDown(kRight) && !Key.isDown(kLeft)){
						this.runRight();
					}
					
				//============================================================
			}else{
				setfreeState();
			}
		}
	}	
}
