class LifePlayer extends Player{
	private var dontTuchMe:Counter;
	private var defTime:Number = 100;

	public function youMayTuchMe(){
		this.dontTuchMe.delay = 0;
	}

	public function LifePlayer(){
		trace("Player name:"+this._name);
		this.dontTuchMe = new Counter();
		_global.player = this;
	}

	// Переопределение
	public function takeObject(object:GameObject):Boolean{
		return (object.getType()==="GameObject");
	}

	// Переопределение
	public function setDamage(d:Number,dd:Boolean){
		if(!this.dontTuchMe.notOver){
			super.setDamage(d,dd);
			this.dontTuchMe.delay = defTime;
		}
	}

	// In the last i have not color transform and use _alpha, becouse it's named alphaChaose and alphatrigger.
	public function stopTrigger(){
		this.alphatrigger = true;
	}
	
	private var alphatrigger = true;
	private function alphaChaose(){
		if(this.dontTuchMe.notOver){
			if(alphatrigger){
				if(this._color.red>150){
					alphatrigger=false;
				}else{
					this._color.red+=10;
					this._color.green-=10;
					this._color.blue-=10;
				}
			}else{
				if(this._color.red<100){
					alphatrigger=true;
				}else{
					this._color.red-=10;
					this._color.green+=10;
					this._color.blue+=10;
				}
			}
		}else if(this._color.red!=100){
			this._color.red = 100;
			this._color.green = 100;
			this._color.blue = 100;
		}
	}

	//Переопределение
	public function onEnterFrameAction(){
		super.onEnterFrameAction();
		this.dontTuchMe.iterateCounter();
		alphaChaose();
	}

	//Переопределение
	//Переопределение
	private function lifeOrDie(){
		if((!life)&&(!this.counter.notOver)){
			if(!this.counter.notOver){
				_root["CenterOfWorld"].goToLimbo();
			}
		}
	}
	
	//Переопределение
	private function checkForDeath(){
		if(_global.LOT){
			if(this.hpline && this.hpline.HP!=undefined && this.hpline.HP<=0 && this.life){
				var powerdown = _root.attachMovie("PowerDown", "PowerDown", _root.getNextHighestDepth());
				trace("create changer");
				powerdown.visible = false;
				powerdown._x = this._x;
				powerdown._y = this._y;
				this.hpline.treatment(10);
			}
		}else{
			super.checkForDeath();
		}
	}
}
