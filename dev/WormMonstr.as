class WormMonstr extends Computer{
	// Характеристики персонажа
	//===============================
	private var jumpPower:Number = 30;
	private var runPower:Number = 7;
	public var damage:Number = 30;
	public var radius:Number = 15;
	public var hpmax:Number = 60;
	
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
}

