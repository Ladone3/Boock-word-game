class GhostIntellect extends Intellect {
	public var DO_DOWN:Number = 5;
	public var DO_RUN_DOWN:Number = 6;
	public var DO_RUN_JUMP:Number = 7;
	public var DIST_ERROR:Number = 50;
	public var RADIUS:Number = 20;
	public var state_timer:Number = 0;
	
	public function GhostIntellect(slave:Computer){
		super(slave);
	}

	var rand_x = 0;
	var rand_y = 0;
	// Переопределение
	public function moves(){
		var dist:Object = _global.abstractLaw.getOffsets(this.getSlave());
		this.distance = dist;
		this.state_timer++;		
		if(this.state_timer<50*15){
			var opp = Math.round(Math.random()*100);
			if(opp>90){
				//trace("_1");
				this.rand_x=(Math.random()*RADIUS-RADIUS/2)*100;
				this.rand_y=(Math.random()*RADIUS/2-RADIUS/20)*100;
			}else {
				//trace("_2");
				this.goToPlace(dist.xo, dist.yo, this.rand_x, this.rand_y);
			}
		} else if(this.state_timer<50*20){
			this.goToPlace(dist.xo, dist.yo, 0, 0);
		} else {
			this.state_timer = 0;
			this.rand_x=(Math.random()*RADIUS-RADIUS/2)*100;
			this.rand_y=(Math.random()*RADIUS/2-RADIUS/20)*100;
		}
	}

	public function goToPlace(xo:Number,yo:Number, xt:Number,yt:Number){
		//trace("xt: "+xt+" yt:"+yt);
		//trace("xo: "+xo+" yo:"+yo);
		var err_x = Math.abs(xo);
		var err_y = Math.abs(yo);
		if(err_x<=this.DIST_ERROR || err_y<=this.DIST_ERROR){
			if((xo<xt && slave.direct)||(xo>xt && !slave.direct)){
				this.stateActivity = DO_REDIRECT;
			}else{
				this.fightMoves(xo,yo);
			}
		}else{
			//trace("err_x: "+err_x+" err_y: "+err_y+" slave.direct:"+slave.direct);
			var up_flag:Boolean = false;
			var down_flag:Boolean = false;
			var run_flag:Boolean = false;
			var nothing_flag:Boolean = false;

			if(err_x>this.DIST_ERROR){
				if((xt>xo && slave.direct)||(xt<xo && !slave.direct)){
					nothing_flag=true;
				}else{
					run_flag = true;
				}
			}
			if(err_y>this.DIST_ERROR){
				if(yt<yo){
					//trace("Down");
					down_flag = true;
				}else if(yt>yo){
					//trace("Up");
					up_flag = true;
				}
			}

			if(nothing_flag){
				this.stateActivity = DO_REDIRECT;
			}else{
				if(run_flag){
					if(down_flag){
						this.stateActivity = DO_RUN_DOWN;
						//trace("DO_RUN_DOWN!!");
					}else if(up_flag){
						this.stateActivity = DO_RUN_JUMP;
						//trace("DO_RUN_JUMP!!");
					}else{
						this.stateActivity = DO_RUN;
						//trace("DO_RUN!!");
					}
				}else{
					if(up_flag){
						this.stateActivity = DO_JUMP;
						//trace("DO_JUMP!!");
					}else if(down_flag){
						this.stateActivity = DO_DOWN;
						//trace("DO_DOWN!!");
					}
				}
			}
		}
	}
	
	//var blowTimer:Number = 0;
	private function blows(){
		//if(blowTimer>0) return;
		if(!(this.slave.kFight))this.clearButtons();
		this.slave.kFight = true;
		if(!this.timer.notOver)this.timer.delay = 10;
	}
	
	public function fightMoves(xo:Number,yo:Number){
		if((xo<0 && slave.direct)||(xo>0 && !slave.direct)){
			this.stateActivity = DO_REDIRECT;
		}else{
			this.stateActivity = DO_BLOW;
		}
	}

	// Переопределение
	public function doAnAct(){
		//this.stateActivity =999;
		switch (this.stateActivity) {
				case (DO_STAY):
					//trace("DO_STAY");
					this.clearButtons();
					break ;
				case (DO_RUN):
					//trace("DO_RUN");
					this.run();
					break ;
				case (DO_JUMP):
					//trace("DO_JUMP");
					this.jumps();
					break ;
				case (DO_DOWN):
					//trace("DO_DOWN");
					this.landings();
					break ;
				case (DO_BLOW):
					//trace("DO_BLOW");
					this.blows();
					break ;
				case (DO_RUN_DOWN):
					//trace("DO_RUN_DOWN");
					this.landingsRun();
					break;
				case (DO_RUN_JUMP):
					//trace("DO_RUN_JUMP");
					this.jumpsRun();
					break;
				case (DO_REDIRECT):
					//trace("DO_REDIRECT");
					this.revers();
					break ;

				default:
					this.clearButtons();
			}
	}

	private function landings(){
		if(!(this.slave.kDown))this.clearButtons();
		this.slave.kDown = true;
	}

	private function landingsRun(){
		if(!(this.slave.kDown && (this.slave.kLeft || this.slave.kRight)))this.clearButtons();
		this.slave.kDown = true;
		if(this.slave.direct){
			this.slave.kRight = true;
		}else{
			this.slave.kLeft = true;
		}
	}

	private function jumpsRun(){
		if(!(this.slave.kJump && (this.slave.kLeft || this.slave.kRight)))this.clearButtons();
		this.slave.kJump = true;
		if(this.slave.direct){
			this.slave.kRight = true;
		}else{
			this.slave.kLeft = true;
		}
	}
}
