package ua.com.syo.catalist.model.polynoms {
	public class PolynomsParser {
		
		private static var cycleModeArray:Array=["load", "XX", "PXX"];
		private static var fuelArray:Array=["gasoline", "gas"];
		private static var modeArray:Array=["withoutN", "beforeN", "afterN"];
				
		[Bindable]
		public static var loadArray:Array=["CO", "CO2", "HCs", "NOx", "O2", "Gпал", "Gпов", "dPk", "phiDros"];
		[Bindable]
		public static var xxArray:Array=["CO", "CO2", "HCs", "NOx", "O2", "Gпал", "Gпов", "phiDros"];
		[Bindable]
		public static var pxxArray:Array=["CO", "CO2", "HCs", "NOx", "O2", "Gпал", "Gпов", "Mk", "dPk", "phiDros"];
		
		[Bindable]
		public static var label1Array:Array=["A0", "A1", "A2", "A11", "A22", "A12", "A111", "A222"];
		[Bindable]
		public static var label2Array:Array=["A0", "A1", "A11", "A111", "A1111", "A11111"];
		
		public static function parse(xml:XMLList):void {
			var gasArray:Array;
			var labelArray:Array;
			
			for (var c:int = 0; c < cycleModeArray.length; c++) {
				for (var f:int = 0; f < fuelArray.length; f++) {
					for (var m:int = 0; m < modeArray.length; m++) {
						
						PolyKoef.currentCycleMode = cycleModeArray[c];
						PolyKoef.currentFuel = fuelArray[f];
						PolyKoef.currentMode = modeArray[m];
						
						
						var tStr:String = xml.child(cycleModeArray[c]).child(fuelArray[f]).child(modeArray[m]).children()[0];
						var lines:Array = tStr.split("|");
						
						// ***************************
						gasArray = null;
						labelArray = null;
						
						if (PolyKoef.currentCycleMode == "load") {
							gasArray = loadArray;
						}
						if (PolyKoef.currentCycleMode == "XX") {
							gasArray = xxArray;
						}
						if (PolyKoef.currentCycleMode == "PXX") {
							gasArray = pxxArray;
						}
						
						if (PolyKoef.currentCycleMode == "load") {
							labelArray = label1Array;
						} else {
							labelArray = label2Array;
						}
						
						//***************************
						
						for (var g:int = 0; g < gasArray.length; g++) {
							var vArray:Array = (lines[g] as String).split(";");
							for (var v:int = 0; v < vArray.length; v++) {
								PolyKoef.addPolynom(vArray[v], labelArray[v], gasArray[g]);
							}
						}
						
					}
				}
			}
			
		}

	}
}