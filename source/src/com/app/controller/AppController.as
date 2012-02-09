/**
 *	@author Linto K A
 *	@mail lintoka123@gmail.com
 */
package com.app.controller {

	import com.app.events.CustomEvent;
	import com.app.model.AppModel;
	import com.app.utils.TimerUtil;
	import com.app.view.AppView;
	import com.app.view.GridView;
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;

	public class AppController extends Sprite{
		
		private var appModel:AppModel;
		private var appView:AppView;
		private var gridView:GridView;
		private var repeatTimer:Timer;
		private var timeCounter:TimerUtil;
		
		public function AppController(appModel:AppModel, appView:AppView) {
			this.appModel = appModel;
			this.appView = appView;
			
			this.initializeTimer();
			this.initializeListeners();
			this.getGridView();
		}
	
		private function initializeListeners():void{
			repeatTimer = new Timer( 200 );
			repeatTimer.addEventListener( TimerEvent.TIMER, repeatHandler );
			
			this.appView.addEventListener(AppView.ON_BUTTON_CLICK, onButtonClick);
		}
		
		private function initializeTimer():void{
			var timeDisplay:TextField = this.appView.getTimeDisplay();
			this.timeCounter = new TimerUtil(timeDisplay);
		}
		
		private function getGridView():void{
			this.gridView = this.appView.getGrid();
		}
		
		private function repeatHandler( e:Event ):void{
			this.gridView.update();
		}
		
		private function onButtonClick(evt:CustomEvent):void{
			trace(evt.data);
			switch(evt.data){
				case "RANDOM":
					this.gridView.randomise();
					break;
				case "START":
					this.repeatTimer.start();
					this.timeCounter.startTimer();
					break;
				case "STOP":
					this.repeatTimer.stop();
					this.timeCounter.stopTimer();
					break;
				case "RESET":
					this.repeatTimer.stop();
					this.gridView.reset();
					this.timeCounter.resetTimer();
					break;
			}
		}
	}
}
