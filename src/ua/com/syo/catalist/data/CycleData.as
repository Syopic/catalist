package ua.com.syo.catalist.data {
	import ua.com.syo.catalist.model.ModePhase;
	
	public class CycleData {
		//масив для часових точок
	    public static var timePointArray:Array = new Array();
	    //масив для точок швидкості
	    public static var speedPointArray:Array = new Array();
	    //масив для точок прискорення
	    public static var accelerationPointArray:Array = new Array();
	    //масив для точок пройденого шляху
	    public static var distancePointArray:Array = new Array();
	    //масив для режимів
		public static var modePointArray:Array = new Array();
		//масив для передач
		public static var uPointArray:Array = new Array();
		
		//
		public static var cycleTimeLength:int = 0;
		
		public static function parseXML(xml:XML):void {
			var xmlLen:Number = xml.child("cycle").children().length(); 
	        for (var i:Number = 0; i < xmlLen; i++) {
	            timePointArray[i] = xml.child("cycle").children()[i].localName();
	            speedPointArray[i] = xml.child("cycle").children()[i].attribute("speed");
            	accelerationPointArray[i] = xml.child("cycle").children()[i].attribute("acceleration");
	            modePointArray[i] = xml.child("cycle").children()[i].attribute("mode");
				uPointArray[i] = xml.child("cycle").children()[i].attribute("u");
	        }
	        cycleTimeLength = timePointArray[timePointArray.length - 1];
	        
		}
		
		//вертає швидкість (m/s)
		// time 1.2 , 1, 34.6 ...
	    public static function getSpeed(time:Number):Number {
	        var result:Number;
	        //проходимось по всім точкам
	        for (var i:Number = 0; i<timePointArray.length; i++) {
	            //якщо це відома точка
	            if (time == timePointArray[i]) {
	                //вертаємо її
	                result = speedPointArray[i];
	                break;
	                //якщо вона знаходиться на прямій між відомими
	            } else if (time > timePointArray[i] && time < timePointArray[i+1]) {
	                //формула прямої k*time+b;
	                var dt:Number = timePointArray[i+1]-timePointArray[i];
	                var ds:Number = speedPointArray[i+1]-speedPointArray[i];
	                
	                //
	                var k:Number = ds/dt;
	                var b:Number = speedPointArray[i] - k * timePointArray[i];
	                result = k * time + b;
	                break;
	            }
	        }
	        // 
	        return result;
	    }
	    
	    //вертає прискорення
	    public static function getAcceleration(time:Number):Number {
	        var result:Number;
	        var dt:Number;
	        var da:Number;
	        var k:Number;
	        var b:Number;
	        //проходимось по всім точкам
	        for (var i:Number = 0; i < accelerationPointArray.length; i++) {
	            //якщо це відома точка
	            if (time == timePointArray[i]) {
                	//вертаємо її
                	result = accelerationPointArray[i];
	                break;
	            } else if (time > timePointArray[i] && time < timePointArray[i + 1]) {
	            	
	            	if (getMode(time) == "розгін-") {
            		//формула прямої k*time+b;
		                dt = timePointArray[i+1]-timePointArray[i];
		                da = accelerationPointArray[i+1] - accelerationPointArray[i];
		                
		                //
		                k = da/dt;
		                b = accelerationPointArray[i] - k * timePointArray[i];
		                result = k * time + b;
	                } else {
	                	result = accelerationPointArray[i];
	                }
	                break;
	            }
	        }
	        //
	        return result;
	    }
	    //вертає пройдений шлях
	    public static function getDistance(time:Number):Number {
	        var result:Number = 0;
	       // var f_t:Number = Math.floor(time);
	        var dt:Number = 1;
	        
	        for (var i:Number = 0; i < (cycleTimeLength * 10); i++) {
	        	if (time > i/10) {
	        		result += getSpeed(i/10)/10;
	        	}
	        }
	        
	        return result;
	    }
	    
	    //вертає режим в заданий час
		public static function getMode(time:Number):String {
			var result:String;
			
				//проходимось по всім точкам
				for (var i:Number = 0; i<modePointArray.length; i++) {
					//якщо це відома точка
					if (time == timePointArray[i]) {
						//вертаємо її
						result = modePointArray[i];
						break;
					} else if (time>timePointArray[i] && time<timePointArray[i+1]) {
						result = modePointArray[i];
						break;
					}
				}
			return result;
		}
		
		//вертає номер передачі
		public static function getU(time:Number):String {
			var result:String;
			//проходимось по всім точкам
			for (var i:Number = 0; i<uPointArray.length; i++) {
				//якщо це відома точка
				if (time == timePointArray[i]) {
					//вертаємо її
					result = uPointArray[i];
					break;
				} else if (time>timePointArray[i] && time<timePointArray[i+1]) {
					result = uPointArray[i];
					break;
				}
			}
			return result;
		}
		
		
		//вертає тривалість (початок, кінець) режиму
		public static function getModeTime(time:Number):ModePhase {
			var result:ModePhase;
			var currentMode:String = getMode(time);
			//проходимось по всім точкам
			for (var i:Number = 0; i < timePointArray.length; i++) {
				if (time >= timePointArray[i] && time <= timePointArray[i+1]) {
					result = new ModePhase(timePointArray[i], timePointArray[i + 1]);
					break;
					//trace("time: " + time + " mode: "+currentMode+" t1: "+timePointArray[i]+" t2: "+timePointArray[i+1])
				}
			}
			
			return result;
		}
	}
}