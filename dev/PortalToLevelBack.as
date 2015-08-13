class PortalToLevelBack extends PortalToLevel{
	// Переопределение
	public function doTeleportation(){
		_root["CenterOfWorld"].goToAndStopToPrevFrame();
	}
}