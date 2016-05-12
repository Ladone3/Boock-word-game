class FlyingEnemy extends Computer{
	private var runPower:Number = 20;
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
		if((!this.lock) || 
		   (!this.hpline) || 
		   (this.hpline.HP==undefined) || 
		   (this.hpline.HP<=0) || 
		   (!this.life)){
			super.yA = yBoost;
		}
	}

	//Переопределение
	public function landing(){
		//trace("DOWN");
		this.lock = false;
		if(this.yBoost<runPower/2){
			if((this.yBoost+runPower/2)<=(runPower/2)){
				this.yBoost+=runPower/2;
			}else{
				this.yBoost=runPower/2;
			}
		}
		if(this.direct){
			this.switcher.state = 9;
		}else{
			this.switcher.state = 10;
		}
		this.lock = true;
	}

	//Переопределение
	public function jump(){
		//trace("UP");
		this.lock = false;
		if(this.yBoost>-runPower/2){
			if((this.yBoost-runPower/2)>=(-runPower/2)){
				this.yBoost-=runPower/2;
			}else{
				this.yBoost=-runPower/2;
			}
		}
		if(this.direct){
			this.switcher.state = 5;
		}else{
			this.switcher.state = 6;
		}
		this.lock = true;
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

					if(kLeft && !kRight){
						this.runLeft();
					}
					if(kRight && !kLeft){
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
	
	// Переопределение
	public function permissionToMov(np):Object{
		var result = super.permissionToMov(np);
		if(this.stopBounds){
			var myBounds = this.getBounds(_root);
			
			if(myBounds.yMin+result.y<this.stopBounds.minY){
				result.y = this.stopBounds.minY - myBounds.yMin;
			}
			if(myBounds.yMax+result.y>this.stopBounds.maxY){
				result.y = this.stopBounds.maxY - myBounds.yMax;
			}
		}
		return result;
	}
}
