package ua.com.syo.catalist.model.polynoms {
	import ua.com.syo.catalist.data.KoefStorage;
	import ua.com.syo.catalist.model.calc.EconomyVars;
	
	public class PolyModelsXX {
		
		public static function setCurrentModes(currentCycleMode:String, currentFuel:String, currentMode:String):void {
			PolyKoef.currentCycleMode = currentCycleMode;
			PolyKoef.currentFuel = currentFuel;
			PolyKoef.currentMode = currentMode;
		}
		
		public static function Gpal(nd:Number):Number {
			var A0:Number = PolyKoef.getP("A0", "Gпал");
			var A1:Number = PolyKoef.getP("A1", "Gпал");
			var A11:Number = PolyKoef.getP("A11", "Gпал");
			
			return A0 + A1 * nd + A11 * nd * nd;
		}
		
		public static function Gpov(nd:Number):Number {
			var A0:Number = PolyKoef.getP("A0", "Gпов");
			var A1:Number = PolyKoef.getP("A1", "Gпов");
			var A11:Number = PolyKoef.getP("A11", "Gпов");
			
			return A0 + A1 * nd + A11 * nd * nd;
		}
		
		public static function CO(nd:Number):Number {
			var A0:Number = PolyKoef.getP("A0", "CO");
			var A1:Number = PolyKoef.getP("A1", "CO");
			var A11:Number = PolyKoef.getP("A11", "CO");
			var A111:Number = PolyKoef.getP("A111", "CO");
			
			return A0 + A1 * nd + A11 * nd * nd + A111 * Math.pow(nd, 3);
		}
		
		public static function CO2(nd:Number):Number {
			var A0:Number = PolyKoef.getP("A0", "CO2");
			var A1:Number = PolyKoef.getP("A1", "CO2");
			var A11:Number = PolyKoef.getP("A11", "CO2");
			var A111:Number = PolyKoef.getP("A111", "CO2");
			
			return A0 + A1 * nd + A11 * nd * nd + A111 * Math.pow(nd, 3);
		}
		
		public static function CH(nd:Number):Number {
			var A0:Number = PolyKoef.getP("A0", "HCs");
			var A1:Number = PolyKoef.getP("A1", "HCs");
			var A11:Number = PolyKoef.getP("A11", "HCs");
			var A111:Number = PolyKoef.getP("A111", "HCs");
			var A1111:Number = PolyKoef.getP("A1111", "HCs");
			var A11111:Number = PolyKoef.getP("A11111", "HCs");

			return A0 + A1 * nd + A11 * nd * nd + A111 * Math.pow(nd, 3) + A1111 * Math.pow(nd, 4) + A11111 * Math.pow(nd, 5);
		}
		
		public static function NOX(nd:Number):Number {
			var A0:Number = PolyKoef.getP("A0", "NOx");
			var A1:Number = PolyKoef.getP("A1", "NOx");
			var A11:Number = PolyKoef.getP("A11", "NOx");
			
			return A0 + A1 * nd + A11 * nd * nd;
		}
		
		public static function GCO(nd:Number):Number {
			var t:Number = EconomyVars.getMvgS(nd);
			return KoefStorage.muCO * CO(nd) * EconomyVars.getMvgS(nd) / 100;
		}
		
		public static function GCO2(nd:Number):Number {
			// TODO
			var result:Number = CO(nd) / 100 * KoefStorage.muCO;
			
			return result;
		}
		
		public static function GCH(nd:Number):Number {
			var result:Number;
			
			return result;
		}
		
		public static function GNOX(nd:Number):Number {
			var result:Number;
			
			return result;
		}
		
		public static function fiDr(nd:Number):Number {
			var A0:Number = PolyKoef.getP("A0", "phiDros");
			var A1:Number = PolyKoef.getP("A1", "phiDros");
			
			return A0 + A1 * nd;
		}
		
		public static function deltaPk(nd:Number):Number {
			var result:Number;
			// mock
			return result;
		}
		
	}
}