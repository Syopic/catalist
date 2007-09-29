package ua.com.syo.catalist.calc
{
	import ua.com.syo.catalist.data.storage.KoefStorage;
	import ua.com.syo.catalist.data.CycleStorage;
	import mx.core.Application;
	import ua.com.syo.catalist.data.cycle.CalcCycleData;
	import ua.com.syo.catalist.data.cycle.MainCycleData;
	
	public class CalEnergyVars
	{
		
		public static var Mk_array:Array=new Array();
		
		//вертає кут відкриття дросельних заслінок (фі дроселя)
		public static function getPhiDros(time:Number): Number
		{
			var mode:String = CalcCycleData.getMode(time);
			var phiDros:Number;
			
			switch (mode) {
				//холостий хід
			case "ХХ" :
				phiDros = KoefStorage.phiDrosMin;
				break;
				//рушання
			case "рушання" :
				phiDros = KoefStorage.phiDrosMin+KoefStorage.vDros*time;
				break;
				//розгін з пробуксовочним зчепленням
			case "розгін.-" :
				phiDros = KoefStorage.phiDrosMin+KoefStorage.vDros*time;
				if (phiDros>KoefStorage.phiDrosMax)
				{
					phiDros=KoefStorage.phiDrosMax;
				}
				break;
				//розгін зі зєднаним зчепленням
			case "розгін.+" :
				phiDros = KoefStorage.phiDrosMin+KoefStorage.vDros*time;
				if (phiDros>KoefStorage.phiDrosMax)
				{
					phiDros=KoefStorage.phiDrosMax;
				}
				break;
				//стала швидкість
			case "стала" :
				phiDros;
				break;
				//уповільнення зі зєднаним зчепленням
			case "упов.+" :
				phiDros;
				break;
				//уповільнення з розєднаним зчепленням
			case "упов.-" :
				phiDros;
				break;
				//перемикання передач
			case "пoмик." :
				phiDros;
				break;
			}
			
			return phiDros;
		}
		
		//вертає час відкриття дросельних заслінок (те дроселя)
		public static function getTDros(time:Number): Number
		{
			var mode:String = CalcCycleData.getMode(time);
			
			var tDros:Number;
			
			switch (mode) {
				//холостий хід
			case "ХХ" :
				tDros=0;
				break;
				//рушання
			case "рушання" :
				var phiDrosZchep:Number=KoefStorage.C*(KoefStorage.nDvZchep-KoefStorage.nXXmin); 
				tDros=(phiDrosZchep-KoefStorage.phiDrosMin)/KoefStorage.vDros;
				break;
				//розгін з пробуксовочним зчепленням
			case "розгін.-" :
				tDros=(KoefStorage.phiDrosEnd-KoefStorage.phiDrosMin)/KoefStorage.vDros;
				break;
				//розгін зі зєднаним зчепленням
			case "розгін.+" :
				tDros=(KoefStorage.phiDrosEnd-KoefStorage.phiDrosMin)/KoefStorage.vDros;
				break;
				//стала швидкість
			case "стала" :
				tDros=0;
				break;
				//уповільнення зі зєднаним зчепленням
			case "упов.+" :
				tDros=0;
				break;
				//уповільнення з розєднаним зчепленням
			case "упов.-" :
				tDros=0;
				break;
				//перемикання передач
			case "перемик." :
				tDros=0;
				break;
			}
			
			return tDros;;
		}
		
		//розрідження за дросельними заслінками (дельта пека)
		public static function getDeltaPk(time:Number): Number
		{
			var mode:String = CalcCycleData.getMode(time);
			var dPk:Number;
			
			switch (mode) {
				//холостий хід
			case "ХХ" :
				dPk = KoefStorage.dPkXX;
				break;
				//рушання
			case "рушання" :
				dPk;
				break;
				//розгін з пробуксовочним зчепленням
			case "розгін.-" :
				dPk;
				break;
				//розгін зі зєднаним зчепленням
			case "розгін.+" :
				dPk;
				break;
				//стала швидкість
			case "стала" :
				dPk=(CalEnergyVars.getMk(time)-KoefStorage._a0)/KoefStorage._a1;
				break;
				//уповільнення зі зєднаним зчепленням
			case "упов.+" :
				dPk;
				break;
				//уповільнення з розєднаним зчепленням
			case "упов.-" :
				dPk;
				break;
				//перемикання передач
			case "перемик." :
				dPk;
				break;
			}
			
			return dPk;
		}
		
		//вертає крутний момент
		public static function getMk(time:Number): Number
		{
			var mode:String = CalcCycleData.getMode(time);
			var Mk:Number;
			
			switch (mode) {
				//холостий хід
			case "ХХ" :
				Mk = 0;
				break;
				//рушання
			case "рушання" :
				Mk = 0;//TODO
				break;
				//розгін з пробуксовочним зчепленням
			case "розгін.-" :
				Mk = 0;//TODO
				break;
				//розгін зі зєднаним зчепленням
			case "розгін.+" :
				Mk = 0;//TODO
				break;
				//стала швидкість
			case "стала" :
				//
				var l_k:Number=KoefStorage.rd*KoefStorage.g/(KoefStorage.U[MainCycleData.getU(time)]*KoefStorage.u0*KoefStorage.etaTrans);
				//квадрат швидкості
				var l_v2:Number=MainCycleData.getSpeed(time)*MainCycleData.getSpeed(time);
				Mk= (KoefStorage.Ga*(KoefStorage.f1*KoefStorage.cosA*(1+KoefStorage.A*l_v2)+KoefStorage.sinA)+KoefStorage.W*l_v2)*l_k;
				break;
				//уповільнення зі зєднаним зчепленням
			case "упов.+" :
				Mk = 0;//TODO
				break;
				//уповільнення з розєднаним зчепленням
			case "упов.-" :
				Mk = 0;//TODO
				break;
				//перемикання передач
			case "перемик." :
				Mk = 0;//TODO
				break;
			}
			
			return Mk;
		}
		
		// частота обертання колінчастого валу двигуна
		public static function getNdv(time:Number): Number
		{
			var mode:String = CalcCycleData.getMode(time);
			var Ndv:Number;
			
			switch (mode) {
				//холостий хід
			case "ХХ" :
				Ndv = KoefStorage.nXXmin;
				break;
				//рушання
			case "рушання" :
				CycleStorage.nDv_array[time];
				break;
				//розгін з пробуксовочним зчепленням
			case "розгін.-" :
				CycleStorage.nDv_array[time];
				break;
				//розгін зі зєднаним зчепленням
			case "розгін.+" :
				CycleStorage.nDv_array[time];
				break;
				//стала швидкість
			case "стала" :
				Ndv = MainCycleData.getSpeed(time)*KoefStorage.U[MainCycleData.getU(time)]*KoefStorage.u0*30/(Math.PI*KoefStorage.rk);
				break;
				//уповільнення зі зєднаним зчепленням
			case "упов.+" :
				Ndv;
				break;
				//уповільнення з розєднаним зчепленням
			case "упов.-" :
				Ndv;
				break;
				//перемикання передач
			case "перемик." :
				Ndv;
				break;
			}
			
			return Ndv;
		}
		
		// частота обертання зчеплення
		public static function getNZchep(time:Number): Number
		{
			var mode:String = CalcCycleData.getMode(time);
			var nZchep:Number;
			
			switch (mode) {
				//холостий хід
			case "ХХ" :
				nZchep=0;
				break;
				//рушання
			case "рушання" :
				nZchep=0;
				break;
				//розгін з пробуксовочним зчепленням
			case "розгін.-" :
				nZchep;
				break;
				//розгін зі зєднаним зчепленням
			case "розгін.+" :
				nZchep;
				break;
				//стала швидкість
			case "стала" :
				nZchep=getNdv(time);
				break;
				//уповільнення зі зєднаним зчепленням
			case "упов.+" :
				nZchep;
				break;
				//уповільнення з розєднаним зчепленням
			case "упов.-" :
				nZchep;
				break;
				//перемикання передач
			case "перемик." :
				nZchep;
				break;
			}
			
			return nZchep;;
		}
		
		// розрахункова швидкість
		public static function getVRozr(time:Number): Number
		{
			var mode:String = CalcCycleData.getMode(time);
			var vRozr:Number;
			
			switch (mode) {
				//холостий хід
			case "ХХ" :
				vRozr=0;
				break;
				//рушання
			case "рушання" :
				vRozr=0;
				break;
				//розгін з пробуксовочним зчепленням
			case "розгін.-" :
				vRozr=CalEnergyVars.getNZchep(time)*Math.PI*KoefStorage.rk/(KoefStorage.U[MainCycleData.getU(time)]*KoefStorage.u0*30);
				break;
				//розгін зі зєднаним зчепленням
			case "розгін.+" :
				vRozr;
				break;
				//стала швидкість
			case "стала" :
				vRozr=0;
				break;
				//уповільнення зі зєднаним зчепленням
			case "упов.+" :
				vRozr;
				break;
				//уповільнення з розєднаним зчепленням
			case "упов.-" :
				vRozr;
				break;
				//перемикання передач
			case "перемик." :
				vRozr;
				break;
			}
			
			return vRozr;;
		}
		
		// розрахункове прискорення
		public static function getARozr(time:Number): Number
		{
			var mode:String = CalcCycleData.getMode(time);
			var aRozr:Number;
			
			switch (mode) {
				//холостий хід
			case "ХХ" :
				aRozr=0;
				break;
				//рушання
			case "рушання" :
				aRozr=0;
				break;
				//розгін з пробуксовочним зчепленням
			case "розгін.-" :
				aRozr;
				break;
				//розгін зі зєднаним зчепленням
			case "розгін.+" :
				var _pF:Number=KoefStorage.f0*KoefStorage.Ga*KoefStorage.cosA;
				var _pI:Number=KoefStorage.Ga*KoefStorage.sinA;
				var _pW:Number=KoefStorage.W*(Math.pow(MainCycleData.getSpeed(time),2));
				var _delta:Number=1+(KoefStorage.IkSum+KoefStorage.Idv+Math.pow(KoefStorage.U[CycleStorage.getU(time)],2)*Math.pow(KoefStorage.u0,2)*KoefStorage.etaTrans)/(KoefStorage.Ga*Math.pow(KoefStorage.rd,2));
				
				aRozr=1/(_delta*KoefStorage.Ga*(1+(KoefStorage.lambda*Math.pow(KoefStorage.U[CycleStorage.getU(time)],2)*Math.pow(KoefStorage.u0,2)*KoefStorage.etaTrans)/(_delta*KoefStorage.Ga*KoefStorage.rk*KoefStorage.rd)))*(CycleStorage.getMkUst(time)*KoefStorage.U[CycleStorage.getU(time)]*KoefStorage.u0*KoefStorage.etaTrans/KoefStorage.rd-_pF-_pI-_pW);
				break;
				//стала швидкість
			case "стала" :
				aRozr=0;
				break;
				//уповільнення зі зєднаним зчепленням
			case "упов.+" :
				aRozr;
				break;
				//уповільнення з розєднаним зчепленням
			case "упов.-" :
				aRozr;
				break;
				//перемикання передач
			case "перемик." :
				aRozr;
				break;
			}
			
			return aRozr;;
		}
		
		// момент тертя зчеплення
		public static function getMZchep(time:Number): Number
		{
			return KoefStorage.vZchep*time;
		}
		
		// момент опору руху КТЗ
		public static function getMOporu(time:Number): Number
		{
			var mOp:Number=KoefStorage.Ga*(KoefStorage.f0*KoefStorage.cosA+KoefStorage.sinA)*KoefStorage.rd*KoefStorage.g/(KoefStorage.U[MainCycleData.getU(time)]*KoefStorage.u0);
			return mOp;
		}
		
		// момент інерції
		public static function getMInercA(time:Number): Number
		{
			return (KoefStorage.Ga*KoefStorage.rk+KoefStorage.IkSum)/(Math.pow(KoefStorage.U[MainCycleData.getU(time)]*KoefStorage.u0,2));
		}
	}
}