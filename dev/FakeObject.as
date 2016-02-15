class FakeObject extends GameObject{
	var state:Number = 0;
	var ANIMATION_TIME:Number = 50*3;
	var timer:Number = 0;
	var switcher:Switcher;
	
	public function FakeObject(){
		this.switcher = new Switcher(2,this);
	}
	
	// Переопределение
	public function onEnterFrameNoAction(){
		switch(this.state){
			case 0:
				if(_global.player && _global.player.downObject && _global.player.downObject==this){
					this.state++;
					this.switcher.state = 2;
				}
				break;
			case 1:
				this.timer++;
				if(timer>=ANIMATION_TIME)this.state++
				break;
			case 2:
				this.remove();
				break;
			default:
		}
	}
	
	// Переопределение
	public function deinit():Boolean{
		this.state = 0;
		this.timer = 0;
		return false;
	}
}