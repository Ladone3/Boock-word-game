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
}