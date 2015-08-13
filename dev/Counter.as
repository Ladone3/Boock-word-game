class Counter{
	// Счетчик
	//===============================
	private var stop:Boolean;
	public function set stopCounter(b:Boolean){
		this.stop=b;
	}
	public function get stopCounter():Boolean{
		return this.stop;
	}
	private var counter:Number=0;
	public function get delay():Number{
		return this.counter;
	}
	public function set delay(counter:Number){
		this.counter = counter;
	}
	public function iterateCounter(){
		if(this.counter>=0 && (!this.stop)){
			this.counter--;
		}
	}
	//private var BCounter:Boolean=false;
	public function get notOver():Boolean{
		if(this.counter <= 0){
			//trace("1");
			return false;
		}else{
			//trace("2");
			return true;
		}
		//return this.BCounter;
	}
	/*
	private function onCounter(nameValue:String, lastState:Number, newState:Number, dop):Number{
		if(this.counter <= 0){
			//trace("1");
			this.BCounter = false;
		}else{
			//trace("2");
			this.BCounter = true;
		}
		return newState;
	}
	*/
	public function Counter(){
		this.stop=false;
		//trace("Counter created!");
	}	
}