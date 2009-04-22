package ua.com.syo.catalist.data {
	public class Globals {
		
		public static var pathToXML:String='_xml/cycleData.xml';
		
		public static var startT:Number = 0;
		public static var endT:Number = 195;
		public static var dT:Number = 0.2;
		public static var roundDecPlaces:int = 3;
		
		public static var integStep:Number = 1;
		
		public static var traceAll:Boolean = false;
		[Bindable]
		public static var dataLoaded:Boolean = false;
	}
}