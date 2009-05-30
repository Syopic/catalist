/**
 * StringUtils.as		collection of string functions
 * @author				Krivosheya Sergey
 * @link    			http://www.syo.com.ua/
 * @link    			mailto: syopic@gmail.com
 */
 
 package ua.com.syo.utils {
 	import ua.com.syo.catalist.data.Globals;
 	

	public class StringUtils {

		//returns a number rounded to 'b' decimal places.
		public static function dotToComma(a:Number):String {
			var result:String = a.toString().replace(".", ",");
        	return result;
    	}
    	
		//returns a number rounded to 'b' decimal places.
		public static function formatForPublish(a:Number):String {
			var result:String = MathUtils.pRound(a, Globals.roundDecPlaces).toString();
			//var result:String = a.toString().replace(".", ",");
        	return result;
    	}


	}
}

