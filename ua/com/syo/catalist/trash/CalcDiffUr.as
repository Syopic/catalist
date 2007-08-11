package ua.com.syo.catalist.calc
{
	import mx.core.Application;
	import ua.com.syo.catalist.data.storage.KoefStorage;
	import ua.com.syo.catalist.data.CycleStorage;
	
	public class CalcDiffUr
	{
		public static function rungeKutta(x:Number, y:Number, x1:Number, n:int, func:Function): Number
		{
			
		    var result:Number=0;
		    var  i:Number = 0;
		    var  h:Number = 0;
		    var  y1:Number = 0;
		    var  k1:Number = 0;
		    var  k2:Number = 0;
		    var  k3:Number = 0;
		    
		    h = (x1-x)/n;
		    y1 = y;
		    i = 1;
		    
		   
		    while (i<n)
		    {
		    	
		    	k1 = h*func(x, y);
		    	
		        x = x+h/2;
		        y = y1+k1/2;
		        k2 = func(x, y)*h;
		        y = y1+k2/2;
		        k3 = func(x, y)*h;
		        x = x+h/2;
		        y = y1+k3;
		        y = y1+(k1+2*k2+2*k3+func(x, y)*h)/6;
		        y1 = y;
		        i = i+1;
		    }
		    result = y;
		    
			return result;
		}
		
		public static function fRushannya(x: Number, y:Number): Number
		{
//			TODO
			var phiDros:Number=CalEnergyVars.getPhiDros(x);
			
			var n:Number=y;
			
			var result:Number;
			var omega1:Number;
			var omega2:Number;
			var omega3:Number;
			var omega4:Number;
			
			omega1=KoefStorage._a0+KoefStorage._a2*KoefStorage._b0+CalEnergyVars.getNdv(x)*(KoefStorage._a1+KoefStorage._a2*KoefStorage._b1+KoefStorage._a12*KoefStorage._b0)+Math.pow(CalEnergyVars.getNdv(x), 2)*(KoefStorage._a2*KoefStorage._b11+KoefStorage._a12*KoefStorage._b1)+Math.pow(CalEnergyVars.getNdv(x), 3)*(KoefStorage._a2*KoefStorage._b111+KoefStorage._a12*KoefStorage._b11)+Math.pow(CalEnergyVars.getNdv(x), 4)*(KoefStorage._a12*KoefStorage._b111);
			
			omega2=KoefStorage._a2*KoefStorage._b2+CalEnergyVars.getNdv(x)*(KoefStorage._a2*KoefStorage._b12+KoefStorage._a12*KoefStorage._b2)+Math.pow(CalEnergyVars.getNdv(x), 2)*(KoefStorage._a12*KoefStorage._b12);
			
			omega3=(KoefStorage._a2*KoefStorage._b22+CalEnergyVars.getNdv(x)*KoefStorage._a12*KoefStorage._b22)/3;
			
			omega4=(KoefStorage._a2*KoefStorage._b222+CalEnergyVars.getNdv(x)*KoefStorage._a12*KoefStorage._b222)/4;
						
			var _Mk_ust:Number=omega1+omega2*(KoefStorage.phiDrosZch-KoefStorage.phiDrosMin)+omega3*(KoefStorage.phiDrosZch*KoefStorage.phiDrosZch-2*KoefStorage.phiDrosZch*KoefStorage.phiDrosMin+KoefStorage.phiDrosMin*KoefStorage.phiDrosMin)+omega4*(Math.pow(KoefStorage.phiDrosZch, 3)-3*Math.pow(KoefStorage.phiDrosZch, 2)*KoefStorage.phiDrosMin+3*KoefStorage.phiDrosZch*Math.pow(KoefStorage.phiDrosMin, 2)+Math.pow(KoefStorage.phiDrosMin, 3));
			
			
			
			CycleStorage.setMkUst(x, _Mk_ust);
			
			
			var tOb:Number=60/n;
			
			
			
			var _Mk_neust:Number =_Mk_ust*(1.035-6.6*(tOb/CalcMainCycle.getTDros(x)));
			
			//Application.application["outputTxt"].text+=_Mk_neust+"\n";			
			CalEnergyVars.Mk_array[x]=_Mk_neust;
			
			result=_Mk_neust*30/(KoefStorage.Idv*Math.PI);
			
			return result;
		}

		
		// частота обертання зчеплення
		public static function fZcheplennya(x: Number, y:Number): Number
		{
			var n:Number=y;
			
			var result:Number;
			
			result=(CalEnergyVars.getMZchep(x)-CalEnergyVars.getMOporu(x))*30/(CalEnergyVars.getMInercA(x)*Math.PI);
			

			return result;
		}
		
		// триває переміщення дросельних заслінок - 
		public static function fRozginMinor1(x: Number, y:Number): Number
		{
			var phiDros:Number=CalEnergyVars.getPhiDros(x);
			var n:Number=y;
			
			var result:Number;
			
			
			
			var compile:Number;
			
					
			
			
			var _Mk_ust:Number=KoefStorage._a0+KoefStorage._a1*compile;
			CycleStorage.setMkUst(x, _Mk_ust);
			
			var tOb:Number=60/n;
			
			var _Mk_neust:Number =_Mk_ust*(1.035-6.6*(tOb/CalcMainCycle.getTDros(x)));
			CalEnergyVars.Mk_array[x]=_Mk_neust;
			
			result=(_Mk_neust-CalEnergyVars.getMZchep(x))*30/(KoefStorage.Idv*Math.PI);
			
			return result;
		}
		
		// переміщення дросельних заслінок закінчилось - 
		public static function fRozginMinor2(x: Number, y:Number): Number
		{
			var phiDros:Number=CalEnergyVars.getPhiDros(x);
			var n:Number=y;
			
			var result:Number;
			var compile:Number;
			
					
			
			
			var _Mk_ust:Number;
			
			if (phiDros<KoefStorage.phiDrosMax)
			{
				_Mk_ust=KoefStorage._a0+KoefStorage._a1*compile;
			}
			else
			{
				// зовнішня швидкісна характеристика
				_Mk_ust=KoefStorage._f0+KoefStorage._f1*n+KoefStorage._f11*n*n;
			}
			CycleStorage.setMkUst(x, _Mk_ust);
			
			result=(1/(KoefStorage.Idv+KoefStorage.lambda))*(_Mk_ust-CalEnergyVars.getMZchep(x)*30/Math.PI);
			
			return result;
		}
		
		// триває переміщення дросельних заслінок + 
		public static function fRozginMajor1(x: Number, y:Number): Number
		{
			var phiDros:Number=CalEnergyVars.getPhiDros(x);
			var n:Number=y;
			
			var result:Number;
			var compile:Number;
			
					
			
			
			var _Mk_ust:Number=KoefStorage._a0+KoefStorage._a1*compile;
			CycleStorage.setMkUst(x, _Mk_ust);
			
			var tOb:Number=60/n;
			
			var _Mk_neust:Number =_Mk_ust*(1.035-6.6*(tOb/CalcMainCycle.getTDros(x)));
			
			CalEnergyVars.Mk_array[x]=_Mk_neust;
			
			var _MzchepMax:Number=KoefStorage.beta*KoefStorage.MkMax;
			
			
			result=(_Mk_neust-_MzchepMax)*30/(KoefStorage.Idv*Math.PI);
			
			return result;
		}
		
		// переміщення дросельних заслінок закінчилось + 
		public static function fRozginMajor2(x: Number, y:Number): Number
		{
			var phiDros:Number=CalEnergyVars.getPhiDros(x);
			var n:Number=y;
			
			var result:Number;
			var compile:Number;
			
					
			
			
			var _Mk_ust:Number;
			
			if (phiDros<KoefStorage.phiDrosMax)
			{
				_Mk_ust=KoefStorage._a0+KoefStorage._a1*compile;
			}
			else
			{
				// зовнішня швидкісна характеристика
				_Mk_ust=KoefStorage._f0+KoefStorage._f1*n+KoefStorage._f11*n*n;
			}
			
			CycleStorage.setMkUst(x, _Mk_ust);
			
			result=(1/(KoefStorage.Idv+KoefStorage.lambda))*(_Mk_ust-CalEnergyVars.getMZchep(x)*30/Math.PI);
			
			return result;
		}
		
	}
}