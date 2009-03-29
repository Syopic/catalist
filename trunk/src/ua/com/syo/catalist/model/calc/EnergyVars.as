package ua.com.syo.catalist.model.calc {
	import ua.com.syo.catalist.data.CycleData;
	import ua.com.syo.catalist.data.KoefStorage;
	import ua.com.syo.catalist.model.ModePhase;
	import ua.com.syo.catalist.model.polynoms.PolyModelsNav;
	import ua.com.syo.catalist.model.polynoms.PolyModelsXX;
	import ua.com.syo.catalist.utils.DiffUr;
	
	public class EnergyVars	{
		
		// частота обертання колінчастого валу двигуна
		public static function getNdv(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ": result = KoefStorage.nXXmin; break;
				case "рушання":
				case "розгін-":
					result = getOmega(time) * 30 / Math.PI;
					break;
					
			}
			
			return result;
		}
		
		//кутова швидкість обертання колінвалу
		public static function getOmega(time:Number): Number {
			var result:Number = 0;
			var mf:ModePhase;
			
			switch (CycleData.getMode(time)) {
				case "ХХ": result = getNdv(time) * Math.PI / 30; break;
				case "рушання":	
					mf = CycleData.getModeTime(time);
					result = KoefStorage.nXXmin * Math.PI / 30 + (((KoefStorage.nDvZchep - KoefStorage.nXXmin) * Math.PI ) /( 30 * KoefStorage.koef ))* (time - mf.startTime);
					break;
				case "розгін-":
					mf = CycleData.getModeTime(time);
					var nZchep:Number = omegaZchep(time) * 30 / Math.PI;
					result = omegaZchep(time) + (((KoefStorage.nDvZchep * Math.PI / 30) - omegaZchep(time)) / KoefStorage.koef) * ( time - mf.startTime);
					//result = (KoefStorage.nDvZchep * Math.PI / 30) + ((Math.PI * (nZchep - KoefStorage.nDvZchep)) / (30 * KoefStorage.koef)) * ( time - mf.startTime);
					break;	
			}
			
			return result;
		}
		
		//крутний момент
		public static function getMk(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = 0;
					break;
				case "рушання":
					result = KoefStorage.Idv * ((KoefStorage.nDvZchep - KoefStorage.nXXmin) * Math.PI ) /( 30 * KoefStorage.koef );
					break;
				case "розгін-":
					var Mop:Number = (KoefStorage.Ga * KoefStorage.f0 * KoefStorage.rd * KoefStorage.g * (1 + KoefStorage.A * Math.pow(((omegaZchep(time) * KoefStorage.rd * 3.6) / (KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0)), 2))) / (KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0 * KoefStorage.etaTrans);
					result = (((KoefStorage.nDvZchep * Math.PI / 30) - omegaZchep(time)) / KoefStorage.koef) * KoefStorage.Idv + Mop + iZchep(time) * (CycleData.getAcceleration(time) * KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0 / (KoefStorage.rd * 3.6)) / KoefStorage.etaTrans; 
					break;	
			}
			
			return result;
		}
		
		//розрідження за дросельними заслінками (дельта пека)
		public static function getDeltaPk(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					result = KoefStorage.deltaPkXX;
					break;
				case "розгін-":
					result = PolyModelsNav.deltaPk(time);
					break;	
			}
			
			return result;
		}
		
		//кут відкриття дросельних заслінок (фі дроселя)
		public static function getPhiDros(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = PolyModelsXX.fiDr(getNdv(time));
					break;
				case "рушання":
					result = PolyModelsXX.fiDr(getNdv(time));
					break;
			}
			
			return result;
		}
		
		//швидкість КТЗ
		public static function getV(time:Number): Number {
			var result:Number = 0;
			return result;
		}
		
		/** Diff functions **/
		public static function df1(x:Number, y:Number):Number {
			return getOmega(x);
		}
		
		/** допоміжні ф-ли **/
		
		public static function iZchep(time:Number): Number {
			return (KoefStorage.Ga * Math.pow(KoefStorage.rd, 2) + KoefStorage.IkSum) / (Math.pow(KoefStorage.U[CycleData.getU(time)], 2) * Math.pow(KoefStorage.u0, 2))
		}
		public static function omegaZchep(time:Number): Number {
			return CycleData.getSpeed(time) * KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0 / (KoefStorage.rd * 3.6);
		}
	}
}