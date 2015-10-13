class Infighting extends Bullet{
	private var counter2:Counter;
	private var started:Boolean=false;
	
	public  function Infighting(){
		this.counter2 = new Counter();
		this.started = false;
	}
	
	//Переопределение
	public function StartBullet(angle:Number, 
								velocity:Number, 
								x:Number, 
								y:Number, 
								d:Number, 
								parentMovieClip:MovieClip,  
								delayExpl:Number){
		this.started = true;
		this.counter2.delay = delayExpl;
		super.StartBullet(angle, velocity, x, y, d, parentMovieClip, false);
	}
	
	//Переопределение
	public function onEnterFrame(){
		if(!_global.doPause){
			super.onEnterFrame();
			if((!this.counter2.notOver) && this.started){
				//this.explosion();
				this.remove();
			}
			this.counter2.iterateCounter();
		}
	}
}