class SwitchState{
	// Количество состояний
	//=======================================================
	private var countState:Number; 
	public function get count(){
		return this.countState;
	}
	
	public function SwitchState(countState:Number){
		this.countState=countState;
	}
}

/*
public function readState():Void{
if((this.mc<>undefined)&&(this.getLockPower()<=0)){
	switch (this.getState()) {
	case (0): 
                  //trace ("покой вперёд"); 
				  this.mc.gotoAndStop(1);
                  break ; 
    case (1): 
                  //trace ("движется влево"); 
				  this.mc.gotoAndStop(2);
                  break ;
    case (2): 
                  //trace ("движется вправо"); 
				  this.mc.gotoAndStop(3);
                  break ; 				  
	case (3): 
                  //trace ("в воздухе"); 
				  this.mc.gotoAndStop(1);
                  break ; 
	case (4): 
                  //trace ("прыжок назад"); 
				  this.mc.gotoAndStop(4);
                  break ; 
    case (5): 
                  //trace ("присел влево"); 
				  this.mc.gotoAndStop(5);
                  break ;   
	case (6): 
                  //trace ("удар вперёд"); 
				  this.mc.gotoAndStop(6);
                  break ; 				  

	case (7): 
                  //trace ("покой назад"); 
				  this.mc.gotoAndStop(7);
                  break ; 
	case (8): 
                  //trace ("удар назад"); 
				  this.mc.gotoAndStop(8);
                  break ; 
	case (9): 
                  //trace ("прыжок вперёд"); 
				  this.mc.gotoAndStop(9);
                  break ; 
				  
	case (10): 
                  //trace ("присел вправо"); 
				  this.mc.gotoAndStop(10);
                  break ;  
				  
    case (11): 
                  //trace ("прыжок вправо"); 
				  this.mc.gotoAndStop(11);
                  break ; 
	case (12): 
                  //trace ("прыжок влево"); 
				  this.mc.gotoAndStop(12);
                  break ; 
	case (13): 
                  //trace ("люлю вправо"); 
				  this.mc.gotoAndStop(13);
                  break ; 
	case (14): 
                  //trace ("люлю влево"); 
				  this.mc.gotoAndStop(14);
                  break ; 
    default: 
                  //trace ("другое"); 
			      this.mc.gotoAndStop(1);
 }
}else{
	//trace('this.getLockPower()='+this.getLockPower());
	this.setLockPower(this.getLockPower()-1);
}
}
*/