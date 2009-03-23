import flash.events.Event;

import mx.core.Application;
import mx.core.Container;
import mx.events.MenuEvent;
import mx.managers.PopUpManager;

import ua.com.syo.catalist.model.FileManager;
import ua.com.syo.catalist.model.KTZParams;
import ua.com.syo.catalist.model.polynoms.PolyKoef;
import ua.com.syo.catalist.view.AboutView;
import ua.com.syo.catalist.view.CycleView;
import ua.com.syo.catalist.view.ExperimentParamsView;
import ua.com.syo.catalist.view.KTZParamsView;
import ua.com.syo.catalist.view.polinoms.PolynomsCoefficientsView;
import ua.com.syo.catalist.view.vars.EcoVarsView;
import ua.com.syo.catalist.view.vars.EnergyVarsView;

private var aboutPopup:AboutView = new AboutView();
private var fileManager:FileManager = new FileManager();

private static const views:Object = {
	ktzParams:KTZParamsView,
	cycleReproduce:CycleView,
	energyVars:EnergyVarsView,
	ecoVars:EcoVarsView,
	expParams:ExperimentParamsView,
	poliKoef:PolynomsCoefficientsView
}

private function init():void {
	fileManager.addEventListener(Event.OPEN, cycleDataFileOpenHandler);
}

public function testFunction(x:Number):Number {
	var b0:Number = PolyKoef.getP("B0", "Gпал", "withoutNeutralizer", "gasoline", "XX");
	var b1:Number = PolyKoef.getP("B1", "Gпал", "withoutNeutralizer", "gasoline", "XX");
	var b11:Number = PolyKoef.getP("B11", "Gпал", "withoutNeutralizer", "gasoline", "XX");
	
	var result:Number = b0 + b1*getN(x) + b11*getN(x)*getN(x);
	return result;
}

private function getN(t:Number):Number {
	return KTZParams.nXXmin+0*t;
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

private function cycleDataFileOpenHandler(event:Event):void  {
	showView("cycleReproduce", "Відтворення циклу");
	//trace(Integral.rectangleRule(0, 10.2, 0.001, testFunction));
	//event.currentTarget.currentCycleDataXML
}
