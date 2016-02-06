class Maskit extends Ghost{
	// Характеристики
	//===============================
	private var jumpPower:Number = 35;
	private var runPower:Number = 10;
	public var damage:Number = 20;
	public var radius:Number = 15;
	public var hpmax:Number = 160;
	public var stunDelay:Number = 10;
	private var ACTIVE_K_X_DIST = 3;
	private var ACTIVE_K_Y_DIST = 3;
	private	var ghostIntellect:GhostIntellect = null;

	private var bulletClass = "MaskitBullet";
	
	//Переопределение
	public function blow(){
		if(stayOrNo!=0){
			fastBlow();
		}else{
			dblow();
		}
		stayOrNo++;
		if(stayOrNo>4)stayOrNo=0;
	}
}
