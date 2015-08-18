class WormMonstr extends Computer{
	// Характеристики персонажа
	//===============================
	private var jumpPower:Number = 1;
	private var runPower:Number = 15;
	public var damage:Number = 30;
	public var radius:Number = 15;
	public var hpmax:Number = 160;
	public var stunDelay:Number = 14;
	
	// Переопределение
	public function getBrain():Intellect{
		return new WormBrain(this);
	}
	
	public function WormMonstr(){
		super();
	}
	
	// Переопределение	
	public function getType():Number{
		return 2;
	}
	
	public function onEnterFrameAction(){
		super.onEnterFrameAction();
	}
}

