class MedicineBoxForTray extends MedicineBox{
	// ���������������
	public function getType():String{
		return "MedcineBoxForTray";
	}
	// ���������������
	private function acceptMedBox(gameObject1, gameObject2):Boolean{
		return (gameObject1.getType()==="MedcineBoxForTray" && gameObject2.getType()==="Ladone3Tray");
	}
}