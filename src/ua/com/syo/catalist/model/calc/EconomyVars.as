package ua.com.syo.catalist.model.calc {
	import ua.com.syo.catalist.data.CycleData;
	import ua.com.syo.catalist.data.Globals;
	import ua.com.syo.catalist.data.KoefStorage;
	import ua.com.syo.catalist.model.ModePhase;
	import ua.com.syo.catalist.model.polynoms.PolyKoef;
	import ua.com.syo.catalist.model.polynoms.PolyModelsNav;
	import ua.com.syo.catalist.model.polynoms.PolyModelsPXX;
	import ua.com.syo.catalist.model.polynoms.PolyModelsXX;
	import ua.com.syo.catalist.utils.Integral;
	
	public class EconomyVars {
		
		//витрата палива
		public static function getGpal(time:Number): Number {
			var result:Number = 0;
			var mf:ModePhase;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					mf = CycleData.getModeTime(time);
					result = Integral.rectangleRule(mf.startTime, mf.endTime, Globals.integStep, f1);
					break;
				case "розгін-":
				case "розгін+":
				case "стала":
					mf = CycleData.getModeTime(time);
					result = Integral.rectangleRule(mf.startTime, mf.endTime, Globals.integStep, f3);
				break;
				case "упов.+":
				case "упов.-":
				case "перемик.":
					mf = CycleData.getModeTime(time);
					if (EnergyVars.getNdv(time) >= KoefStorage.nXXmin) {
						result = Integral.rectangleRule(mf.startTime, mf.endTime, Globals.integStep, f4);
					} else {
						result = Integral.rectangleRule(mf.startTime, mf.endTime, Globals.integStep, f1);
					}
				break;
			}
			
			return result;
		}
		
		//витрата повітря
		public static function getGpov(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					var mf:ModePhase = CycleData.getModeTime(time);
					result = Integral.rectangleRule(mf.startTime, mf.endTime, Globals.integStep, f2);
					break;
				case "розгін-":
				case "розгін+":
				case "стала":
					mf = CycleData.getModeTime(time);
					result = Integral.rectangleRule(mf.startTime, mf.endTime, Globals.integStep, f5);
				break;
				case "упов.+":
				case "упов.-":
				case "перемик.":
					mf = CycleData.getModeTime(time);
					
					mf = CycleData.getModeTime(time);
					if (EnergyVars.getNdv(time) >= KoefStorage.nXXmin) {
						result = Integral.rectangleRule(mf.startTime, mf.endTime, Globals.integStep, f6);
					} else {
						result = Integral.rectangleRule(mf.startTime, mf.endTime, Globals.integStep, f2);
					}
				break;	
			}
			
			return result;
		}
		
		//коефіцієнт надміру повітря
		public static function getAlpha(time:Number): Number {
			var result:Number;
			var L0:Number;
			if (PolyKoef.currentFuel == "gas") {
				L0 = KoefStorage.L0gas;
			} else {
				L0 = KoefStorage.L0ben;
				
			}
			result = getGpov(time) / (L0 * getGpal(time));
			
			return result;
		}
		
		//обєм викидуваних газів (сухі)
		public static function getMvgS(time:Number): Number {
			return m1(time) * (m2(time) * getGpal(time) + getGpov(time));
		}
		
		//обєм викидуваних газів (вологі)
		public static function getMvgV(time:Number): Number {
			return m1(time, false) * (m2(time, false) * getGpal(time) + getGpov(time));
		}
		
		private static function m1(time:Number, isSuhi:Boolean = true): Number {
			if (isSuhi) {
				if (getAlpha(time) <= 1) {
					if (PolyKoef.currentFuel == "gasoline") {
						return 0.02259;
					} else {
						return 0.02244;
					}
				} else {
					if (PolyKoef.currentFuel == "gasoline") {
						return 0.03425;
					} else {
						return 0.03423;
					}
				}
			} else {
				if (getAlpha(time) <= 1) {
					if (PolyKoef.currentFuel == "gasoline") {
						return 0.027;
					} else {
						return 0.02704;
					}
				} else {
					if (PolyKoef.currentFuel == "gasoline") {
						return 0.03425;
					} else {
						return 0.03423;
					}
				}
			}
		}
		private static function m2(time:Number, isSuhi:Boolean = true): Number {
			if (isSuhi) {
				if (getAlpha(time) <= 1) {
					if (PolyKoef.currentFuel == "gasoline") {
						return 6.104;
					} else {
						return 6.2746;
					}
				} else {
					if (PolyKoef.currentFuel == "gasoline") {
						return -1.0696;
					} else {
						return -1.3278;
					}
				}
			} else {
				if (getAlpha(time) <= 1) {
					if (PolyKoef.currentFuel == "gasoline") {
						return 5.31;
					} else {
						return 5.882;
					}
				} else {
					if (PolyKoef.currentFuel == "gasoline") {
						return 1.058;
					} else {
						return 1.3272;
					}
				}
			}
		}
		
		/** Integrals functions **/
		public static function f1(x:Number):Number {
			return PolyModelsXX.Gpal(x);
		}
		
		public static function f2(x:Number):Number {
			return PolyModelsXX.Gpov(x);
		}
		
		public static function f3(x:Number):Number {
			return PolyModelsNav.Gpal(x);
		}
		
		public static function f4(x:Number):Number {
			return PolyModelsPXX.Gpal(x);
		}
		
		public static function f5(x:Number):Number {
			return PolyModelsNav.Gpov(x);
		}
		
		public static function f6(x:Number):Number {
			return PolyModelsPXX.Gpov(x);
		}
	}
}