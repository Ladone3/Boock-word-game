class TrashSpawn extends GameObject{
	public function TrashSpawn(){
	}
	var damage = 10;
	var trashCount = 0;
	var timer = 0;
	var trashMaxCount = 100;
	var bullets = ['GhostBullet',
				   'MaskitBullet',
				   'Bullet'];
	
	public function createBullet(){
		if(bullets.length>0){
			var bulletNumber = Math.round(Math.random()*(bullets.length-1));
			var chieldBullet = _root.attachMovie(bullets[bulletNumber], "ghostbullet"+(Bullet.count), _root.getNextHighestDepth());

			var x = this._x+Math.random()*this._width;
			var speed = 5 + Math.random()*20;
			//trace("xd: "+brain.getDistance().xo+"\nyd: "+brain.getDistance().yo+"\nangl: "+angl);
			chieldBullet.StartBullet(
				90,
				15,
				x,
				this._y,
				this.damage,
				this,
				true);
		}
	}
	
	public function onEnterFrame() {
		
		if(this.timer<=0){
			if(this.trashCount<this.trashMaxCount){
				this.createBullet();
				trace("Bang-bang");
				this.trashCount++;
			}else{
				_root["CenterOfWorld"].goToAndStopToNextFrame();
			}
			this.timer = 10 + Math.random()*50;
		}
		this.timer--;
		
	}
}