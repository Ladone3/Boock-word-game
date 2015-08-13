class Intellect {
	private var slave:Computer;
	private var timer:Counter;
	private var law:AbstractLaw;
	
	public function Intellect(slave:Computer){
		this.slave = slave;
		this.law = this.slave.law();
		this.timer = new Counter();
		//trace("timer = " + this.timer.delay);
	}
	
	private var stateActivity:Number = 0;
	public function get sa(){
		return this.stateActivity;
	}
	public function set sa(stateActivity:Number){
		this.stateActivity = stateActivity;
	}
	// 0 - Стоять 
	// 1 - Бежать
	// 2 - Прыгать
	// 3 - Бить
	// 4 - Сменить направление
	
	private function clearButtons(){
		this.slave.kUp = false;
		this.slave.kDown = false;
		this.slave.kLeft = false;
		this.slave.kRight = false;
		this.slave.kFight = false;
		this.slave.kJump = false;
	}
	
	private function run(){
		if(!(this.slave.kLeft||this.slave.kRight))this.clearButtons();
		if(this.slave.direct){
			this.slave.kRight = true;
		}else{
			this.slave.kLeft = true;
		}
	}
	
	private function jumps(){
		if(!this.slave.kJump)this.clearButtons();
		this.slave.kJump = true;
	}
	
	private function blows(){
		if(!this.slave.kFight)this.clearButtons();
		this.slave.kFight = true;
	}
	
	private function revers(){
		this.clearButtons();
		if(this.slave.direct){
			this.slave.kLeft = true;
		}else{
			this.slave.kRight = true;
		}
	}
	
	public function freeMoves(dist:Number){
		this.stateActivity = Math.round(Math.random()*4);
		if(this.stateActivity!=3){
			this.stateActivity = Math.round(Math.random()*4);
		}else if(this.stateActivity!=3){
			this.stateActivity = Math.round(Math.random()*4);
		}else if(this.stateActivity!=3){
			this.stateActivity = Math.round(Math.random()*4);
		}
		if(this.stateActivity!=4){
			this.timer.delay = 20;
		}
	}
	
	public function fightMoves(dist:Number){
		var opp = Math.round(Math.random()*100);
		if(opp > 20){
			if((dist<0 && slave.direct)||(dist>0 && !slave.direct)){
				this.stateActivity = 4;
			}else{
				this.stateActivity = 1;				
			}
		}else{
			this.stateActivity = Math.round(Math.random()*4);
			if(this.stateActivity!=3){
				this.stateActivity = Math.round(Math.random()*4);
			}
			if(this.stateActivity!=4){
				this.timer.delay = 20;
			}
		}
	}
	
	public function moves(){
		var dist:Number = slave.law.findObject(slave, 500);
		if(Math.abs(dist)>10){
			this.fightMoves(dist);
		}else{
			this.freeMoves(dist);
		}
	}
	
	public function doAnAct(){
		switch (this.stateActivity) {
				case (0): 
					this.clearButtons();
					break ; 
				case (1): 
					this.run();
					break ;
				case (2): 
					this.jumps();
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
	
	public function activitys(){
		if(!(this.timer.notOver)){
			this.moves();
		}
		this.doAnAct();
		this.timer.iterateCounter();
	}
}
