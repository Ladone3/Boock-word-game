class FlyingEnemy extends Computer{

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
	private var lock:Boolean = true;
	public function set yA(yBoost:Number){
		if(!this.lock){
			super.yA = yBoost;
		}
	}

	//Переопределение
	public function landing(){
		if(this.yBoost<runPower){
			this.yBoost = jumpPower;
		} else if(this.yBoost<0){
			this.yBoost += runPower/1.5;
		}
	}

	//Переопределение
	public function jump(){
		if(this.yBoost>-runPower){
			this.yBoost = -runPower;
		} else if(this.yBoost>0){
			this.yBoost -= runPower/1.5;
		}
	}

	public function keyReading(){
		if(!this.counter.notOver){
			if(kLeft||kRight||kJump||kFight||kDown){
				//============================================================
					if(kJump && !kDown){
						this.jump();
					}

					if(kDown && !kJump){
						this.landing();
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
			}else{
				setfreeState();
			}
		}
	}
}
