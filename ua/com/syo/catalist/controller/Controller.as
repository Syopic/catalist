package ua.com.syo.catalist.controller
{
	import mx.core.Application;
	import ua.com.syo.catalist.model.Model;
	import ua.com.syo.catalist.view.UIManager;
	import ua.com.syo.catalist.cycle.CycleData;
	
	public class Controller
	{
		private static var instance:Controller;
		
		public static function getInstance(): Controller
		{
			if (!instance)
			{
				instance=new Controller();
			}
			
			return instance;
		}
		
		public function init(): void
		{
			
		}
		
		// run application
		public function run(): void
		{
			UIManager.getInstance().showTopGUI();
			Model.getInstance().loadDataFromXML();
		}
		
		public function onDataLoaded(xml:XML): void
		{
			CycleData.init(xml);
			//tempOutputData();
		}
		
		public function tempOutputData(): void
		{
			for (var i:Number = 0; i<CycleData.getPoinsNum(); i++) 
			{
				Application.application["outputTxt"].text+="time: "+i+"  PhiDros: "+CycleData.getPhiDros(i)+"\n";
			}
		}
	}
}