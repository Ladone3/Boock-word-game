class PlayerSpawnShadow extends PlayerSpawn{
	//Переопределение
	public function onEnterFrameCatchPlayer(){
		if(this.once){
			trace("Spawn "+(!_global.player?"true":"false"));
			if(!_global.player){
				_global.player=this.spawn()[0];
			}else{
				this.configurationPart(_global.player);
			}
			this.once=false;
		}else{
			if(_global.player._alpha<100){
				_global.player._alpha+=10;
				this.complete=true;
			}else{
				_global.player._color.brightness = 50;
				this.remove();
			}
		}
	}
}