class MedicineBoxForTray extends MedicineBox{
	// Переопределение
	public function getType():String{
		return "MedicineBoxForTray";
	}
	// Переопределение
	private function acceptMedBox(gameObject1, gameObject2):Boolean{
		return (gameObject1.getType()==="MedcineBoxForTray" && gameObject2.getType()=="Ladone3Player");
	}
}