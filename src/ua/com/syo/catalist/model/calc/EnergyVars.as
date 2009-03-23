package ua.com.syo.catalist.model.calc {
	import ua.com.syo.catalist.data.CycleData;
	import ua.com.syo.catalist.data.KoefStorage;
	import ua.com.syo.catalist.model.polynoms.PolyModelsXX;
	
	public class EnergyVars	{
		
		// частота обертання колінчастого валу двигуна
		public static function getNdv(time:Number): Number {
			var result:Number = Math.random()*1000;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = KoefStorage.nXXmin;
					break;
			}
			
			return result;
		}
		
		//кутова швидкість обертання колінвалу
		public static function getOmega(time:Number): Number {
			var result:Number = Math.random()*1000;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = getNdv(time) * Math.PI / 30;
					break;
			}
			
			return result;
		}
		
		//крутний момент
		public static function getMk(time:Number): Number {
			var result:Number = Math.random()*1000;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = 0;
					break;
			}
			
			return result;
		}
		
		//розрідження за дросельними заслінками (дельта пека)
		public static function getDeltaPk(time:Number): Number {
			var result:Number = Math.random()*1000;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = KoefStorage.deltaPkXX;
					break;
			}
			
			return result;
		}
		
		//кут відкриття дросельних заслінок (фі дроселя)
		public static function getPhiDros(time:Number): Number {
			var result:Number = Math.random()*1000;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = PolyModelsXX.fiDr(getNdv(time));
					break;
			}
			
			return result;
		}
		
		//швидкість КТЗ
		public static function getV(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
	}
}