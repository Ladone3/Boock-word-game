class GhostIntellect extends Intellect {
	public var DO_DOWN:Number = 5;
	public function GhostIntellect(slave:Computer){
		super(slave);
	}

	
	// Переопределение	
	public function moves(){
		var dist:Object = _global.abstractLaw.getOffsets(this.getSlave());
		this.fightMoves(dist.xo, dist.yo);
	}
	// Переопределение	
	public function fightMoves(xo:Number,yo:Number){
		if((xo<0 && slave.direct)||(xo>0 && !slave.direct)){
			this.stateActivity = DO_REDIRECT;
		}else{
			if(!slave.hitTest(_global.player)){
				this.stateActivity = DO_RUN;				
			}else{
				this.stateActivity = DO_BLOW;
			}
			if(yo>this.slave._height/2){
				this.stateActivity = DO_DOWN;
			}else if(yo<-this.slave._height/2){
				this.stateActivity = DO_JUMP;
			}
		}
	}
	// Переопределение	
	public function doAnAct(){
		switch (this.stateActivity) {
				case (DO_STAY): 
					this.clearButtons();
					break ; 
				case (DO_RUN): 
					this.run();
					break ;
				case (DO_JUMP): 
					this.jumps();
					break ; 	
				case (DO_DOWN): 
					this.landings();
					break ; 					
				case (DO_BLOW): 
					this.blows();
					break ; 
				case (DO_REDIRECT): 
					this.revers();
					break ; 

				default: 
					this.clearButtons();
			}
	}
	
	private function landings(){
		if(!this.slave.kDown)this.clearButtons();
		this.slave.kDown = true;
	}
}
