class PlayerSpawn extends MonstrSpawn{
	// Переопределение
	public function init(){
		this.mCount=1;
		if(_global.LOT){
			this.mMC="Ladone3Player";
			this.mClass="Ladone3Player";
		}else{
			this.mMC="Ladone3Tray";
			this.mClass="Ladone3Tray";
		}
	}
	
	// Переопределение
	public function deinit(){
		return false;
	}
	
	public function PlayerSpawn(){
	}
	
	//Переопределение
	public function onEnterFrameCatchPlayer(){
		if(this.once){
			if(!_global.player){
				_global.player=this.spawn()[0];
			}else{
				this.configurationPart(_global.player);
			}
			this.once=false;
		}else{
			if(_global.player._alpha<100){
					_global.player._alpha+=10;
					//this._alpha-=10;
					this.complete=true;
			}else{
				this.remove();
			}
		}
	}
	
	private function configuratePlayer(a:Player, k:Number){
		a.setScale(k);
	}
	
	private function configurationPart(a:MovieClip){
		a._x=this._x;
		a._y=this._y;
	}
	
	// Переопределение
	private function configurateMC(a:GameObject){
		this.configurationPart(a);
		if(_global.LOT){
			this.configuratePlayer(Player(a),0.5);
		}else{
			this.configuratePlayer(Player(a),0.4);
		}
	}
}