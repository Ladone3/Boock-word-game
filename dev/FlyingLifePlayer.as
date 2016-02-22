class FlyingLifePlayer extends Ladone3Tray{
	//public var flying:Boolean = true;
	
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
		if(this.yBoost<runPower){
			this.yBoost = jumpPower/4;
		} else if(this.yBoost<0){
			this.yBoost += runPower/4;
		}
	}

	//Переопределение
	public function jump(){
		if(this.yBoost>-runPower){
			this.yBoost = -runPower/4;
		} else if(this.yBoost>0){
			this.yBoost -= runPower/4;
		}
	}
/*
	public function keyReading(){
		if(!this.counter.notOver){
			if(Key.isDown(kLeft)||Key.isDown(kFight)||Key.isDown(kRight)||Key.isDown(kJump)||Key.isDown(kDown)){
				//============================================================
					if(Key.isDown(kJump) && !Key.isDown(kDown)){
						this.jump();
					}

					if(Key.isDown(kDown) && !Key.isDown(kJump)){
						this.landing();
					}

					if(kFight){
						this.blow();
					}else{
						stayOrNo = 0;
					}
					
					if(Key.isDown(kLeft) && !Key.isDown(kRight)){
						this.runLeft();
					}
					if(Key.isDown(kRight) && !Key.isDown(kLeft)){
						this.runRight();
					}
					
					if(Key.isDown(kRight) && Key.isDown(kLeft) && (!Key.isDown(kJump))){
						setfreeState();
					}
				//============================================================
			}else{
				setfreeState();
			}
		}
	}
*/	
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
