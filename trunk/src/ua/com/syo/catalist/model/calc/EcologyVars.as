package ua.com.syo.catalist.model.calc {
	import ua.com.syo.catalist.data.CycleData;
	import ua.com.syo.catalist.data.Globals;
	import ua.com.syo.catalist.data.KoefStorage;
	import ua.com.syo.catalist.model.ModePhase;
	import ua.com.syo.catalist.model.polynoms.PolyModelsNav;
	import ua.com.syo.catalist.model.polynoms.PolyModelsPXX;
	import ua.com.syo.catalist.model.polynoms.PolyModelsXX;
	import ua.com.syo.catalist.utils.Integral;
	import ua.com.syo.utils.MathUtils;
	
	public class EcologyVars {
		/** Концентрації **/
		//
		public static function getCO(time:Number): Number {
			var result:Number = 0;
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					result = PolyModelsXX.CO(time);
					break;
				case "розгін-":
				case "розгін+":
				case "стала":
					result = PolyModelsNav.CO(time);
				break;
				case "упов.+":
				case "упов.-":
				case "перемик.":
					if (EnergyVars.getNdv(time) >= KoefStorage.nXXmin) {
						result = PolyModelsPXX.CO(time);
					} else {
						result = PolyModelsXX.CO(time);
					}
				break;	
			}
			return MathUtils.setRestriction(result, 0);
		}
		
		//
		public static function getCO2(time:Number): Number {
			var result:Number = 0;
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					result = PolyModelsXX.CO2(time);
					break;
				case "розгін-":
				case "розгін+":
				case "стала":
					result = PolyModelsNav.CO2(time);
				break;
				case "упов.+":
				case "упов.-":
				case "перемик.":
					if (EnergyVars.getNdv(time) >= KoefStorage.nXXmin) {
						result = PolyModelsPXX.CO2(time);
					} else {
						result = PolyModelsXX.CO2(time);
					}
				break;		
			}
			return MathUtils.setRestriction(result, 0);
		}
		
		//
		public static function getNOx(time:Number): Number {
			var result:Number = 0;
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					result = PolyModelsXX.NOX(time);
					break;
				case "розгін-":
				case "розгін+":
				case "стала":
					result = PolyModelsNav.NOX(time);
				break;
				case "упов.+":
				case "упов.-":
				case "перемик.":
					if (EnergyVars.getNdv(time) >= KoefStorage.nXXmin) {
						result = PolyModelsPXX.NOX(time);
					} else {
						result = PolyModelsXX.NOX(time);
					}
				break;			
			}
			return MathUtils.setRestriction(result, 0);
		}
		
		//
		public static function getHCs(time:Number): Number {
			var result:Number = 0;
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					result = PolyModelsXX.CH(time);
					break;
				case "розгін-":
				case "розгін+":
				case "стала":
					result = PolyModelsNav.CH(time);
				break;
				case "упов.+":
				case "упов.-":
				case "перемик.":
					if (EnergyVars.getNdv(time) >= KoefStorage.nXXmin) {
						result = PolyModelsPXX.CH(time);
					} else {
						result = PolyModelsXX.CH(time);
					}
				break;				
			}
			return MathUtils.setRestriction(result, 0);
		}
		
		//
		public static function getO2(time:Number): Number {
			var result:Number = 0;
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					result = PolyModelsXX.O2(time);
					break;
				case "розгін-":
				case "розгін+":
				case "стала":
					result = PolyModelsNav.O2(time);
				break;
				case "упов.+":
				case "упов.-":
				case "перемик.":
					if (EnergyVars.getNdv(time) >= KoefStorage.nXXmin) {
						result = PolyModelsPXX.O2(time);
					} else {
						result = PolyModelsXX.O2(time);
					}
				break;			
			}
			return MathUtils.setRestriction(result, 0);
		}
		
		/** Масові викиди **/
		//
		public static function getGCO(time:Number): Number {
			var result:Number = 0;
	
			var mf:ModePhase = CycleData.getModeTime(time);
			return Integral.rectangleRule(mf.startTime, mf.endTime, Globals.integStep, f1);
			
			return result;
		}
		
		//
		public static function getGCO2(time:Number): Number {
			var result:Number = 0;
			
			var mf:ModePhase = CycleData.getModeTime(time);
			result = Integral.rectangleRule(mf.startTime, mf.endTime, Globals.integStep, f2);
			
			return result;
		}
		
		//
		public static function getGNOx(time:Number): Number {
			var result:Number = 0;
			
			var mf:ModePhase = CycleData.getModeTime(time);
			result = Integral.rectangleRule(mf.startTime, mf.endTime, Globals.integStep, f3);
			
			return result;
		}
		
		//
		public static function getGHCs(time:Number): Number {
			var result:Number = 0;
			
			var mf:ModePhase = CycleData.getModeTime(time);
			result = Integral.rectangleRule(mf.startTime, mf.endTime, Globals.integStep, f4);
			
			return result;
		}
		
		//
		public static function getGO2(time:Number): Number {
			var result:Number = 0;
			
			var mf:ModePhase = CycleData.getModeTime(time);
			result = Integral.rectangleRule(mf.startTime, mf.endTime, Globals.integStep, f5);
			
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