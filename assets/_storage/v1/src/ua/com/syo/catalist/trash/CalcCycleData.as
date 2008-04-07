package ua.com.syo.catalist.data.cycle
{
	import ua.com.syo.catalist.calc.CalEnergyVars;
	import ua.com.syo.catalist.data.storage.KoefStorage;
	import ua.com.syo.catalist.calc.DiffUr;
	
	public class CalcCycleData
	{
		
		//частота обертання колінчастого валу двигуна в одиницю часу
		public static var Ndv_array:Array = new Array();
		
		public static function init(): void
		{
			divisionMode();
			fillNdv();
		}
		
		
		public static function fillNdv(): void
		{
			var prevNdv:Number;
			var prevnZchep:Number;
			var tRozg:Number=0;
			
			for (var i:Number = 0; i<MainCycleData.getPoinsNum(); i++) 
			{
				Ndv_array[i]=CalEnergyVars.getNdv(i);
				
				if (MainCycleData.getMode(i)=="розгін")
    			{
    				tRozg++;
    				var prevNDv:Number=Ndv_array[i-1];
    				//trace("prevNdv: "+prevNDv);
    				// рушання
    				if (prevNDv<KoefStorage.nDvZchep)
    				{
    					Ndv_array[i]=DiffUr.rungeKutta(i-1, prevNDv, i, 10, fRushannya);
    				}
    				else
    				{
	    				// розгін с пробуксовуючим зчепленням
	    				if (prevNDv<prevnZchep)
	    				{
	    						
	    						
	    						if (tRozg<CalEnergyVars.getTDros(i)){
	    							//триває переміщення дросельних заслінок
	    							
	    						
	    						}
	    						else
	    						{
	    							//переміщення дросельних заслінок закінчилось
	    							
	    						}
	    				}
	    				// розгін зі зєднаним зчепленням
	    				else
	    				{
	    					
	    				}
    				}
    			}
   			}
		}
		
		public static function getNdv(time:Number): Number
		{
			var Ndv:Number;
           /* //якщо це відома точка
            if (Ndv_array[time]) {
                //вертаємо її
                Ndv = Ndv_array[time];
            } else 
            {
            	var prevKnownNdv:Number;
            	var nextKnownNdv:Number;
            	
            	for (var j:Number=Math.ceil(time-1); j>=0; j--)
            	{
            		if (Ndv_array[Math.ceil(j)])
            		{
            			prevKnownNdv=Math.ceil(j);
            			break;
            		}
            	}
            	
            	for (j=Math.ceil(time); j<MainCycleData.getPoinsNum(); j++)
            	{
            		if (Ndv_array[Math.ceil(j)])
            		{
            			nextKnownNdv=Math.ceil(j);
            			break;
            		}
            	}
            	//формула прямої k*time+b;
                var dt:Number = nextKnownNdv-prevKnownNdv;
                var ds:Number = Ndv_array[nextKnownNdv]-Ndv_array[prevKnownNdv];
                //trace(nextKnownNdv+"____"+prevKnownNdv);
                //
                var k:Number = ds/dt;
                var b:Number = Ndv_array[prevKnownNdv]-k*prevKnownNdv;
                Ndv = k*time+b;
            	
        	}*/
	        Ndv = Ndv_array[time];
	        //
	        return Ndv;
		}
		
		public static function divisionMode(): void
		{
			
		}
		
		//вертає режим в заданий час
		public static function getMode(time:Number):String 
		{
			var mode:String=MainCycleData.getMode(Math.ceil(time));
			//якщо це розгін, то потрібно розділити режим на підрежими
			if (mode=="розгін")
			{
				// TODO
				mode="рушання";
			}
			return mode;
		}
		
		public static function fRushannya(x: Number, y:Number): Number
		{
			//			TODO
			var phiDros:Number=CalEnergyVars.getPhiDros(x);
			var n:Number=y;
			var result:Number;
			var compile:Number;
			
			
			
					
			
			
			
			var _Mk_ust:Number=KoefStorage._a0+KoefStorage._a1*compile;
			
			
			var tOb:Number=60/n;
			trace(n);
			
			// TODO
			var _Mk_neust:Number =_Mk_ust*(1.035-6.6*(tOb/CalEnergyVars.getTDros(x)));
			
			
			
			
			result=_Mk_neust*30/(KoefStorage.Idv*Math.PI);
			
			
			
			return result;
			

		}
	}
}