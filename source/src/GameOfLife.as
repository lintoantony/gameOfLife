/**
 *	@author Linto K A
 *	@mail lintoka123@gmail.com
 */
package {
	import com.app.controller.AppController;
	import com.app.model.AppModel;
	import com.app.view.AppView;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	[SWF(width='480',height='800',backgroundColor='#96ed89',frameRate='30')]
	public class GameOfLife extends Sprite {
		
		public function GameOfLife(){
			this.initGame();
		}
		
		private function initGame():void{	
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var appModel:AppModel = new AppModel(this);
			var appView:AppView = new AppView(this);
			
			var appController:AppController = new AppController(appModel, appView);
		}
		
	}
}