class MedicineBox extends MovedObject{
	private var used:Boolean;
	private var counter:Counter;
	
	public function notUsed():Boolean{
		return !this.used;
	}
	
	public function MedicineBox(){
		this.mov = true;
		this.used = false;
		this.pow = 100;
		this.counter = new Counter();
	}
	
	private var power:Number;
	public function set pow(p:Number){
		this.power = p;
	}
	public function get pow():Number{
		return this.power;
	}
	
	public function useIt(){
		this.counter.delay = 10;
		this.used = true;
	}
	
	// Переопределение
	public function getType():Number{
		return 4;
	}
	
	// Переопределение
	public function takeObject(object:GameObject):Boolean{
		return (object.getType()==0);
	}
	
	// Переопределение
	public function onEnterFrameAction(){
		super.onEnterFrameAction();
		this.onEnterFrameCatchPlayer();
		this.counter.iterateCounter();
		if(this.used && !this.counter.notOver){
			this.remov();
		}else{
			if(this.used){
				this.lawRef.Target.setTreatment(this.power/10);
				this._alpha-=10;
			}
		}
	}
	
	//Переопределение
	public function onEnterFrameCatchPlayer(){
		var nWidth = this._width;
		var nHeight = this._height;
		var temp1 = this.getBounds(_root);
		if(this.lawRef.Target!=null){
				if(this.hitTest(this.lawRef.Target)){
					if(acceptMedBox(this,this.lawRef.Target) && this.notUsed()){
						//this.lawRef.Target.setTreatment(this.power);
						this.useIt();
					}
				}
		}	
	}
	
	private function acceptMedBox(gameObject1, gameObject2):Boolean{
		return (gameObject1.getType()==4 && gameObject2.getType()==3);
	}
}