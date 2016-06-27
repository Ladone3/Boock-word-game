class PortalToLastLevel extends PortalToLevel{
	// Переопределение
	public function doTeleportation(){
		if(_global.continous != 0){  
			_root["CenterOfWorld"].goToLastLevel();
		}else{
			_root["CenterOfWorld"].goToAndStopFrame(_global.startFrame);
		}
	}
}