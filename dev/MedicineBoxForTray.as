class MedicineBoxForTray extends MedicineBox{
	// Οεπεξοπεδελενθε
	public function getType():String{
		return "MedcineBoxForTray";
	}
	// Οεπεξοπεδελενθε
	private function acceptMedBox(gameObject1, gameObject2):Boolean{
		return (gameObject1.getType()==="MedcineBoxForTray" && gameObject2.getType()==="Ladone3Tray");
	}
}