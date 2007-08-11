import ua.com.syo.catalist.data.*;
import flash.events.*
import flash.net.*
import mx.collections.*;
import mx.events.MenuEvent;
import mx.controls.Alert;
import ua.com.syo.catalist.controller.Controller;
import ua.com.syo.catalist.view.UIManager;
import ua.com.syo.catalist.model.Model;
import mx.controls.Button;
import ua.com.syo.catalist.view.TopMenu;

//
public var dataXML:XML = new XML();
public var myLoader:URLLoader;

//
public function initApp():void 
{
	Controller.getInstance().init();
	Model.getInstance().init();
	
	Controller.getInstance().run();
	
	var uiManager:UIManager=UIManager.getInstance();
	this.addChild(uiManager);
	uiManager.init();
}


