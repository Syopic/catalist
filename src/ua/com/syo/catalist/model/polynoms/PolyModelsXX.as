package ua.com.syo.catalist.model.polynoms {
	public class PolyModelsXX {
		
		public static function setCurrentModes(currentCycleMode:String, currentFuel:String, currentMode:String):void {
			PolyKoef.currentCycleMode = currentCycleMode;
			PolyKoef.currentFuel = currentFuel;
			PolyKoef.currentMode = currentMode;
		}
		
		public static function Gpal(nd:Number):Number {
			var result:Number;
			
			var B0:Number = PolyKoef.getP("A0", "Gпал");
			var B1:Number = PolyKoef.getP("A1", "Gпал");
			var B11:Number = PolyKoef.getP("A11", "Gпал");
			result = B0 + B1 * nd + B11 * nd * nd;
			return result;
		}
		
		public static function Gpov(nd:Number):Number {
			var result:Number;
			
			return result;
		}
		
		public static function CO(nd:Number):Number {
			var result:Number;
			
			return result;
		}
		
		public static function CO2(nd:Number):Number {
			var result:Number;
			
			return result;
		}
		
		public static function CH(nd:Number):Number {
			var result:Number;
			
			return result;
		}
		
		public static function NOX(nd:Number):Number {
			var result:Number;
			
			return result;
		}
		
		public static function fiDr(nd:Number):Number {
			var A0:Number = 1.29399;
			var A1:Number = 0.00332;
			
			return A0 + A1 * nd;
		}
		
		public static function deltaPk(nd:Number):Number {
			var result:Number;
			
			return result;
		}
		
		public static function alpha(nd:Number):Number {
			var result:Number;
			
			return result;
		}
		
	}
}