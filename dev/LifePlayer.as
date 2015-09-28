class LifePlayer extends Player{
	private var dontTuchMe:Counter;
	private var defTime:Number = 100;
	public function LifePlayer(){
		this.dontTuchMe = new Counter();
		_global.player = this;
	}

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
	
	// Переопределение
	public function setDamage(d:Number,dd:Boolean){
		if(!this.dontTuchMe.notOver){
			super.setDamage(d,dd);
			this.dontTuchMe.delay = defTime;
		}
	}
	
	private var alphatrigger = true;
	private function alphaChaose(){
		if(this.dontTuchMe.notOver){
			if(alphatrigger){
				if((this._alpha-=10)<50)alphatrigger=false;
			}else{
				if((this._alpha+=10)>100)alphatrigger=true;
			}
		}else if(this._alpha!=100){
			this._alpha = 100;
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