/**
 *	@author Linto K A
 *	@mail lintoka123@gmail.com
 */
package com.app.view {
	import com.app.events.CustomEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.*;
	import flash.system.Capabilities;
	import flash.text.*;
		
	public class AppView extends Sprite {
		
		public static var ON_BUTTON_CLICK:String = "onButtonClick";
		private var stageRef:Sprite;
		private var isMenu:Boolean = false;
		private var grid:GridView;
		
		public function AppView(stageRef:Sprite) {
			this.stageRef = stageRef;
			
			this.attachTitle();
			this.attachTimeDisplay();
			this.attachGrid();
			this.attachMenuButton();
			this.attachMenuItems();
			this.showMenu(false);
		}
		
		private function attachTitle():void{
			var titleMc:TitleClip = new TitleClip();
			titleMc.x = 0;
			titleMc.y = 10;
			this.stageRef.addChild(titleMc);
		}
		
		private function attachTimeDisplay():void{
			var timeDisplay:TimeDisplay = new TimeDisplay();
			timeDisplay.name = "timeDisplay";
			timeDisplay.x =  this.stageRef.stage.stageWidth - timeDisplay.width;
			timeDisplay.y = 100;
			this.stageRef.addChild(timeDisplay);
		}
		
		public function getTimeDisplay():TextField{
			var tMc:MovieClip = this.stageRef.getChildByName("timeDisplay") as MovieClip; 
			return tMc.label;
		}
		
		private function attachGrid():void{
			grid = new GridView( 8, 480 );
			grid.x = this.stageRef.stage.stageWidth/2 - grid.width/2;
			grid.y = 170;
			this.stageRef.addChild(grid);
		}
		
		public function getGrid():GridView{
			return grid;
		}
		
		private function attachMenuButton():void{
			var menuButton:MenuButton = new MenuButton();
			menuButton.name = "menuButton";
			menuButton.x = this.stageRef.stage.stageWidth/2 - menuButton.width/2;
			menuButton.y = this.stageRef.stage.stageHeight - menuButton.height;
			menuButton.label.mouseEnabled = false;
			menuButton.buttonMode = true;
			menuButton.addEventListener(MouseEvent.CLICK, onMenuClick);
			
			this.stageRef.addChild(menuButton);
		}
		
		private function onMenuClick(evt:MouseEvent):void{
			this.isMenu = !this.isMenu;
			this.showMenu(this.isMenu);
		}
		
		private function attachMenuItems():void{
			var buttomIdArr:Array = ["RANDOM", "START", "STOP", "RESET"];
			var buttomLabelArr:Array = ["Random States", "Start Game", "Stop Game", "Reset"];
			
			var menuContainer:Sprite = new Sprite();
			menuContainer.name = "menuContainer";
			this.stageRef.addChild(menuContainer);
			
			var menuBg:ResizeClip = new ResizeClip();
			menuBg.name = "menuBg";
			menuBg.width = this.stageRef.stage.stageWidth;
			menuBg.height = this.stageRef.stage.stageHeight;
			menuBg.alpha = 0.8;	
			menuContainer.addChild(menuBg);
			
			var menuItemsHolder:MovieClip = new MovieClip();
			menuItemsHolder.name = "menuItemsHolder";

			var thisBut:ButtonMc;
			var yPos:Number = 0;
			for(var i:int=0;i<buttomIdArr.length;i++){
				thisBut = new ButtonMc();
				thisBut.name = buttomIdArr[i];
				thisBut.y = yPos;
				thisBut.label.mouseEnabled = false;
				thisBut.buttonMode = true;
				thisBut.label.text = buttomLabelArr[i];
				thisBut.addEventListener(MouseEvent.CLICK, onButClick);
				menuItemsHolder.addChild(thisBut);
				yPos += (thisBut.height + 5);
			}
			
			menuItemsHolder.x = this.stageRef.stage.stageWidth/2 - menuItemsHolder.width/2;
			menuItemsHolder.y = this.stageRef.stage.stageHeight/2 - menuItemsHolder.height/2;
			menuContainer.addChild(menuItemsHolder);
		}
		
		private function onButClick(evt:MouseEvent):void{
			var custEvt:CustomEvent = new CustomEvent(ON_BUTTON_CLICK);
			custEvt.data = evt.currentTarget.name;
			this.dispatchEvent(custEvt);
			this.showMenu(false);
		}
		
		private function showMenu(isVisible:Boolean):void{
			this.isMenu = isVisible;
			var menuContainer:Sprite = this.stageRef.getChildByName("menuContainer") as Sprite;
			menuContainer.visible = isVisible;
		}

	}
}
