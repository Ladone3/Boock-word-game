class FallingPlayerSpawn extends PlayerSpawn{
	public function FallingPlayerSpawn(){
		if(_global.player)_global.player.remove();
	}

	// Переопределение
	public function init(){
		this.mCount=1;
		this.mMC="FallingTray";
		this.mClass="FlyingLifePlayer";
	}
	
	
}