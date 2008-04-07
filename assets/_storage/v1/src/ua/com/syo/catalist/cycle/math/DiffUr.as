package ua.com.syo.catalist.cycle.math
{
	import mx.core.Application;
	
	public class DiffUr
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
	}
}