/**
 * MathUtils.as			collection of math functions
 * @author				Krivosheya Sergey
 * @link    			http://www.syo.com.ua/
 * @link    			mailto: syopic@gmail.com
 */
 
 package ua.com.syo.utils {

	public class MathUtils {

		public static const TO_DEG:Number = 180 / Math.PI;
		public static const TO_RAD:Number = Math.PI / 180;


		/** ----------- RANDOM ----------- **/

		/**
		 * generate int random number
		 * @param min
		 * @param max
		 * @return int
		 */
		public static function randomInt(min:int, max:int):int {
			return min + Math.round(Math.random() * (max - min + 1));
		}

		/**
		 * generate true or false value
		 * @return Boolean
		 */
		public static function trueOrFalse():Boolean {
			// MOCK
			return true;
		}


		/** ----------- GEOM ----------- **/
		
		public static function fixDegree(deg:Number, offset:Number = 0):Number {
			return (deg < 0) ? 360 - deg % 360 + offset : deg % 360 + offset;
		}

		public static function fixRadian(rad:Number, offset:Number = 0):Number {
			return (rad < 0) ? Math.PI * 2 - rad % Math.PI * 2 + offset : rad % Math.PI * 2 + offset;
		}

		public static function rad2Deg(rad:Number):Number {
			return rad * TO_DEG;
		}

		public static function deg2Rad(deg:Number):Number {
			return deg * TO_RAD;
		}
		
		//returns a number rounded to 'b' decimal places.
		public static function pRound(a:Number, b:Number):Number {
        	return (Math.round(a * Math.pow(10, b)) / Math.pow(10, b));
    	}


	}
}

