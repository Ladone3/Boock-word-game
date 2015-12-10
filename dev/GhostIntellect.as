class GhostIntellect extends Intellect {
	public var DO_DOWN:Number = 5;
	public var MIN_X_DISTANCE = -1000;
	public var MAX_X_DISTANCE = 1000;
	public var MIN_Y_DISTANCE = -100;
	public var MAX_Y_DISTANCE = 1000;

	public function GhostIntellect(slave:Computer){
		super(slave);
	}

	// Переопределение
	public function moves(){
		var dist:Object = _global.abstractLaw.getOffsets(this.getSlave());
		this.distance = dist;
		this.fightMoves(dist.xo, dist.yo);
	}

	private var currentNeededXDistance:Number=0;
	private var currentNeededYDistance:Number=0;
	private var triggerXDist:Boolean = false;
	private var triggerYDist:Boolean = false;
	public function iterateNeededDistance(){
		if(triggerXDist){
			currentNeededXDistance++;
			if(currentNeededXDistance>MAX_X_DISTANCE)triggerXDist=false;
		}else{
			currentNeededXDistance--;
			if(currentNeededXDistance<MIN_X_DISTANCE)triggerXDist=true;
		}
		if(triggerYDist){
			currentNeededYDistance++;
			if(currentNeededYDistance>MAX_X_DISTANCE)triggerYDist=false;
		}else{
			currentNeededYDistance--;
			if(currentNeededYDistance<MIN_X_DISTANCE)triggerYDist=true;
		}
	}

	public function getNeededDistance(){
		iterateNeededDistance();
		return {dx:this.currentNeededXDistance, dy:this.currentNeededYDistance};
	}

	// Переопределение
	public var DIST_ERROR = 200;
	public function fightMoves(xo:Number,yo:Number){
		var nd = getNeededDistance();
		if(Math.abs(nd.dx-xo)<DIST_ERROR && Math.abs(nd.dy-yo)<DIST_ERROR){
			if((xo<0 && slave.direct)||(xo>0 && !slave.direct)){
				this.stateActivity = DO_REDIRECT;
			}else{
				this.stateActivity = DO_BLOW;
			}
		}else{
			if((nd.dx>xo && !slave.direct)||(nd.dx<xo && slave.direct)){
				this.stateActivity = DO_REDIRECT;
			}else{
				this.stateActivity = DO_RUN;
			}
		}
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
