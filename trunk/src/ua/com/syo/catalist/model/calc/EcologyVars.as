package ua.com.syo.catalist.model.calc {
	import ua.com.syo.catalist.data.CycleData;
	import ua.com.syo.catalist.model.polynoms.PolyModelsXX;
	import ua.com.syo.catalist.utils.Integral;
	
	public class EcologyVars {
		/** Концентрації **/
		//
		public static function getCO(time:Number): Number {
			var result:Number = 0;
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					result = PolyModelsXX.CO(EnergyVars.getNdv(time));
					break;
			}
			return result;
		}
		
		//
		public static function getCO2(time:Number): Number {
			var result:Number = 0;
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					result = PolyModelsXX.CO2(EnergyVars.getNdv(time));
					break;
			}
			return result;
		}
		
		//
		public static function getNOx(time:Number): Number {
			var result:Number = 0;
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					result = PolyModelsXX.NOX(EnergyVars.getNdv(time));
					break;
			}
			return result;
		}
		
		//
		public static function getHCs(time:Number): Number {
			var result:Number = 0;
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					result = PolyModelsXX.CH(EnergyVars.getNdv(time));
					break;
			}
			return result;
		}
		
		//
		public static function getO2(time:Number): Number {
			var result:Number = 0;
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					result = PolyModelsXX.O2(EnergyVars.getNdv(time));
					break;
			}
			return result;
		}
		
		/** Масові викиди **/
		//
		public static function getGCO(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					var mf:ModePhase = CycleData.getModeTime(time);
					result = Integral.rectangleRule(mf.startTime, mf.endTime, 0.001, f1);
					break;
			}
			
			return result;
		}
		
		//
		public static function getGCO2(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					var mf:ModePhase = CycleData.getModeTime(time);
					result = Integral.rectangleRule(mf.startTime, mf.endTime, 0.001, f2);
					break;
			}
			
			return result;
		}
		
		//
		public static function getGNOx(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					var mf:ModePhase = CycleData.getModeTime(time);
					result = Integral.rectangleRule(mf.startTime, mf.endTime, 0.001, f3);
					break;
			}
			
			return result;
		}
		
		//
		public static function getGHCs(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					var mf:ModePhase = CycleData.getModeTime(time);
					result = Integral.rectangleRule(mf.startTime, mf.endTime, 0.001, f4);
					break;
			}
			
			return result;
		}
		
		//
		public static function getGO2(time:Number): Number {
			var result:Number = 0;
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					var mf:ModePhase = CycleData.getModeTime(time);
					result = Integral.rectangleRule(mf.startTime, mf.endTime, 0.001, f5);
					break;
			}
			return result;
		}
		
		/** Integrals functions **/
		public static function f1(x:Number):Number {
			return PolyModelsXX.GCO(x);
		}
		
		public static function f2(x:Number):Number {
			return PolyModelsXX.GCO2(x);
		}
		
		public static function f3(x:Number):Number {
			return PolyModelsXX.GNOX(x);
		}
		
		public static function f4(x:Number):Number {
			return PolyModelsXX.GCH(x);
		}
		
		public static function f5(x:Number):Number {
			return PolyModelsXX.GO2(x);
		}
		
	}
}