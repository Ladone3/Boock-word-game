class GhostIntellect extends Intellect {
	public var DO_DOWN:Number = 5;
	public var DO_RUN_DOWN:Number = 6;
	public var DO_RUN_JUMP:Number = 7;
	public var STEP:Number = 1;
	public var ANGLE_STEP:Number = 0.01;
	public var MIN_X_DISTANCE = 0;
	public var MAX_X_DISTANCE = 500;
	public var MIN_Y_DISTANCE = -500;
	public var MAX_Y_DISTANCE = 0;

	public function GhostIntellect(slave:Computer){
		super(slave);
	}

	// Переопределение
	public function moves(){
		var dist:Object = _global.abstractLaw.getOffsets(this.getSlave());
		this.distance = dist;
		this.anyMoves(dist.xo, dist.yo);
	}

	private var currentNeededXDistance:Number=MAX_X_DISTANCE;
	private var currentNeededYDistance:Number=MIN_Y_DISTANCE;
	private var triggerXDist:Boolean = false;
	private var triggerYDist:Boolean = false;
	private var angleITerator = 0;
	public function iterateNeededDistance(){
		if(triggerXDist){
			currentNeededXDistance+=STEP;
			if(currentNeededXDistance>MAX_X_DISTANCE)triggerXDist=false;
		}else{
			currentNeededXDistance-=STEP;
			if(currentNeededXDistance<MIN_X_DISTANCE)triggerXDist=true;
		}
		if(triggerYDist){
			currentNeededYDistance+=STEP;
			if(currentNeededYDistance>MAX_Y_DISTANCE)triggerYDist=false;
		}else{
			currentNeededYDistance-=STEP;
			if(currentNeededYDistance<MIN_Y_DISTANCE)triggerYDist=true;
		}
	}

	private var traceClip;
	public function getNeededDistance(){
		//iterateNeededDistance();
		this.angleITerator+=ANGLE_STEP;
		var result = {
			dx:Math.sin(this.angleITerator)*this.currentNeededXDistance,
			dy:-Math.abs(Math.cos(this.angleITerator))*this.currentNeededYDistance
		};
		if(!traceClip){
			traceClip = _root.attachMovie("Target", "TraceTarget", _root.getNextHighestDepth());
		}else{
			traceClip._x = _global.player._x - result.dx;
			traceClip._y = _global.player._y - result.dy;
		}
		return result;
	}

	// Переопределение
	public var DIST_ERROR = 0;
	public function anyMoves(xo:Number,yo:Number){
		var nd = getNeededDistance();
		var err_x = Math.abs(nd.dx-xo);
		var err_y = Math.abs(nd.dy-yo);
		if(err_x<=DIST_ERROR && err_y<=DIST_ERROR){
			if((xo<0 && slave.direct)||(xo>0 && !slave.direct)){
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

			if(err_x>DIST_ERROR){
				if((nd.dx>xo && slave.direct)||(nd.dx<xo && !slave.direct)){
					nothing_flag=true;
				}else{
					run_flag = true;
				}
			}

			if(err_y>DIST_ERROR){
				if(nd.dy<yo){
					down_flag = true;
				}else if(nd.dy>yo){
					up_flag = true;
				}
			}

			if(nothing_flag){
				this.stateActivity = DO_REDIRECT;
			}else{
				if(run_flag){
					if(down_flag){
						this.stateActivity = DO_RUN_DOWN;
						trace("DO_RUN_DOWN!!");
					}else if(up_flag){
						this.stateActivity = DO_RUN_JUMP;
						trace("DO_RUN_JUMP!!");
					}else{
						this.stateActivity = DO_RUN;
						trace("DO_RUN!!");
					}
				}else{
					if(up_flag){
						this.stateActivity = DO_JUMP;
						trace("DO_JUMP!!");
					}else if(down_flag){
						this.stateActivity = DO_DOWN;
						trace("DO_DOWN!!");
					}
				}
			}
		}
	}
	public function fightMoves(xo:Number,yo:Number){
		//this.stateActivity = DO_BLOW;
	}

	// Переопределение
	public function doAnAct(){
		//this.stateActivity =999;
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
				case (DO_RUN_DOWN):
					this.landingsRun();
					break;
				case (DO_RUN_JUMP):
					this.jumpsRun();
					break;
				case (DO_REDIRECT):
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
