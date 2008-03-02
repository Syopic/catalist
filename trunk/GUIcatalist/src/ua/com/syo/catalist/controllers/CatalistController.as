import mx.controls.Menu;
import ua.com.syo.catalist.views.KTZParamsView;
import ua.com.syo.catalist.views.AboutView;
import mx.managers.PopUpManager;
import ua.com.syo.catalist.views.data.CatalistStrings;
import mx.core.Application;
import mx.events.MenuEvent;
import mx.managers.PopUpManager;
import mx.managers.PopUpManagerChildList;
import flash.events.MouseEvent;
import ua.com.syo.catalist.views.ExperimentParamsView;

private var aboutPopup:AboutView = new AboutView();
private var ktzParams:KTZParamsView = new KTZParamsView();
private var expParams:ExperimentParamsView = new ExperimentParamsView();

private var setMenu:Menu;

private var setList:Object = [{label: "КТЗ і його двигуна", id: "ktzParams"}, 
					  {label: "Для визначення екологічних показників КТЗ", id: "ekoParams"},
					  {label: "Оточуючого середовища і фізичні константи", id: "envConstants"},
					  {label: "Коефіцієнти поліномів",id: "koefPolinoms"} ]; 

private function addTab(label:String, content:DisplayObject):void {
	var container:VBox = new VBox();
	container.label = label;
	container.addChild(content);
	tabNav.addChild(container);
}

private function onClickMenuBarHandler(event:MenuEvent): void {
	switchMenuItems(XML(event.menu.selectedItem).@id);
	
}

private function switchMenuItems(idStr:String): void {
	switch (idStr) {
		case "about": 	
			showAboutPopup();
		break;
		case "ktzParams": 
			addTab("Параметри КТЗ", ktzParams);
			tabNav.selectedIndex = tabNav.numChildren - 1;
		break;
		case "expParams": 
			addTab("Параметри двигуна", expParams);
			tabNav.selectedIndex = tabNav.numChildren - 1;
		break;
		default: break;
	}
}

private function showAboutPopup(): void {
	PopUpManager.addPopUp(aboutPopup, Application.application as DisplayObject, true);
	PopUpManager.centerPopUp(aboutPopup);
}


private function initMenu():void {
	setMenu=new Menu();
    setMenu.dataProvider = setList;
    setMenu.selectedIndex = 0;
    setMenu.addEventListener("itemClick", setMenuItemClickHandler);
    setPopupButton.popUp = setMenu;
    setPopupButton.label = "Параметри: " + setMenu.dataProvider[setMenu.selectedIndex].label;
}

private function setMenuItemClickHandler(event:MenuEvent):void {
	switchMenuItems(event.item.id); 
    var label:String = event.item.label;        
    setPopupButton.label = "Параметри: " + label;
    setPopupButton.close();
    setMenu.selectedIndex = event.index;
}
private function setMenuButtonClickHandler(event:MouseEvent):void {
}