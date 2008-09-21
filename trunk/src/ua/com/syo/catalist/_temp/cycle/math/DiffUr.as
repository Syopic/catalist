package ua.com.syo.catalist.cycle.math
{
	public class DiffUr
	{
		public static function rungeKutta(x:Number, y:Number, x1:Number, n:int, f:Function): Number
		{
		    var result:Number=0;
		    var  i:Number;
		    var  h:Number;
		    var  y1:Number;
		    var  k1:Number;
		    var  k2:Number;
		    var  k3:Number;
		    
		    h = (x1-x)/n;
		    y1 = y;
		    i = 1;
		    
		    do
   			{
		        k1 = h*f(x, y);
		        x = x+h/2;
		        y = y1+k1/2;
		        k2 = f(x, y)*h;
		        y = y1+k2/2;
		        k3 = f(x, y)*h;
		        x = x+h/2;
		        y = y1+k3;
		        y = y1+(k1+2*k2+2*k3+f(x, y)*h)/6;
		        y1 = y;
		        i = i+1;
		    }
		    while(i<=n);
		    result=y;
			return result;
		}
	}
}