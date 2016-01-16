class PowerDown extends PowerUp{
	var mMC:String="Ladone3Tray";
	var mClass:String="Ladone3Tray";
	var SCALE:Number = 0.4;
	
	// Переопределение
	public function doTeleportation(){
		if(_global.LOT){
			this.stateNumber++;
		}else{
			this.nocatch = true;
		}
	}
	
	public function PowerDown(){
		this._visible = false;
	}
	
	// Переопределение
	public function deinit(){
		this.nocatch = true;
		this.varIterator = 100;
		this.stateNumber = 0;
		return false;
	}
		
	public function objectAction(){
		switch(this.stateNumber){
			case 1:
				if(this.varIterator<500){
					_global.player._color.brightness = (this.varIterator+=10);
					_global.player.ladoneHandL._color.brightness = (this.varIterator);
					_global.player.ladoneHandR._color.brightness = (this.varIterator);
				}else{
					this.stateNumber++;
					_global.player._color.brightness = 500;
					_global.player.ladoneHandL._color.brightness = 500;
					_global.player.ladoneHandR._color.brightness = 500;
				}
				break;
			case 2:
				this.steppedSpawn();
				break;
			case 3:
				if(this.varIterator>100){
					_global.player._color.brightness = (this.varIterator-=10);
				}else{             
					this.stateNumber++;
					_global.player._color.brightness = 100;
				}
				break;
			case 4:
				this.remove();
				break;
			default:
				break;
		}		
	}
}