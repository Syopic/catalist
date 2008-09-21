import mx.controls.Menu;
import ua.com.syo.catalist.view.KTZParamsView;
import ua.com.syo.catalist.view.AboutView;
import mx.managers.PopUpManager;
import ua.com.syo.catalist.view.data.CatalistStrings;
import mx.core.Application;
import mx.events.MenuEvent;
import mx.managers.PopUpManager;
import mx.managers.PopUpManagerChildList;
import flash.events.MouseEvent;
import ua.com.syo.catalist.view.ExperimentParamsView;
import mx.core.Container;

private var aboutPopup:AboutView = new AboutView();

private static const views:Object = {
	ktzParams:KTZParamsView,
	expParams:ExperimentParamsView
}
private static const viewsLabels:Object = {
	ktzParams:"Параметри КТЗ",
	expParams:"Параметри двигуна"
}

private function onClickMenuBarHandler(event:MenuEvent): void {
	switchMenuItems(XML(event.menu.selectedItem).@id);
}

private function switchMenuItems(viewId:String): void {
	switch (viewId) {
		case "about": 	
			showAboutPopup();
		break;
		default: 
			showView(viewId);
		break;
	}
}

private function showView(viewId:String): void {
	var view:Container;
	var viewClass:Class = views[viewId];
	
	if (viewClass != null) {
		view = getViewByClass(viewClass);
		if (!view) {
            view = new viewClass();
            view.label = viewsLabels[viewId];
            
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

