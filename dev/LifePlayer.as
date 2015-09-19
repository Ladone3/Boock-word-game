class LifePlayer extends Player{
	//Переопределение
	public function permissionToMov(np:Point):Point{
		var nnp:Point = super.permissionToMov(np);
		this.isCalc = true;
		return nnp;
	}
	
	// Переопределение
	public function takeObject(object:GameObject):Boolean{
		return (object.getType()==0);
	}
	
	//Переопределение
	private function lifeOrDie(){
		if((!life)&&(!this.counter.notOver)){
			if(!this.counter.notOver){
				_root["CenterOfWorld"].goToLimbo();
			}
		}
	}
	
	//Переопределение
	public function setDie(){
		if(this.direct){
			this.switcher.state = 13;
		}else{
			this.switcher.state = 14;
		}
		this.counter.delay = 100;
	}
}