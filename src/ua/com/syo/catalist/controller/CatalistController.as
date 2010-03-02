import flash.events.Event;

import mx.core.Application;
import mx.core.Container;
import mx.events.MenuEvent;
import mx.managers.PopUpManager;

import ua.com.syo.catalist.data.KoefStorage;
import ua.com.syo.catalist.model.FileManager;
import ua.com.syo.catalist.model.polynoms.PolyKoef;
import ua.com.syo.catalist.view.AboutView;
import ua.com.syo.catalist.view.CycleView;
import ua.com.syo.catalist.view.FuelParamsView;
import ua.com.syo.catalist.view.KTZParamsView;
import ua.com.syo.catalist.view.polinoms.PolynomsCoefficientsView;
import ua.com.syo.catalist.view.vars.EcologyVarsView;
import ua.com.syo.catalist.view.vars.EconomyVarsView;
import ua.com.syo.catalist.view.vars.EnergyVarsView;
import ua.com.syo.catalist.view.vars.SumVarsView;

private var aboutPopup:AboutView = new AboutView();
private var fileManager:FileManager = new FileManager();

private static const views:Object = {
	ktzParams:KTZParamsView,
	cycleReproduce:CycleView,
	energyVars:EnergyVarsView,
	ecologyVars:EcologyVarsView,
	economyVars:EconomyVarsView,
	sumVars:SumVarsView,
	fuelParams:FuelParamsView,
	poliKoef:PolynomsCoefficientsView
}

private function init():void {
	KoefStorage.init();
	fileManager.addEventListener(Event.OPEN, cycleDataFileOpenHandler);
	fileManager.loadDefaultFile('cycleData.xml');
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
		if (!view || (viewId == "ecologyVars" || viewId == "economyVars" || viewId == "sumVars")) {
            view = new viewClass();
            if ((viewId == "ecologyVars" || viewId == "economyVars" || viewId == "sumVars")) {
            	label += "| "+ PolyKoef.currentFuel + "|" + PolyKoef.currentMode;
            }
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
	//PolyModelsPXX.setCurrentModes("PXX", "gasoline", "withoutNeutralizer");
	//PolyModelsNav.setCurrentModes("load", "gasoline", "withoutNeutralizer");
	//PolyModelsXX.setCurrentModes("XX", "gasoline", "withoutNeutralizer");
	//PolyModelsXX.setCurrentModes("XX", "gasoline", "beforeNeutralizer");
	//showView("ecologyVars", "ecologyVars");
	//showView("sumVars", "sumVars");
	//showView("cycleReproduce", "cycleReproduce");
	
	//PolyKoef.currentMode = "beforeN";
	//PolyKoef.currentFuel = "gasoline";

	//showView("ecologyVars", "ecologyVars");
	//trace(Integral.rectangleRule(0, 10.2, 0.001, testFunction));
	//event.currentTarget.currentCycleDataXML
}
