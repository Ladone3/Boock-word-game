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
	public var DO_STAY:Number = 0;
	public var DO_RUN:Number = 1;
	public var DO_JUMP:Number = 2;
	public var DO_BLOW:Number = 3;
	public var DO_REDIRECT:Number = 4;
	
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
		
		if(this.stateActivity!=DO_BLOW){
			this.stateActivity = Math.round(Math.random()*4);
		}
		if(this.stateActivity!=DO_REDIRECT){
			this.timer.delay = 20;
		}
	}
	
	public function fightMoves(dist:Number){
		if((dist<0 && slave.direct)||(dist>0 && !slave.direct)){
			this.stateActivity = DO_REDIRECT;
		}else{
			if(!slave.hitTest(slave.law.Target)){
				this.stateActivity = DO_RUN;				
			}else{
				this.stateActivity = DO_BLOW;
			}
		}
	}
	
	public function moves(){
		var opp = Math.round(Math.random()*100);
		var dist:Number = slave.law.findObject(slave);
		if(Math.abs(dist)<400 && opp<75){
			this.fightMoves(dist);
		}else{
			this.freeMoves(dist);
		}
	}
	
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
	
	public function activitys(){
		if(!(this.timer.notOver)){
			this.moves();
		}
		this.doAnAct();
		this.timer.iterateCounter();
	}
}
