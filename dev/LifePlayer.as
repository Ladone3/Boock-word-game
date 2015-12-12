class LifePlayer extends Player{
	private var dontTuchMe:Counter;
	private var defTime:Number = 100;

	public function youMayTuchMe(){
		this.dontTuchMe.delay = 0;
	}

	public function LifePlayer(){
		this.dontTuchMe = new Counter();
		_global.player = this;
	}

	//Переопределение
	public function permissionToMov(np:Point):Point{
		var nnp:Point = super.permissionToMov(np);
		//this.isCalc = true;
		return nnp;
	}

	// Переопределение
	public function takeObject(object:GameObject):Boolean{
		return (object.getType()==0);
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
				if(this._color.red<50){
					alphatrigger=false;
				}else{
					this._color.red-=10;
					this._color.green+=10;
					this._color.blue+=10;
				}
			}else{
				if(this._color.red>100){
					alphatrigger=true;
				}else{
					this._color.red+=10;
					this._color.green-=10;
					this._color.blue-=10;
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
	private function lifeOrDie(){
		if((!life)&&(!this.counter.notOver)){
			if(!this.counter.notOver){
				_root["CenterOfWorld"].goToLimbo();
			}
		}
	}

	//Переопределение
	public function setDie(){
		this.counter.delay = 0;
		if(this.direct){
			this.switcher.state = 13;
		}else{
			this.switcher.state = 14;
		}
		this.counter.delay = 100;
	}
}
