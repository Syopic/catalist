package ua.com.syo.catalist.view
{
	import mx.core.UIComponent;
	import flash.display.Sprite;
	import mx.controls.Button;
	import mx.containers.Canvas;
	import mx.containers.ApplicationControlBar;
	import mx.containers.Box;
	import ua.com.syo.catalist.view.form.ParamForm;
	import flash.system.System;
	import mx.core.Application;
	import mx.managers.PopUpManager;
	import mx.managers.PopUpManagerChildList;
	import mx.core.IFlexDisplayObject;
	
	public class UIManager extends Canvas
	{
		private static var instance:UIManager;
		
		private var topBarContainer:TopMenu;
		private var paramPopup:IFlexDisplayObject;
		
		public static function getInstance(): UIManager
		{
			if (!instance)
			{
				instance=new UIManager();
			}
			
			return instance;
		}
		
		public function UIManager()
		{
			
		}
		
		public function init(): void
		{
			this.percentWidth=100;
			this.percentHeight=100;
			this.showTopGUI();
		}
		
		public function showTopGUI(): void
		{
			this.topBarContainer=new TopMenu();
			this.addChild(this.topBarContainer);
		}
		
		public function showParamForm(): void
		{
			this.paramPopup=PopUpManager.createPopUp(this, ParamForm, true); 
			PopUpManager.centerPopUp(this.paramPopup);
		}
		
		public function hideParamForm(): void
		{
			PopUpManager.removePopUp(this.paramPopup);
		}
	}
}