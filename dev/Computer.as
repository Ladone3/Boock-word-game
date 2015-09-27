class Computer extends Player{
	//Мозг
	//===============================
	private var brain:Intellect;

	// Характеристики персонажа
	//===============================
	private var jumpPower:Number = 30;
	private var runPower:Number = 7;
	public var damage:Number = 30;
	public var radius:Number = 15;
	public var hpmax:Number = 60;
	
	public function getBrain():Intellect{
		return new Intellect(this);
	}
	
	public function Computer(){
		this,brain=this.getBrain();
		this.hpline.setHPLine(this.hpmax);
	}
	
	// Переопределение	
	public function getType():Number{
		return 2;
	}
	
	// Переопределение
	public function deinit():Boolean{
		return this.getDepth()>=0;
	}
	
	// Переопределение
	//==============================================
	public  var kUp:Boolean    = false;
	public  var kDown:Boolean  = false;
	public  var kLeft:Boolean  = false;
	public  var kRight:Boolean = false;
	public  var kFight:Boolean = false;
	public  var kJump:Boolean  = false;
	//==============================================
	public function keyReading(){
		if(!this.counter.notOver){
			if(kLeft||kRight||kJump||kFight){
				if(this.inAero){
				//============================================================
					if(kJump){
						this.jump();
					}
					if(kLeft && (!kRight)){
						this.planLeft();
					}
					if(kRight && (!kLeft)){
						this.planRight();
					}
					if(kRight && kLeft && (!kJump)){
						setfreeState();
					}
					
				//============================================================
				}else{
				//============================================================
					if(kJump){
						this.jump();
					}

					if(kFight){
						this.blow();
					}
					
					if(kLeft 
						&& (!(kRight||kJump))
					){
						this.runLeft();
					}
					if(kRight
						&& (!(kLeft||kJump))
					){
						this.runRight();
					}
					if(kRight && kLeft && (!kJump)){
						setfreeState();
					}
				//============================================================
				}
			}else{
				setfreeState();
			}
		}
	}
	
	//Переопределение
	public function remove(){
		if(_global.abstractLaw[this.ID]!=null && !this.counter.notOver()){
			super.remove();
		}
	}
		
	//Переопределение
	public function onEnterFrameAction(){
		super.onEnterFrameAction();		
		this.brain.activitys();
	}

	// Переопределение
	public function takeObject(object:GameObject):Boolean{
		return (object.getType()==0 || object.getType()==2);// || object.getType()==4 || object.getType()==6 || object.getType()==3 || object.getType()==5);
	}
		
	// Переопределение
	public function blowPermission(radius:Number, damage:Number,k:Number):Boolean{
		var nWidth = this.radius*2; //this._x+100,this._y,50,this.damage
		var nHeight = nWidth;
		if(_global.player!=null){
			var offset:Number = 0;
			if(direct){
				offset = 100;
			}else{
				offset = -100;
			}
			var temp1 = this.getBounds(_root);
			var nXMin = temp1.xMin + this._width/2 - radius + offset;
			var nYMin = temp1.yMin + this._height/2 - radius;
			var temp2 = _global.player.getBounds(_root);
			if((nXMin >= temp2.xMin - nWidth)&&(nYMin >= temp2.yMin - nHeight)&&(nXMin <= temp2.xMax)&&(nYMin <= temp2.yMax)&&(_global.player.life)){                                                                                              
					_global.player.hpline.damage(damage);
					if(direct){
						_global.player.xA = damage/2*k;
					}else{
						_global.player.xA = -damage/2*k;
					}
					return true;
			}
		}
		return false;
	}
}

