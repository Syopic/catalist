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
		
		public static function Gpal(time:Number):Number {
			setCurrentModes("XX", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", "Gпал");
			var A1:Number = PolyKoef.getP("A1", "Gпал");
			var A11:Number = PolyKoef.getP("A11", "Gпал");
			
			var nd:Number = EnergyVars.getNdv(time);
			
			return A0 + A1 * nd + A11 * nd * nd;
		}
		
		public static function Gpov(time:Number):Number {
			setCurrentModes("XX", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", "Gпов");
			var A1:Number = PolyKoef.getP("A1", "Gпов");
			var A11:Number = PolyKoef.getP("A11", "Gпов");
			
			var nd:Number = EnergyVars.getNdv(time);
			
			return A0 + A1 * nd + A11 * nd * nd;
		}
		
		public static function CO(time:Number):Number {
			setCurrentModes("XX", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", "CO");
			var A1:Number = PolyKoef.getP("A1", "CO");
			var A11:Number = PolyKoef.getP("A11", "CO");
			var A111:Number = PolyKoef.getP("A111", "CO");
			
			var nd:Number = EnergyVars.getNdv(time);
			
			return A0 + A1 * nd + A11 * nd * nd + A111 * Math.pow(nd, 3);
		}
		
		public static function CO2(time:Number):Number {
			setCurrentModes("XX", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", "CO2");
			var A1:Number = PolyKoef.getP("A1", "CO2");
			var A11:Number = PolyKoef.getP("A11", "CO2");
			var A111:Number = PolyKoef.getP("A111", "CO2");
			
			var nd:Number = EnergyVars.getNdv(time);
			
			return A0 + A1 * nd + A11 * nd * nd + A111 * Math.pow(nd, 3);
		}
		
		public static function CH(time:Number):Number {
			setCurrentModes("XX", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", "HCs");
			var A1:Number = PolyKoef.getP("A1", "HCs");
			var A11:Number = PolyKoef.getP("A11", "HCs");
			var A111:Number = PolyKoef.getP("A111", "HCs");
			var A1111:Number = PolyKoef.getP("A1111", "HCs");
			var A11111:Number = PolyKoef.getP("A11111", "HCs");
			
			var nd:Number = EnergyVars.getNdv(time);
			
			return A0 + A1 * nd + A11 * nd * nd + A111 * Math.pow(nd, 3) + A1111 * Math.pow(nd, 4) + A11111 * Math.pow(nd, 5);
		}
		
		public static function NOX(time:Number):Number {
			setCurrentModes("XX", PolyKoef.currentFuel, PolyKoef.currentMode);
			
			var A0:Number = PolyKoef.getP("A0", "NOx");
			var A1:Number = PolyKoef.getP("A1", "NOx");
			var A11:Number = PolyKoef.getP("A11", "NOx");
			var A111:Number = PolyKoef.getP("A111", "NOx");
			var A1111:Number = PolyKoef.getP("A1111", "NOx");
			var A11111:Number = PolyKoef.getP("A11111", "NOx");

			var nd:Number = EnergyVars.getNdv(time);
			
			return A0 + A1 * nd + A11 * nd * nd + A111 * Math.pow(nd, 3) + A1111 * Math.pow(nd, 4) + A11111 * Math.pow(nd, 5);
		}
		
		public static function O2(time:Number):Number {
			setCurrentModes("XX", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", "O2");
			var A1:Number = PolyKoef.getP("A1", "O2");
			var A11:Number = PolyKoef.getP("A11", "O2");
			
			var nd:Number = EnergyVars.getNdv(time);
			
			return A0 + A1 * nd + A11 * nd * nd;
		}
		
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
		
		public static function fiDr(nd:Number):Number {
			setCurrentModes("XX", PolyKoef.currentFuel, PolyKoef.currentMode);
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