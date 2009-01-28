package ua.com.syo.catalist.utils {
	public class Integral	{
		//Считается интеграл функции F на отрезке [a,b] с погрешностью 	порядка Epsilon.
		public static function rectangleRule(a:Number, b:Number, epsilon:Number, f:Function): Number {
			var result:Number=0;
	    	var i:int = 0;
	    	var n:int = 0;
	    	var h:Number = 0;
	    	var s1:Number = 0;
	    	var s2:Number = 0;
	
	        n = 1;
	        h = b - a;
	        s2 = h * f((a + b) / 2);
	        do {
	            n = 2 * n;
	            s1 = s2;
	            h = h / 2;
	            s2 = 0;
	            i = 1;
	            do {
	                s2 = s2 + f(a + h / 2 + h * (i - 1));
	                i = i + 1;
	            }
	            while(i <= n);
	            s2 = s2 * h;
	        }
	        
	        while( Math.abs(s2-s1)>3*epsilon );
	        result = s2;
	        
	        return result;
		}
	}
}