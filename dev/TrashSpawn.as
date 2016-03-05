class TrashSpawn extends GameObject{
	public function TrashSpawn(){
		this._visible = false;
	}
	var damage = 20;
	var trashCount = 0;
	var timer = 0;
	var trashMaxCount = 20;
	/*var bullets = ['GhostBullet',
				   'MaskitBullet',
				   'Bullet'];*/
	var bullets = ['StoneBullet','StoneBullet2'];
	
	public function createBullet(){
		if(bullets.length>0){
			var bulletNumber = Math.round(Math.random()*(bullets.length-1));
			var chieldBullet = _root.attachMovie(bullets[bulletNumber], "ghostbullet"+(Bullet.count), _root.getNextHighestDepth());

			var x = this._x+Math.random()*this._width;
			var speed:Number = 5 + Math.random()*15;
			var k:Number=(Math.random()*0.4+0.2);
			
			chieldBullet._xscale = chieldBullet._xscale*k;
			chieldBullet._yscale = chieldBullet._yscale*k;
			
			//trace("xd: "+brain.getDistance().xo+"\nyd: "+brain.getDistance().yo+"\nangl: "+angl);
			chieldBullet.StartBullet(
				90,
				speed,
				x,
				this._y,
				(this.damage*k+speed)/2,
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