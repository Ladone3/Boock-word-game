class GhostIntellect extends Intellect {
	public function Rat2Intellect(slave:Computer){
		super(slave);
	}

	// Переопределение	
	public function moves(){
		var dist:Number = _global.abstractLaw.findObject(this.getSlave());
		this.fightMoves(dist);
	}
}
