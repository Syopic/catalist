package ua.com.syo.catalist.model.calc {
	import ua.com.syo.catalist.data.CycleData;
	
	public class EconomyVars {
		
		//витрата палива
		public static function getGpal(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
		
		//витрата повітря
		public static function getGpov(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
	}
}