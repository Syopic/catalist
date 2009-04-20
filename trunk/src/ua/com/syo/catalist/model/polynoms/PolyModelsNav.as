package ua.com.syo.catalist.model.polynoms {
	import ua.com.syo.catalist.data.KoefStorage;
	import ua.com.syo.catalist.model.calc.EconomyVars;
	import ua.com.syo.catalist.model.calc.EnergyVars;
	
	public class PolyModelsNav {
		
		public static function setCurrentModes(currentCycleMode:String, currentFuel:String, currentMode:String):void {
			PolyKoef.currentCycleMode = currentCycleMode;
			PolyKoef.currentFuel = currentFuel;
			PolyKoef.currentMode = currentMode;
		}
		
		public static function Gpal(time:Number):Number {
			setCurrentModes("load", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", "Gпал");
			var A1:Number = PolyKoef.getP("A1", "Gпал");
			var A2:Number = PolyKoef.getP("A2", "Gпал");
			var A11:Number = PolyKoef.getP("A11", "Gпал");
			var A22:Number = PolyKoef.getP("A22", "Gпал");
			var A12:Number = PolyKoef.getP("A12", "Gпал");
			var A111:Number = PolyKoef.getP("A111", "Gпал");
			var A222:Number = PolyKoef.getP("A222", "Gпал");
			
			var nd:Number = EnergyVars.getNdv(time);
			var dPk:Number = EnergyVars.getDeltaPk(time);
			
			return A0 + A1 * nd + A2 * dPk  + A11 * Math.pow(nd, 2) + A22 * Math.pow(dPk, 2) + A12 * nd * dPk + A111 * Math.pow(nd, 3) + A222 * Math.pow(dPk, 3);
		}
		
		public static function Gpov(time:Number):Number {
			setCurrentModes("load", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", "Gпов");
			var A1:Number = PolyKoef.getP("A1", "Gпов");
			var A11:Number = PolyKoef.getP("A11", "Gпов");
			
			var nd:Number = EnergyVars.getNdv(time);
			
			return A0 + A1 * nd + A11 * nd * nd;
		}
		
		public static function CO(time:Number):Number {
			setCurrentModes("load", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", "CO");
			var A1:Number = PolyKoef.getP("A1", "CO");
			var A2:Number = PolyKoef.getP("A2", "CO");
			var A11:Number = PolyKoef.getP("A11", "CO");
			var A22:Number = PolyKoef.getP("A22", "CO");
			var A12:Number = PolyKoef.getP("A12", "CO");
			
			var nd:Number = EnergyVars.getNdv(time);
			var deltaPk:Number = Math.abs(EnergyVars.getDeltaPk(time));
			
			return A0 + A1 * nd + A2 * deltaPk  + A11 * Math.pow(nd, 2) + A22 * Math.pow(deltaPk, 2) + A12 * nd * deltaPk;
		}
		
		public static function CO2(time:Number):Number {
			setCurrentModes("load", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", "CO2");
			var A1:Number = PolyKoef.getP("A1", "CO2");
			var A2:Number = PolyKoef.getP("A2", "CO2");
			var A11:Number = PolyKoef.getP("A11", "CO2");
			var A22:Number = PolyKoef.getP("A22", "CO2");
			var A12:Number = PolyKoef.getP("A12", "CO2");
			
			var nd:Number = EnergyVars.getNdv(time);
			var deltaPk:Number = Math.abs(EnergyVars.getDeltaPk(time));
			
			return A0 + A1 * nd + A2 * deltaPk  + A11 * Math.pow(nd, 2) + A22 * Math.pow(deltaPk, 2) + A12 * nd * deltaPk;
		}
		
		public static function CH(time:Number):Number {
			setCurrentModes("load", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", "HCs");
			var A1:Number = PolyKoef.getP("A1", "HCs");
			var A2:Number = PolyKoef.getP("A2", "HCs");
			var A11:Number = PolyKoef.getP("A11", "HCs");
			var A22:Number = PolyKoef.getP("A22", "HCs");
			var A12:Number = PolyKoef.getP("A12", "HCs");
			
			var nd:Number = EnergyVars.getNdv(time);
			var deltaPk:Number = Math.abs(EnergyVars.getDeltaPk(time));
			
			return A0 + A1 * nd + A2 * deltaPk  + A11 * Math.pow(nd, 2) + A22 * Math.pow(deltaPk, 2) + A12 * nd * deltaPk;
		}
		
		public static function NOX(time:Number):Number {
			setCurrentModes("load", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", "NOx");
			var A1:Number = PolyKoef.getP("A1", "NOx");
			var A2:Number = PolyKoef.getP("A2", "NOx");
			var A11:Number = PolyKoef.getP("A11", "NOx");
			var A22:Number = PolyKoef.getP("A22", "NOx");
			var A12:Number = PolyKoef.getP("A12", "NOx");
			
			var nd:Number = EnergyVars.getNdv(time);
			var deltaPk:Number = EnergyVars.getDeltaPk(time);
			
			return A0 + A1 * nd + A2 * deltaPk  + A11 * Math.pow(nd, 2) + A22 * Math.pow(deltaPk, 2) + A12 * nd * deltaPk;
		}
		
		public static function O2(time:Number):Number {
			setCurrentModes("load", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", "O2");
			var A1:Number = PolyKoef.getP("A1", "O2");
			var A2:Number = PolyKoef.getP("A2", "O2");
			var A11:Number = PolyKoef.getP("A11", "O2");
			var A22:Number = PolyKoef.getP("A22", "O2");
			var A12:Number = PolyKoef.getP("A12", "O2");
			var A111:Number = PolyKoef.getP("A111", "O2");
			var A222:Number = PolyKoef.getP("A222", "O2");
			
			var nd:Number = EnergyVars.getNdv(time);
			var dPk:Number = EnergyVars.getDeltaPk(time);
			
			return A0 + A1 * nd + A2 * dPk  + A11 * Math.pow(nd, 2) + A22 * Math.pow(dPk, 2) + A12 * nd * dPk + A111 * Math.pow(nd, 3) + A222 * Math.pow(dPk, 3);
		}
		
		public static function GCO(nd:Number, time:Number):Number {
			var t:Number = CO(nd);
			var t2:Number = EconomyVars.getMvgS(time);
			var result:Number = (KoefStorage.muCO * CO(nd) * EconomyVars.getMvgS(time)) / 100;
			
			return (KoefStorage.muCO * CO(nd) * EconomyVars.getMvgS(time)) / 100;
		}
		
		public static function GCO2(nd:Number, time:Number):Number {
			var result:Number = (KoefStorage.muCO2 * CO2(nd) * EconomyVars.getMvgS(time)) / 100;
			
			return result;
		}
		
		public static function GCH(nd:Number, time:Number):Number {
			var result:Number = (KoefStorage.muCH * CH(nd) * EconomyVars.getMvgS(time)) / 1000000;
			
			return result;
		}
		
		public static function GNOX(nd:Number, time:Number):Number {
			var result:Number = (KoefStorage.muNOX * NOX(nd) * EconomyVars.getMvgV(time)) / 1000000;
			
			return result;
		}
		
		public static function GO2(nd:Number, time:Number):Number {
			var result:Number = (KoefStorage.muNOX * NOX(nd) * EconomyVars.getMvgV(time)) / 100;
			
			return result;
		}
		
		public static function fiDr(time:Number):Number {
			setCurrentModes("load", PolyKoef.currentFuel, PolyKoef.currentMode);
			var A0:Number = PolyKoef.getP("A0", "phiDros");
			var A1:Number = PolyKoef.getP("A1", "phiDros");
			var A2:Number = PolyKoef.getP("A2", "phiDros");
			var A11:Number = PolyKoef.getP("A11", "phiDros");
			var A22:Number = PolyKoef.getP("A22", "phiDros");
			var A12:Number = PolyKoef.getP("A12", "phiDros");
			var A111:Number = PolyKoef.getP("A111", "phiDros");
			var A222:Number = PolyKoef.getP("A222", "phiDros");
			
			var nd:Number = EnergyVars.getNdv(time);
			var Mk:Number = EnergyVars.getMk(time);
			
			return A0 + A1 * nd + A2 * Mk  + A11 * Math.pow(nd, 2) + A22 * Math.pow(Mk, 2) + A12 * nd * Mk + A111 * Math.pow(nd, 3) + A222 * Math.pow(Mk, 3);
		}
		
		public static function deltaPk(time:Number):Number {
			setCurrentModes("load", PolyKoef.currentFuel, PolyKoef.currentMode);
			var result:Number;
			
			var A0:Number = PolyKoef.getP("A0", "dPk");
			var A1:Number = PolyKoef.getP("A1", "dPk");
			var A2:Number = PolyKoef.getP("A2", "dPk");
			var A11:Number = PolyKoef.getP("A11", "dPk");
			var A22:Number = PolyKoef.getP("A22", "dPk");
			var A12:Number = PolyKoef.getP("A12", "dPk");
			var A111:Number = PolyKoef.getP("A111", "dPk");
			var A222:Number = PolyKoef.getP("A222", "dPk");
			
			var nd:Number = EnergyVars.getNdv(time);
			var Mk:Number = EnergyVars.getMk(time);
			
			return A0 + A1 * nd + A2 * Mk  + A11 * Math.pow(nd, 2) + A22 * Math.pow(Mk, 2) + A12 * nd * Mk + A111 * Math.pow(nd, 3) + A222 * Math.pow(Mk, 3);
		}
		
	}
}