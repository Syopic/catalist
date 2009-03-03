package ua.com.syo.catalist.model.polynoms {
	import flash.utils.Dictionary;
	
	public class Polynoms {
		
		public static var pDict:Dictionary = new Dictionary(true);
		
		public static var currentGas:String;
		public static var currentMode:String;
		public static var currentFuel:String;
		public static var currentCycleMode:String;
		
		/**
		 * @param label 	A1,A0, A11 ...
		 * @param gas 		CO2, NO2 ...
		 * @param mode 		withoutNeutralizer, beforeNeutralizer, afterNeutralizer;
		 * @param fuel 		gasoline, gas, afterNeutralizer;
		 * @param cycleMode load, XX, PXX;
		 */
		public static function addPolynom(value:Number,
											label:String, 
											gas:String = null, 
											mode:String = null, 
											fuel:String = null, 
											cycleMode:String = null):void {
			if (!gas) gas = currentGas;
			if (!mode) mode = currentMode;
			if (!fuel) fuel = currentFuel;
			if (!cycleMode) cycleMode = currentCycleMode;
			
			pDict[cycleMode + fuel + mode + gas + label] = value;
		}
		
		/**
		 * @param label 	A1,A0, A11 ...
		 * @param gas 		CO2, NO2 ...
		 * @param mode 		withoutNeutralizer, beforeNeutralizer, afterNeutralizer;
		 * @param fuel 		gasoline, gas, afterNeutralizer;
		 * @param cycleMode load, XX, PXX;
		 * 
		 * @return Number value of polynom
		 */
		public static function getP(label:String, 
											gas:String = null, 
											mode:String = null, 
											fuel:String = null, 
											cycleMode:String = null):Number {
			
			if (!gas) gas = currentGas;
			if (!mode) mode = currentMode;
			if (!fuel) fuel = currentFuel;
			if (!cycleMode) cycleMode = currentCycleMode;
			
			return pDict[cycleMode + fuel + mode + gas + label];
		}
	}
}