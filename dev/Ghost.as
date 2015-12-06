class Ghost extends Computer{
	// Характеристики персонажа
	//===============================
	private var jumpPower:Number = 35;
	private var runPower:Number = 10;
	public var damage:Number = 50;
	public var radius:Number = 20;
	public var hpmax:Number = 360;
	public var stunDelay:Number = 10;
	
	// Переопределение
	public function getBrain():Intellect{
		return new GhostIntellect(this);
	}
	
	//Переопределение
	public function onEnterFrameAction(){
		super.onEnterFrameAction();
		this.hpline.treatment(0.1);
	}
	
	//Переопределение
	private function aeroState(nameValue:String, lastState:Boolean, newState:Boolean, dop):Boolean{	
		return true;
	}

	public function setfreeState(){
		super.setfreeState();
		this.xA=0;
		this.yA=0;
	}
	
	//Переопределение
	private var lock:Boolean = true;
	public function set yA(yBoost:Number){
		if(!this.lock){
			this.yBoost = yBoost;
		}
	}
}

