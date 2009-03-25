package ua.com.syo.catalist.model.calc {
	import ua.com.syo.catalist.data.CycleData;
	import ua.com.syo.catalist.data.KoefStorage;
	import ua.com.syo.catalist.model.ModePhase;
	import ua.com.syo.catalist.model.polynoms.PolyModelsXX;
	import ua.com.syo.catalist.utils.DiffUr;
	
	public class EnergyVars	{
		
		// частота обертання колінчастого валу двигуна
		public static function getNdv(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ": result = KoefStorage.nXXmin; break;
				case "рушання":
					result = getOmega(time) * 30 / Math.PI;
					break;
			}
			
			return result;
		}
		
		//кутова швидкість обертання колінвалу
		public static function getOmega(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ": result = getNdv(time) * Math.PI / 30; break;
				case "рушання":	
					var mf:ModePhase = CycleData.getModeTime(time);
					result = KoefStorage.nXXmin * Math.PI / 30 + (((KoefStorage.nDvZchep - KoefStorage.nXXmin) * Math.PI ) /( 30 * KoefStorage.koef ))* (time - mf.startTime);
					break;
			}
			
			return result;
		}
		
		//крутний момент
		public static function getMk(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = 0;
					break;
				case "рушання":
					result = KoefStorage.Idv * DiffUr.rungeKutta((time-0.1), getNdv(time - 0.1), time, 10, df1);
					break;	
			}
			
			return result;
		}
		
		//розрідження за дросельними заслінками (дельта пека)
		public static function getDeltaPk(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = KoefStorage.deltaPkXX;
					break;
			}
			
			return result;
		}
		
		//кут відкриття дросельних заслінок (фі дроселя)
		public static function getPhiDros(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = PolyModelsXX.fiDr(getNdv(time));
					break;
			}
			
			return result;
		}
		
		//швидкість КТЗ
		public static function getV(time:Number): Number {
			var result:Number = 0;
			return result;
		}
		
		/** Diff functions **/
		public static function df1(x:Number, y:Number):Number {
			return getOmega(x);
		}
	}
}