// =============================
class HPLine{
// =============================
private var healthMax:Number;
private var health:Number;
private var healthLine1:MovieClip;
private var healthLine2:MovieClip;
// =============================


// (1) HPLine
// =============================
public function	HPLine(){
	trace("HPCreated!");
}

public function	setHPLine(MaxHP:Number){
		this.healthMax = MaxHP;
		this.health = MaxHP;
	} 
	
// (4) getHPM
// =============================	
public function get HPM():Number{
		return this.healthMax;		
	}
	
// (5) setHPM
// =============================	
public function set HPM(hpm:Number){
		if(hpm > 0){
			this.healthMax = hpm;		
		}else{
			this.health = 100;
		}
	}
	
// (6) getHP
// =============================	
public function get HP():Number{
		return this.health;		
	}
	
// (7) setHP
// =============================	
public function set HP(hp:Number){
	    if((hp <= this.healthMax)&&(hp > 0)){
			this.health = hp;		
		}else{
			this.health = this.healthMax;
		}
	}
	
// (8) treatment
// =============================	
public function treatment(x:Number){
		if((this.health+x)<this.healthMax){
			this.health = this.health + x;
		}else{
			this.health = this.healthMax;
		}
	}
	
// (9) damage
// =============================	
public function damage(x:Number){
		if((this.health-x) > 0){
			this.health = this.health - x;
		}else{
			this.health = 0;
		}
	}
	
// (11) calcPersent
// =============================	
public function calcPersent():Number{
		return Math.round(this.health*100/this.healthMax);
}
}
















