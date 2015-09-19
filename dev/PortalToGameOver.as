class PortalToGameOver extends PortalToLevel{
	// Переопределение
	public function doTeleportation(){
		_root["CenterOfWorld"].goToMenu();
	}
}