package ua.com.syo.catalist.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import ua.com.syo.catalist.data.CycleData;
	import ua.com.syo.catalist.data.Globals;
	import ua.com.syo.catalist.model.polynoms.PolynomsParser;
	
	public class FileManager extends EventDispatcher {
		
		// The currentFile opened (and saved) by the application
		private var currentFile:File;
		
		// The FileStream object used for reading and writing the currentFile
		private var stream:FileStream = new FileStream();
		
		 // The default directory
		private var defaultDirectory:File;
		
		// Whether the text data has changed (and should be saved)
		public var dataChanged:Boolean = false; 
		
		
		public var currentCycleDataXML:XML;
		
		public function FileManager() {
			defaultDirectory = File.documentsDirectory;
		}
		
		public function showOpenFileDialog():void {
			var fileChooser:File;
			if (currentFile) 
			{
				fileChooser = currentFile;
			}
			else
			{
				//fileChooser = defaultDirectory;
				fileChooser = new File();
			}
			var txtFilter:FileFilter = new FileFilter("Cycle data", "*.xml");
			fileChooser.browseForOpen("Завантажити дані циклу", [txtFilter]);
			fileChooser.addEventListener(Event.SELECT, fileOpenSelectedHandler);
		}
		
		private function fileOpenSelectedHandler(event:Event):void	{
			currentFile = event.target as File;
			stream = new FileStream();
			stream.openAsync(currentFile, FileMode.READ);
			stream.addEventListener(Event.COMPLETE, fileReadHandler);
			//stream.addEventListener(IOErrorEvent.IO_ERROR, readIOErrorHandler);
			dataChanged = false;
			currentFile.removeEventListener(Event.SELECT, fileOpenSelectedHandler);
		}
		
		private function fileReadHandler(event:Event):void {
			var str:String = stream.readUTFBytes(stream.bytesAvailable);
			stream.close();
			var lineEndPattern:RegExp = new RegExp(File.lineEnding, "g");
			//str = str.replace(lineEndPattern, "\n");
			// 
			currentCycleDataXML = new XML(str);
			stream.close();
			
			PolynomsParser.parse(currentCycleDataXML.polynoms);
			
			//var pc:PolynomsCollection = new PolynomsCollection(currentCycleDataXML.polynoms.load.gasoline.withoutNeutralizer.children()[0]);
			//Polynoms.addPolinomsCollection(pc, "gazoline", "withoutNeutralizer");
			
			
			CycleData.parseXML(currentCycleDataXML);
			dispatchEvent(new Event(Event.OPEN));
			Globals.dataLoaded = true;
		}
		
		public function loadDefaultFile(url:String):void {
			var xmlContainer:URLLoader = new URLLoader();
		    xmlContainer.dataFormat = URLLoaderDataFormat.TEXT;
		    xmlContainer.addEventListener(Event.COMPLETE, xmlLoadedHandler);
		    xmlContainer.load(new URLRequest(url));
		}
		
		private function xmlLoadedHandler(e:Event):void {
			currentCycleDataXML = XML(e.currentTarget.data);
			PolynomsParser.parse(currentCycleDataXML.polynoms);
			CycleData.parseXML(currentCycleDataXML);
			dispatchEvent(new Event(Event.OPEN));
		}
		
		public function showSaveDialog():void {
			var fileChooser:File = new File();
			var txtFilter:FileFilter = new FileFilter("Cycle data", "*.xml");
			fileChooser.browseForSave("Зберегти результати обчислень");
		}
		
		public function loadFile(filePath:String):void {
			
		}

	}
}