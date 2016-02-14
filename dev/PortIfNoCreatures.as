class PortIfNoCreatures extends PortalToLevel{	
	//Переопределение
	public function onEnterFrameCatchPlayer(){
		if(_global.player!=null){
				//trace(_global.abstractLaw.creatures.length)
				if(this.hitTest(_global.player)&&(_root._color.brightness>=100)&&(_global.abstractLaw.creatures.length<2)){
					this.nocatch = false;
					this.doTeleportation();
				}else{
					this.nocatch = true;
				}
		}	
	}
}