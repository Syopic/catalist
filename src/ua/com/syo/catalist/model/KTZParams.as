package ua.com.syo.catalist.model {
	[Bindable]	
	public class KTZParams	{
		
		// Параметри КТЗ
		public var ktzModel:String = "ЗАЗ-1102 «Таврія»";
		
		public var UI:Number = 3.67;
		public var UII:Number = 2.1;
		public var UIII:Number = 1.36;
		public var UIV:Number = 1.0;
		public var UV:Number = 0.82;
		
		public var Ga:Number = 1045+400;
		public var rk:Number = 0.265;
		public var rd:Number = 0.265;
		public var vMax:Number = 140;
		public var g100km:Number = 6.8;
		public var MkMax:Number = 121.6;
		public var nXXmin:Number = 900;
		public var u0:Number = 4.1;
		public var etaTrans:Number = 0.9;
		public var beta:Number = 1.5;
		public var Idv:Number = 0.1;
		public var IkSum:Number = 2.94;
		public var f0:Number = 0.014;
		public var W:Number = 0.051;
		
		//Constructor
		public function KTZParams() {
			
		}
	}
}