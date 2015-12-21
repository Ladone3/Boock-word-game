class KeyGhost extends Ghost{
	//Переопределение
	private function lifeOrDie(){
		super.lifeOrDie();
		if((!life)&&(!this.counter.notOver)){
			if(!this.counter.notOver){
				_root["CenterOfWorld"].goToAndStopToNextFrame();
			}
		}
	}
}

