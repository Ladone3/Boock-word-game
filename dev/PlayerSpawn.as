class PlayerSpawn extends MonstrSpawn{
	// Переопределение
	public function init(){
		this.mCount=1;
		if(_global.LOT){
			this.mMC="Ladone3Player";
			this.mClass="Ladone3Player";
			//this.mMC="RatMonstr3";
			//this.mClass="Player";
			//this.mMC="Ladone3Tray2";
			//this.mClass="Ladone3Tray";
			//_global.player.setDamage(_global.player.hpline.HPM);
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
		this.areaNeeded = false;
		if(_global.player && _global.player.getType()==="FlyingLifePlayer"){
			trace("Spawn clear");
			_global.abstractLaw.popCreature(_global.player);
			_global.player.hpline.removeMovieClip();
			_global.player.hpline = null;
			_global.player.remove();
			_global.player = null;
		}
	}
	
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
				this.remove();
			}
		}
	}
	
	private function configuratePlayer(a:Player, k:Number){
		a.setScale(k);
	}
	
	private function configurationPart(a:GameObject){
		a._x=this._x;
		a._y=this._y;
		a.xA = 0;
		a.yA = 0;
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