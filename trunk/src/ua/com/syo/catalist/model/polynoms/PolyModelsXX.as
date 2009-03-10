package ua.com.syo.catalist.model.polynoms {
	public class PolyModelsXX {
		
		public static function setCurrentModes(currentCycleMode:String, currentFuel:String, currentMode:String):void {
			PolyKoef.currentCycleMode = currentCycleMode;
			PolyKoef.currentFuel = currentFuel;
			PolyKoef.currentMode = currentMode;
		}
		
		public static function Gpal(nd:Number):Number {
			var result:Number;
			
			var A0 = PolyKoef.getP("A0", "Gпал");
			var A1 = PolyKoef.getP("A1", "Gпал");
			var A11 = PolyKoef.getP("A11", "Gпал");
			
			return A0 + A1 * nd + A11 * nd * nd;
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
		
		public static function FIDR(nd:Number):Number {
			var result:Number;
			
			return result;
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