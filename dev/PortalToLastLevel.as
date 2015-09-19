class PortalToLastLevel extends PortalToLevel{
	// Переопределение
	public function doTeleportation(){
		_root["CenterOfWorld"].goToLastLevel();
	}
}