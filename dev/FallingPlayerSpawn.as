class FallingPlayerSpawn extends PlayerSpawnShadow{
	public function FallingPlayerSpawn(){
		_global.LOT = false;
		if(_global.player && (_global.player.getType()==="Ladone3Tray" || _global.player.getType()==="Ladone3Player")){
			trace("Spawn clear");
			_global.abstractLaw.popCreature(_global.player);
			_global.player.hpline.removeMovieClip();
			_global.player.hpline = null;
			_global.player.remove();
			_global.player = null;
		}
	}

	// Переопределение
	public function init(){
		this.mCount=1;
		this.mMC="FallingTray";
		this.mClass="FlyingLifePlayer";
	}
	
	
}