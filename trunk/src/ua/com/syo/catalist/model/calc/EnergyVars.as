package ua.com.syo.catalist.model.calc {
	import ua.com.syo.catalist.data.CycleData;
	import ua.com.syo.catalist.data.KoefStorage;
	import ua.com.syo.catalist.model.ModePhase;
	import ua.com.syo.catalist.model.polynoms.PolyKoef;
	import ua.com.syo.catalist.model.polynoms.PolyModelsNav;
	import ua.com.syo.catalist.model.polynoms.PolyModelsPXX;
	import ua.com.syo.catalist.model.polynoms.PolyModelsXX;
	import ua.com.syo.utils.MathUtils;
	
	public class EnergyVars	{
		
		// частота обертання колінчастого валу двигуна
		public static function getNdv(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ": 
					result = KoefStorage.nXXmin; 
					break;
				case "рушання":
				case "розгін-":
				case "розгін+":
				case "стала":
				case "упов.+":
				case "упов.-":
				case "перемик.":
					result = getOmega(time) * 30 / Math.PI;
					break;
				
					
			}
			
			return result;
		}
		
		//кутова швидкість обертання колінвалу
		public static function getOmega(time:Number): Number {
			var result:Number = 0;
			var mf:ModePhase = CycleData.getModeTime(time);
			var OmegaTStart:Number;
			var OmegaTEnd:Number;
			var OmegaCycle:Number;
			var nt:Number;
			
			switch (CycleData.getMode(time)) {
				case "ХХ": result = getNdv(time) * Math.PI / 30; break;
				case "рушання":	
					OmegaTStart = KoefStorage.nXXmin * Math.PI / 30;
					OmegaTEnd = KoefStorage.nDvZchep * Math.PI / 30;
					
					result = OmegaTStart + ((OmegaTEnd - OmegaTStart) * (time - mf.startTime)) / (mf.endTime - mf.startTime);
					break;
				case "розгін-":	
				    OmegaTStart = KoefStorage.nDvZchep * Math.PI / 30;
					OmegaTEnd = (CycleData.getSpeed(mf.endTime) * KoefStorage.U[CycleData.getU(mf.endTime)] * KoefStorage.u0) / (KoefStorage.rd * 3.6);
					
					result = OmegaTStart + ((OmegaTEnd - OmegaTStart) * (time - mf.startTime)) / (mf.endTime - mf.startTime);
					break;
				case "розгін+":
					result = (CycleData.getSpeed(time) * KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0) / (KoefStorage.rd * 3.6); 
					break;
				case "стала":
				case "перемик.":
					if (time == 122) { 
						var s:Number = CycleData.getSpeed(time);
						var s2:String = CycleData.getU(time);
						result = CycleData.getSpeed(time) * KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0 / (3.6 * KoefStorage.rd);
					} else {
						result = CycleData.getSpeed(time) * KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0 / (3.6 * KoefStorage.rd);
					}
					break;	
				case "упов.+":	
				    //OmegaTStart = (CycleData.getSpeed(mf.startTime) * KoefStorage.U[CycleData.getU(mf.startTime)] * KoefStorage.u0) / (KoefStorage.rd * 3.6);
				    OmegaTStart = getOmega(mf.startTime - 0.1);
					OmegaTEnd = (CycleData.getSpeed(mf.endTime) * KoefStorage.U[CycleData.getU(mf.endTime)] * KoefStorage.u0) / (KoefStorage.rd * 3.6);
					
					result = OmegaTStart + ((OmegaTEnd - OmegaTStart) * (time - mf.startTime)) / (mf.endTime - mf.startTime);
					nt = result * 30 / Math.PI;
					//OmegaCycle = (CycleData.getSpeed(time) * KoefStorage.U[CycleData.getU(mf.endTime)] * KoefStorage.u0) / (KoefStorage.rd * 3.6);
					/* if (result > OmegaCycle) {
						var Mop:Number = (KoefStorage.Ga * KoefStorage.f0 * KoefStorage.rd * KoefStorage.g * (1 + KoefStorage.A * Math.pow(((omegaZchep(time) * KoefStorage.rd * 3.6) / (KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0)), 2))) / (KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0 * KoefStorage.etaTrans); 
						var Mgalm:Number = (CycleData.getAcceleration(time)* KoefStorage.U[CycleData.getU(mf.endTime)] * KoefStorage.u0) * (KoefStorage.Idv + iZchep(time)) / (KoefStorage.rd * 3.6) + Mop * KoefStorage.etaTrans + PolyModelsPXX.Mk(nt) / KoefStorage.etaTrans;
						result = (CycleData.getSpeed(mf.startTime) * KoefStorage.U[CycleData.getU(mf.endTime)] * KoefStorage.u0) / (KoefStorage.rd * 3.6) - (Mgalm) * (time - mf.startTime) / (KoefStorage.Idv + iZchep(time));
					} */
					break;
				case "упов.-":	
				    OmegaTStart = (CycleData.getSpeed(mf.startTime) * KoefStorage.U[CycleData.getU(mf.endTime)] * KoefStorage.u0) / (KoefStorage.rd * 3.6);
					OmegaTEnd = (CycleData.getSpeed(mf.endTime) * KoefStorage.U[CycleData.getU(mf.endTime)] * KoefStorage.u0) / (KoefStorage.rd * 3.6);
					OmegaCycle = (CycleData.getSpeed(time) * KoefStorage.U[CycleData.getU(mf.endTime)] * KoefStorage.u0) / (KoefStorage.rd * 3.6);
					
					result = OmegaTStart + ((KoefStorage.nXXmin * Math.PI / 30 - OmegaTStart) * (time - mf.startTime)) / (mf.endTime - mf.startTime);
					nt = result * 30 / Math.PI;
					if (nt < KoefStorage.nXXmin) {
						result = KoefStorage.nXXmin * Math.PI / 30;
					}
					break;	
			}
			
			if (result < KoefStorage.nXXmin * Math.PI / 30) {
				result = KoefStorage.nXXmin * Math.PI / 30
			}
			
			return result;
		}
		
		//крутний момент
		public static function getMk(time:Number): Number {
			var result:Number = 0;
			var mf:ModePhase = CycleData.getModeTime(time);
			var OmegaTStart:Number;
			var OmegaTEnd:Number;
			var Mop:Number
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = 0;
					break;
				case "рушання":
			    	OmegaTStart = KoefStorage.nXXmin * Math.PI / 30;
					OmegaTEnd = KoefStorage.nDvZchep * Math.PI / 30;
					
					result = KoefStorage.Idv * (OmegaTEnd - OmegaTStart) / (mf.endTime - mf.startTime);
					break;
				case "розгін-":
					Mop = Math.abs((KoefStorage.Ga * KoefStorage.f0 * KoefStorage.rd * KoefStorage.g * (1 + KoefStorage.A * Math.pow(((omegaZchep(time) * KoefStorage.rd * 3.6) / (KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0)), 2))) / (KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0 * KoefStorage.etaTrans));
					OmegaTStart = KoefStorage.nDvZchep * Math.PI / 30;
					OmegaTEnd = (CycleData.getSpeed(mf.endTime) * KoefStorage.U[CycleData.getU(mf.endTime)] * KoefStorage.u0) / (KoefStorage.rd * 3.6);
					var a:Number = CycleData.getAcceleration(time);
					var z:Number = iZchep(time);
					//result = KoefStorage.Idv * (CycleData.getAcceleration(time) * KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0) / (KoefStorage.rd * 3.6) + Mop + ((OmegaTEnd - OmegaTStart) / (mf.endTime - mf.startTime)) * iZchep(time) / KoefStorage.etaTrans; 
					result = KoefStorage.Idv * (Math.abs(OmegaTEnd - OmegaTStart) / (mf.endTime - mf.startTime)) + Mop + (CycleData.getAcceleration(time) * KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0) / (KoefStorage.rd * 3.6)* iZchep(time) / KoefStorage.etaTrans; 
					break;	
					

				case "розгін+":
					Mop = (KoefStorage.Ga * KoefStorage.f0 * KoefStorage.rd * KoefStorage.g * (1 + KoefStorage.A * Math.pow(((omegaZchep(time) * KoefStorage.rd * 3.6) / (KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0)), 2))) / (KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0 * KoefStorage.etaTrans);
					result = Mop + ((iZchep(time) / KoefStorage.etaTrans + KoefStorage.Idv) * (CycleData.getAcceleration(time) * KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0) / (KoefStorage.rd * 3.6));
					break;	
				case "стала":
					result = (KoefStorage.Ga * KoefStorage.f0 * KoefStorage.rd * KoefStorage.g * (1 + KoefStorage.A * Math.pow(CycleData.getSpeed(time), 2))) / (KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0 * KoefStorage.etaTrans);
					break;	
				case "упов.+":
				case "упов.-":
				case "перемик.":
					result =   (PolyModelsPXX.Mk(time) / KoefStorage.etaTrans);
					break;	
				/* case "перемик.":
					result = -(KoefStorage.Ga * KoefStorage.f0 * KoefStorage.rd * KoefStorage.g * (1 + KoefStorage.A * Math.pow(((omegaZchep(time) * KoefStorage.rd * 3.6) / (KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0)), 2))) / (KoefStorage.U[CycleData.getU(time)] * KoefStorage.u0 * KoefStorage.etaTrans));
					break;	 */
					
			}
			
			return result;
		}
		
		//розрідження за дросельними заслінками (дельта пека)
		public static function getDeltaPk(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
				case "рушання":
					result = KoefStorage.dPkXX;
					break;
				case "розгін-":
				case "розгін+":
				case "стала":
					result = PolyModelsNav.deltaPk(time);
					break;	
				case "упов.+":
				case "упов.-":
				case "перемик.":
					result = PolyModelsPXX.deltaPk(time);
					break;		
			}
			
			return MathUtils.setRestriction(result, 0);
		}
		
		//кут відкриття дросельних заслінок (фі дроселя)
		public static function getPhiDros(time:Number): Number {
			var result:Number = 0;
			
			switch (CycleData.getMode(time)) {
				case "ХХ":
					result = PolyModelsXX.fiDr(time);
					
					break;
				case "рушання":
					result = PolyModelsXX.fiDr(time);
					break;
				case "розгін-":
				case "розгін+":
				case "стала":
					result = PolyModelsNav.fiDr(time);
					break;
				case "упов.+":
				case "упов.-":
				    result = KoefStorage.phiDrosMin;
					break;
				case "перемик.":
					if (PolyKoef.currentFuel == "gasoline") {
						if (PolyKoef.currentMode == "withoutN") {
							result = KoefStorage.phiDrosStalaBW;
						} else {
							result = KoefStorage.phiDrosStalaB;
						}
					} else {
						if (PolyKoef.currentMode == "withoutN") {
							result = KoefStorage.phiDrosStalaGW;
						} else {
							result = KoefStorage.phiDrosStalaG;
						}
					}
					break;			
			}
			
			return MathUtils.setRestriction(result, 0);;
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