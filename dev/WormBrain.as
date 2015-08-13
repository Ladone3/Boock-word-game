class WormBrain extends Intellect{
	public function WormBrain(slave:Computer){
		super(slave);
	}
	
	// Переопределение
	public function moves(){
		super.moves();
		if(this.sa==2) this.sa = 1;
		if(this.sa==3) this.sa = 1
	}
	
	// Переопределение
	public function doAnAct(){
		switch (this.stateActivity) {
				case (0): 
					this.clearButtons();
					break ; 
				case (1): 
					this.run();
					break ;			  
				case (3): 
					this.blows();
					break ; 
				case (4): 
					this.revers();
					break ; 

				default: 
					this.clearButtons();
			}
	}
}
