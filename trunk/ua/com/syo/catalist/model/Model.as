package ua.com.syo.catalist.model
{
	import ua.com.syo.catalist.data.storage.GlobalStorage;
	import ua.com.syo.catalist.controller.Controller;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	public class Model
	{
		private static var instance:Model;
		
		public var myLoader:URLLoader;
		
		public static function getInstance(): Model
		{
			if (!instance)
			{
				instance=new Model();
			}
			
			return instance;
		}
		
		public function init(): void
		{
			
		}
		
		// load XML
		public function loadDataFromXML(): void
		{
			//загрузка зовнішніх даних
		    var myXMLURL:URLRequest = new URLRequest(GlobalStorage.pathToXML);
			this.myLoader = new URLLoader(myXMLURL);
		    myLoader.addEventListener("complete", xmlLoaded);
		}
		
		// xml loaded
		public function xmlLoaded(evtObj:Event):void 
		{ 
		    Controller.getInstance().onDataLoaded(XML(myLoader.data));
		}
	}
}