class PortalToLastLevel extends PortalToLevel{
	// ���������������
	public function doTeleportation(){
		if(_global.continous != 0){  
			_root["CenterOfWorld"].goToLastLevel();
		}else{
			_root["CenterOfWorld"].goToAndStopFrame(_global.startFrame);
		}
	}
}