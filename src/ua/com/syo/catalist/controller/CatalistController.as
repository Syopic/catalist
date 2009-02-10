import flash.events.Event;

import mx.core.Application;
import mx.core.Container;
import mx.events.MenuEvent;
import mx.managers.PopUpManager;

import ua.com.syo.catalist.model.FileManager;
import ua.com.syo.catalist.view.AboutView;
import ua.com.syo.catalist.view.CycleView;
import ua.com.syo.catalist.view.ExperimentParamsView;
import ua.com.syo.catalist.view.KTZParamsView;
import ua.com.syo.catalist.view.polinoms.PolinomsCoefficientsView;

private var aboutPopup:AboutView = new AboutView();
private var fileManager:FileManager = new FileManager();

private static const views:Object = {
	ktzParams:KTZParamsView,
	cycleReproduce:CycleView,
	expParams:ExperimentParamsView,
	poliKoef:PolinomsCoefficientsView
}

private function init():void {
	fileManager.addEventListener(Event.OPEN, cicleDataFileOpenHandler);
	//trace(Integral.rectangleRule(2, 4, 0.00000001, testFunction));
}

public function testFunction(x:Number):Number {
	//var result:Number = 1 / Math.sqrt(1 - x*x*x*x);
	var result:Number = Math.sin(x)/ (x + 1)
	return result;
}



private function onClickMenuBarHandler(event:MenuEvent): void {
	switchMenuItems(XML(event.menu.selectedItem).@id, XML(event.menu.selectedItem).@label);
}

private function switchMenuItems(viewId:String, label:String): void {
	switch (viewId) {
		case "about": 	
			showAboutPopup();
		break;
		case "loadData": 	
			fileManager.showOpenFileDialog();
		break;
		case "saveData": 	
			fileManager.showSaveDialog();
		break;
		default: 
			showView(viewId, label);
		break;
	}
}

private function showView(viewId:String, label:String): void {
	var view:Container;
	var viewClass:Class = views[viewId];
	
	if (viewClass != null) {
		view = getViewByClass(viewClass);
		if (!view) {
            view = new viewClass();
            view.label = label;
            
            if (tabNav.selectedIndex == -1) {
				tabNav.addChild(view);
            } else {
                tabNav.addChildAt(view, tabNav.selectedIndex + 1);
                tabNav.selectedIndex++
            }
        } else {
        	tabNav.selectedChild = view;
        }
	}
}

private function getViewByClass(viewClass:Class):Container {
    for each(var view:Container in tabNav.getChildren()) {
        if (view is viewClass) {
            return view;
        }
    }
    return null;
}

private function showAboutPopup(): void {
	PopUpManager.addPopUp(aboutPopup, Application.application as DisplayObject, true);
	PopUpManager.centerPopUp(aboutPopup);
}

private function cicleDataFileOpenHandler(event:Event):void  {
	//event.currentTarget.currentCycleDataXML
}
