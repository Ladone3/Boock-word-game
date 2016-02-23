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
		if(!this.lock || !life){
			super.yA = yBoost;
		}
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
		if(this.direct){
			this.switcher.state = 9;
		}else{
			this.switcher.state = 10;
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
		if(this.direct){
			this.switcher.state = 5;
		}else{
			this.switcher.state = 6;
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
			//trace("t_min_x:"+myBounds.xMin+",t_min_y:"+myBounds.yMin+",t_max_x:"+myBounds.xMax+",t_max_y:"+myBounds.yMax);
			//trace("min_x:"+this.stopBounds.minX+",min_y:"+this.stopBounds.minY+",max_x:"+this.stopBounds.maxX+",max_y:"+this.stopBounds.maxY);
			if(myBounds.yMin+result.y<this.stopBounds.minY){
				//trace("!!!");
				result.y = this.stopBounds.minY - myBounds.yMin;
			}
			if(myBounds.yMax+result.y>this.stopBounds.maxY){
				//trace("!!!33");
				result.y = this.stopBounds.maxY - myBounds.yMax;
			}
		}
		return result;
	}
}
