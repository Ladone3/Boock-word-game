class Rat2 extends Computer{
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
		return new Rat2Intellect(this);
	}
}

