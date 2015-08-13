// ==============================Функции==============================
// (1) HPLineView
// (2) getTension
// (3) setTension
// (2_1) getTensionM
// (3_1) setTensionM
// (4) getHPM
// (5) setHPM
// (6) getHP
// (7) setHP
// (8) treatment
// (9) damage
// (10) calcTension
// (11) calcPersent
// (12) looping	

// =============================
class HPLineView extends MovieClip{
// =============================
private var tension1:Number;
private var tension2:Number;
private var healthMax:Number;
private var health:Number;
private var healthLine1:MovieClip;
private var healthLine2:MovieClip;

// =============================


// (1) HPLineView
// =============================
public function	HPLineView(){
	trace("HPCreated!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
}

public function	setHPLineView(MaxHP:Number){
		this.tension1 = this["health1"]._width;
		this.tension2 = 0;
		this.healthMax = MaxHP;
		this.health = MaxHP;
		
		this.healthLine1 = this["health2"];
		this.healthLine2 = this["health1"];
		
		if(this.healthLine1 != undefined){
			this.healthLine1._width = 0;
		}
		if(this.healthLine2 != undefined){
			this.healthLine2._width = 0;
		}
	} 
	
// (2) getTension
// =============================	
public function get tens2():Number{
		return this.tension2;	
	}
			
// (3) setTension
// =============================	
public function set tens2(tn:Number){
		if((tn > 0)&&(tn <= this.tension1)){
			this.tension2 = tn;
		}else{
			this.tension2 = 0;
		}
	}
	
// (2_1) getTensionM
// =============================	
public function get tens1():Number{
		return this.tension1;	
	}
			
// (3_1) setTensionM
// =============================	
public function set tens1(tn:Number){
		if(tn > 0){
			this.tension1 = tn;
		}else{
			this.tension1 = 0;
		}
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
		this.tens1 = calcTension(this.calcPersent());
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
		this.tens2 = calcTension(this.calcPersent());
	}
	
// (8) treatment
// =============================	
public function treatment(x:Number){
		if((this.health+x)<this.healthMax){
			this.health = this.health + x;
		}else{
			this.health = this.healthMax;
		}
		//trace("calcTension(this.calcPersent()) = "+calcTension(this.calcPersent()));
		this.tens2 = calcTension(this.calcPersent());
		//trace("this.tension1 = "+this.tension1);
	}
	
// (9) damage
// =============================	
public function damage(x:Number){
		if((this.health-x) > 0){
			this.health = this.health - x;
		}else{
			this.health = 0;
		}
		//trace("calcTension(this.calcPersent()) = "+calcTension(this.calcPersent()));
		this.tens2 = calcTension(this.calcPersent());
		//trace("this.tens1 = "+this.tens1);
	}
	
// (10) calcTension
// =============================	
public function calcTension(p:Number):Number{
		//trace("this.tension1 = "+this.tension1);
		//trace("this.tension1*(1-p/100) = "+this.tension1*(1-p/100));
		return this.tension1*(1-p/100);
	}
	
// (11) calcPersent
// =============================	
public function calcPersent():Number{
		return Math.round(this.health*100/this.healthMax);
	}
	
// (12) looping
// =============================	
public function onEnterFrame(){
		if(this.healthLine2._width<this.tension2){
			if(this.healthLine2._width+5<=this.tension1){
				this.healthLine2._width=this.healthLine2._width+5;
			}else{
				this.healthLine2._width=this.tension1;
			}
		}
		if(this.healthLine2._width>this.tension2){
			this.healthLine2._width=this.tension2;
		}
		this.healthLine1._width=this.tension2;	
	}
}
















