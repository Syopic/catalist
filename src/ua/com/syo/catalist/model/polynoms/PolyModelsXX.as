package ua.com.syo.catalist.model.polynoms {
	import ua.com.syo.catalist.data.CycleData;
	import ua.com.syo.catalist.data.KoefStorage;
	import ua.com.syo.catalist.model.calc.EconomyVars;
	import ua.com.syo.catalist.model.calc.EnergyVars;
	
	public class PolyModelsXX {
		
		public static function setCurrentModes(currentCycleMode:String, currentFuel:String, currentMode:String):void {
			PolyKoef.currentCycleMode = currentCycleMode;
			PolyKoef.currentFuel = currentFuel;
			PolyKoef.currentMode = currentMode;
		}
		
		public static function calcPolynom(time:Number, matter:String):Number {
			setCurrentModes("XX", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", matter);
			var A1:Number = PolyKoef.getP("A1", matter);
			var A11:Number = PolyKoef.getP("A11", matter);
			var A111:Number = PolyKoef.getP("A111", matter);
			var A1111:Number = PolyKoef.getP("A1111", matter);
			var A11111:Number = PolyKoef.getP("A11111", matter);
			
			var nd:Number = EnergyVars.getNdv(time);
			
			return A0 + A1 * nd + A11 * nd * nd + A111 * Math.pow(nd, 3) + A1111 * Math.pow(nd, 4) + A11111 * Math.pow(nd, 5);
		}
		
		public static function Gpal(time:Number):Number {
			return calcPolynom(time, "Gпал");
		}
		
		public static function Gpov(time:Number):Number {
			return calcPolynom(time, "Gпов");
		}
		
		public static function CO(time:Number):Number {
			return calcPolynom(time, "CO");
		}
		
		public static function CO2(time:Number):Number {
			return calcPolynom(time, "CO2");
		}
		

		public static function CH(time:Number):Number {
			return calcPolynom(time, "HCs");
		}
		
		public static function NOX(time:Number):Number {
			return calcPolynom(time, "NOx");
		}
		
		public static function O2(time:Number):Number {
			return calcPolynom(time, "O2");
		}
		
		public static function fiDr(time:Number):Number {
			return calcPolynom(time, "phiDros");
		}
		
		/** ******************************************* **/
		
		public static function GCO(time:Number):Number {
			var nd:Number = EnergyVars.getNdv(time);
			var result:Number = (KoefStorage.muCO * CO(nd) * EconomyVars.getMvgS(time)) / 100;
			
			return (KoefStorage.muCO * CO(nd) * EconomyVars.getMvgS(time)) / 100;
		}
		
		public static function GCO2(time:Number):Number {
			var nd:Number = EnergyVars.getNdv(time);
			var result:Number = (KoefStorage.muCO2 * CO2(nd) * EconomyVars.getMvgS(time)) / 100;
			
			return result;
		}
		
		public static function GCH(time:Number):Number {
			var nd:Number = EnergyVars.getNdv(time);
			var result:Number = (KoefStorage.muCH * CH(nd) * EconomyVars.getMvgS(time)) / 1000000;
			
			return result;
		}
		
		public static function GNOX(time:Number):Number {
			var nd:Number = EnergyVars.getNdv(time);
			var result:Number = (KoefStorage.muNOX * NOX(nd) * EconomyVars.getMvgV(time)) / 1000000;
			
			return result;
		}
		
		public static function GO2(time:Number):Number {
			var nd:Number = EnergyVars.getNdv(time);
			var result:Number = (KoefStorage.muO2 * O2(nd) * EconomyVars.getMvgS(time)) / 100;
			
			return result;
		}
		
		
		public static function deltaPk(nd:Number):Number {
			var result:Number;
			// mock
			return result;
		}
		
	}
}