class PortalToGameOver extends PortalToLevel{
	// ���������������
	public function doTeleportation(){
		_root["CenterOfWorld"].goToAndStopFrame(1);
	}
}