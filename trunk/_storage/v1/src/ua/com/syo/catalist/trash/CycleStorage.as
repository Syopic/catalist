package ua.com.syo.catalist.data
{
	import mx.core.Application;
	import mx.core.TextFieldAsset;
	import mx.controls.TextArea;
	import mx.controls.Alert;
	import ua.com.syo.catalist.calc.CalEnergyVars;
	import ua.com.syo.catalist.calc.CalcDiffUr;
	import ua.com.syo.catalist.calc.CalcMainCycle;
	import ua.com.syo.catalist.data.storage.KoefStorage;
	
	public class CycleStorage
	{
		//змінні
	    public static var pointsNum:Number;
	    //масив для часових точок
	    public static var timePoint_array:Array = new Array();
	    //масив для точок швидкості
	    public static var speedPoint_array:Array = new Array();
	    //масив для точок прискорення
	    public static var accelerationPoint_array:Array = new Array();
	    //масив для точок пройденого шляху
	    public static var distancePoint_array:Array = new Array();
	    //масив для режимів
		public static var modePoint_array:Array = new Array();
		
		//масив для крутний момент в усталеному режимі
		public static var MkUst_array:Array = new Array();
		
		
		
		//масив для передач
		public static var uPoint_array:Array = new Array();
		
		//частота обертання колінчастого валу двигуна в одиницю часу
		public static var nDv_array:Array = new Array();
		
		//частота обертання зчеплення
		public static var nZchep_array:Array = new Array();
	    
	    //
		public static function parseXML(xml:XML): void
		{
			var xml_l:Number = xml.children().length(); 
	    
	        for (var i:Number = 0; i<xml_l; i++) {
	            timePoint_array[i] = xml.children()[i].localName();
	            speedPoint_array[i] = xml.children()[i].attribute("speed");
	            accelerationPoint_array[i] = xml.children()[i].attribute("acceleration");
	            modePoint_array[i] = xml.children()[i].attribute("mode");
				uPoint_array[i] = xml.children()[i].attribute("u");
	            //
	        }
	        //
	        pointsNum = timePoint_array[xml_l-1];
	        for (i = 0; i<=pointsNum; i++) {
	            if (i>0) {
	               	distancePoint_array[i] = distancePoint_array[i-1];
	            } else {
	                distancePoint_array[i] = 0;
	            }
	            if (getAcceleration(i) == 0) {
	            	//Application.application["outputTxt"].text+="time: "+i+" - "+getAcceleration(i)+"\n";
	            	//outputTxt.text+="dwe";
	                distancePoint_array[i] += getSpeed(i);
	            } else {
	                distancePoint_array[i] += Math.abs(getAcceleration(i));
	            }
	        }
	        
	        distancePoint_array[pointsNum] = distancePoint_array[pointsNum-1];
	      	calcNDv();
	       // outputTxt.text=xml.toString();
        }
        //заповнення масиву (частота обертання колінчастого валу двигуна в одиницю часу)
		public static function calcNDv():void {
			for (var j:Number=0; j<pointsNum; j++)
    		{
    			nDv_array[j]=CalEnergyVars.getNdv(j);
    			//Application.application["outputTxt"].text+="Ndv: "+nDv_array[j]+"\n";
    		}
    		
    		var tRozg:Number=0;
    		
    		for (var i:Number=0; i<pointsNum; i++)
    		{
    			if (CycleStorage.getMode(i)=="розгін")
    			{
    				tRozg++;
    				var prevNDv:Number=nDv_array[i-1];
    				//Application.application["outputTxt"].text+=prevNDv+"\n";
    				var prevnZchep:Number=nZchep_array[i-1];
    				
    				// рушання
    				if (prevNDv<KoefStorage.nDvZchep)
    				{
    					CycleStorage.setMode(i-1, "рушання");
    					nDv_array[i]=CalcDiffUr.rungeKutta(i-1, prevNDv, i, 100, CalcDiffUr.fRushannya);
    					//Application.application["outputTxt"].text+=nDv_array[i]+"\n";
    					nZchep_array[i]=0;
    				}
    				else
    				{
	    				// розгін с пробуксовуючим зчепленням
	    				if (prevNDv<prevnZchep)
	    				{
	    						CycleStorage.setMode(i-1, "розгін.-");
	    						nZchep_array[i]=CalcDiffUr.rungeKutta(i-1, nZchep_array[i-1], i, 10, CalcDiffUr.fZcheplennya);	    					
	    						
	    						if (tRozg<CalEnergyVars.getTDros(i)){
	    							//триває переміщення дросельних заслінок
	    							nDv_array[i]=CalcDiffUr.rungeKutta(i-1, prevNDv, i, 10, CalcDiffUr.fRozginMinor1);
	    						
	    						}
	    						else
	    						{
	    							//переміщення дросельних заслінок закінчилось
	    							nDv_array[i]=CalcDiffUr.rungeKutta(i-1, prevNDv, i, 10, CalcDiffUr.fRozginMinor2);
	    						}
	    				}
	    				// розгін зі зєднаним зчепленням
	    				else
	    				{
	    					CycleStorage.setMode(i-1, "розгін.+");
	    					
	    					if (tRozg<CalEnergyVars.getTDros(i)){
	    							//триває переміщення дросельних заслінок
	    							nDv_array[i]=CalcDiffUr.rungeKutta(i-1, prevNDv, i, 10, CalcDiffUr.fRozginMajor1);
	    						
    						}
    						else
    						{
    							//переміщення дросельних заслінок закінчилось
    							nDv_array[i]=CalcDiffUr.rungeKutta(i-1, prevNDv, i, 10, CalcDiffUr.fRozginMajor2);
    						}
	    				}
    				}
    			}
    			else
    			{
    				tRozg=0;
    			}
    			//Application.application["outputTxt"].text+="U: "+CalcMainCycle.getU(i)+"\n";
    		}	
    		for (var r:Number=0; r<pointsNum; r++)
    		{
    			Application.application["outputTxt"].text+="Time: "+r+" Mode: "+CycleStorage.getMode(r)+"   nDv: "+nDv_array[r]+"\n";
    		}		
		}
		
        //вертає швидкість
	    public static function getSpeed(time:Number):Number {
	        var speed:Number;
	        //проходимось по всім точкам
	        for (var i:Number = 0; i<timePoint_array.length; i++) {
	            //якщо це відома точка
	            if (time == timePoint_array[i]) {
	                //вертаємо її
	                speed = speedPoint_array[i];
	                break;
	                //якщо вона знаходиться на прямій між відомими
	            } else if (time>timePoint_array[i] && time<timePoint_array[i+1]) {
	                //формула прямої k*time+b;
	                var dt:Number = timePoint_array[i+1]-timePoint_array[i];
	                var ds:Number = speedPoint_array[i+1]-speedPoint_array[i];
	                
	                //
	                var k:Number = ds/dt;
	                var b:Number = speedPoint_array[i]-k*timePoint_array[i];
	                speed = k*time+b;
	                break;
	            }
	        }
	        // 
	        return speed*1000/3600;
	    }
	    //вертає прискорення
	    public static function getAcceleration(time:Number):Number {
	        var acceleration:Number;
	        //проходимось по всім точкам
	        for (var i:Number = 0; i<accelerationPoint_array.length; i++) {
	            //якщо це відома точка
	            if (time == timePoint_array[i]) {
	                //вертаємо її
	                acceleration = accelerationPoint_array[i];
	                break;
	            } else if (time>timePoint_array[i] && time<timePoint_array[i+1]) {
	                acceleration = accelerationPoint_array[i];
	                break;
	            }
	        }
	        //
	        return acceleration;
	    }
	    //вертає пройдений шлях
	    public static function getDistance(time:Number):Number {
	        var distance:Number = 0;
	        var f_t:Number = Math.floor(time);
	        var dt:Number = 1;
	        if (dt>0) {
	            //формула прямої k*time+b;
	            var dd:Number = distancePoint_array[f_t+1]-distancePoint_array[f_t];
	            //
	            
	            var k:Number = dd/dt;
	            
	            var b:Number = distancePoint_array[f_t]-k*f_t;
	            
	            distance = k*time+b;
	            //trace(k*time);
	        } else {
	            distance = distancePoint_array[time];
	        }
	        return distance;
	    }
	    
	    //вертає режим в заданий час
		public static function getMode(time:Number):String {
			var mode:String;
			
				//проходимось по всім точкам
				for (var i:Number = 0; i<modePoint_array.length; i++) {
					//якщо це відома точка
					if (time == timePoint_array[i]) {
						//вертаємо її
						mode = modePoint_array[i];
						break;
					} else if (time>timePoint_array[i] && time<timePoint_array[i+1]) {
						mode = modePoint_array[i];
						break;
					}
				}
			
			
			return mode;
		}
		
		 //задає режим в заданий час
		public static function setMode(time:Number, mode:String):void {
			modePoint_array[time]=mode;
		}
		
		//задає крутний момент в усталеному режимі
		public static function setMkUst(time:Number, mk:Number):void {
			MkUst_array[time]=mk;
		}
		
		//вертає крутний момент в усталеному режимі
		public static function getMkUst(time:Number):Number {
			return MkUst_array[time];
		}
		
		
		//вертає номер передачі
		public static function getU(time:Number):String {
			var u:String;
			//проходимось по всім точкам
			for (var i:Number = 0; i<uPoint_array.length; i++) {
				//якщо це відома точка
				if (time == timePoint_array[i]) {
					//вертаємо її
					u = uPoint_array[i];
					break;
				} else if (time>timePoint_array[i] && time<timePoint_array[i+1]) {
					u = uPoint_array[i];
					break;
				}
			}
			return u;
		}
	}
}