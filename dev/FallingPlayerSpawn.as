class FallingPlayerSpawn extends PlayerSpawn{
	public function FallingPlayerSpawn(){
		if(_global.player){
			trace("Spawn clear");
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