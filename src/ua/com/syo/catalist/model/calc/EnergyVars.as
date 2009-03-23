package ua.com.syo.catalist.model.calc {
	import ua.com.syo.catalist.data.CycleData;
	
	public class EnergyVars	{
		
		// частота обертання колінчастого валу двигуна
		public static function getNdv(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
		
		//кутова швидкість обертання колінвалу
		public static function getOmega(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
		
		//крутний момент
		public static function getMk(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
		
		//розрідження за дросельними заслінками (дельта пека)
		public static function getDeltaPk(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
		
		//кут відкриття дросельних заслінок (фі дроселя)
		public static function getPhiDros(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
		
		//швидкість КТЗ
		public static function getV(time:Number): Number {
			var result:Number = Math.random()*1000;
			return result;
		}
	}
}