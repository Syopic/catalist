package ua.com.syo.catalist.model.calc {
	import ua.com.syo.catalist.data.CycleData;
	import ua.com.syo.catalist.model.ModePhase;
	import ua.com.syo.catalist.model.polynoms.PolyModelsXX;
	import ua.com.syo.catalist.utils.Integral;
	
	public class EconomyVars {
		
		//витрата палива
		public static function getGpal(time:Number): Number {
			var result:Number = Math.random()*1000;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
					var mf:ModePhase = CycleData.getModeTime(time);
					result = Integral.rectangleRule(mf.startTime, mf.endTime, 0.001, f1);
					break;
			}
			
			return result;
		}
		
		//витрата повітря
		public static function getGpov(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
		
		/** Integrals functions **/
		public static function f1(x:Number):Number {
			return PolyModelsXX.Gpal(EnergyVars.getNdv(x));
		}
	}
}