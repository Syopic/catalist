package ua.com.syo.catalist.cycle
{
	import ua.com.syo.catalist.cycle.calc.CalcEnergyVars;
	
	public class CycleData
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
		//масив для режимів2
		public static var modePoint2_array:Array = new Array();
		//масив для передач
		public static var uPoint_array:Array = new Array();
		
		//#################################################
		
		//масив для частоти обертання колінчастого валу двигуна
		public static var NdvPoint_array:Array = new Array();
		//масив для крутного моменту
		public static var MkPoint_array:Array = new Array();
		//масив для розрідження за дросельними заслінками (дельта пека)
		public static var DeltaPkPoint_array:Array = new Array();
		//масив для кута відкриття дросельних заслінок (фі дроселя)
		public static var PhiDrosPoint_array:Array = new Array();
		
		
		
		// unserealize XML
		public static function init(xml:XML): void
		{
			var xml_l:Number = xml.children().length(); 
	        for (var i:Number = 0; i<xml_l; i++) {
	            timePoint_array[i] = xml.children()[i].localName();
	            speedPoint_array[i] = xml.children()[i].attribute("speed");
	            accelerationPoint_array[i] = xml.children()[i].attribute("acceleration");
	            modePoint_array[i] = xml.children()[i].attribute("mode");
				uPoint_array[i] = xml.children()[i].attribute("u");
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
	                distancePoint_array[i] += getSpeed(i);
	            } else {
	                distancePoint_array[i] += Math.abs(getAcceleration(i));
	            }
	        }
	        distancePoint_array[pointsNum] = distancePoint_array[pointsNum-1]; 
	        
	        // init Energy vars
	        CalcEnergyVars.init();
        }
        
		
		//вертає швидкість (m/s)
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
	        return speed*1000/3600;;
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
		
		//кількість точок в циклі (секунд)
		public static function getPoinsNum(): Number
		{
			return pointsNum;
		}
		
		/*Energy vars
		##########################################################################*/
		
		// частота обертання колінчастого валу двигуна
		public static function getNdv(time:Number): Number
		{
			var Ndv:Number=NdvPoint_array[time*10];
			return Ndv;
		}
		
		//вертає крутний момент
		public static function getMk(time:Number): Number
		{
			var Mk:Number=MkPoint_array[time*10];
			return Mk;
		}
		
		//розрідження за дросельними заслінками (дельта пека)
		public static function getDeltaPk(time:Number): Number
		{
			var dPk:Number=DeltaPkPoint_array[time*10];
			return dPk;
		}
		
		//вертає кут відкриття дросельних заслінок (фі дроселя)
		public static function getPhiDros(time:Number): Number
		{
			var phiDros:Number=PhiDrosPoint_array[time*10];;
			return phiDros;
		} 
	}
}