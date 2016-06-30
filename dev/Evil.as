class Evil extends Rat2{
	
	private var onlyOneSpawn:Boolean = true;
	// Характеристики персонажа
	//===============================
	private var jumpPower:Number = 65;
	private var runPower:Number = 16;
	public var damage:Number = 100;
	public var radius:Number = 40;
	public var hpmax:Number = 4000;
	public var stunDelay:Number = 5;
	
	//Переопределение
	public function setDamage(d:Number,dd:Boolean){
		super.setDamage(d,dd);
		_global.player.setDamage(damage, 10);
	}
	
	private function lifeOrDie(){
		if((!life)&&(!this.counter.notOver) && (this.onlyOneSpawn)){
			if(!this.counter.notOver){
				super.lifeOrDie();
				_root["CenterOfWorld"].goToAndStopToNextFrame();
			}
		}
	}
}

