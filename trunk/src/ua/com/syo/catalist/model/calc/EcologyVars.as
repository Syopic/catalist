package ua.com.syo.catalist.model.calc {
	import ua.com.syo.catalist.data.CycleData;
	import ua.com.syo.catalist.model.polynoms.PolyModelsXX;
	import ua.com.syo.catalist.utils.Integral;
	
	public class EcologyVars {
		/** Концентрації **/
		//
		public static function getCO(time:Number): Number {
			var result:Number = Math.random()*1000;
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = PolyModelsXX.CO(EnergyVars.getNdv(time));
					break;
			}
			return result;
		}
		
		//
		public static function getCO2(time:Number): Number {
			var result:Number = Math.random()*1000;
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = PolyModelsXX.CO2(EnergyVars.getNdv(time));
					break;
			}
			return result;
		}
		
		//
		public static function getNOx(time:Number): Number {
			var result:Number = Math.random()*1000;
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = PolyModelsXX.NOX(EnergyVars.getNdv(time));
					break;
			}
			return result;
		}
		
		//
		public static function getHCs(time:Number): Number {
			var result:Number = Math.random()*1000;
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = PolyModelsXX.CH(EnergyVars.getNdv(time));
					break;
			}
			return result;
		}
		
		//
		public static function getO2(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
		
		/** Масові викиди **/
		//
		public static function getGCO(time:Number): Number {
			var result:Number = Math.random()*1000;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
					var mf:ModePhase = CycleData.getModeTime(time);
					result = Integral.rectangleRule(mf.startTime, mf.endTime, 0.001, f1);
					break;
			}
			
			return result;
		}
		
		//
		public static function getGCO2(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
		
		//
		public static function getGNOx(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
		
		//
		public static function getGHCs(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
		
		//
		public static function getGO2(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
		
		/** Integrals functions **/
		public static function f1(x:Number):Number {
			return PolyModelsXX.GCO(x);
		}
		
	}
}