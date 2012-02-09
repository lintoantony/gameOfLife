package com.app.view {
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ItemView extends Sprite {
	
		public static const EMPTY:int = 0;
		public static const SPAWN:int = 1;
		public static const ALIVE:int = 2;
		public static const DEAD:int = 3;
		
		private var dimension:int;
		private var itemState:int;
		private var colours:Array = [ 0x044c29, 0x167f39, 0x45bf55, 0x96ed89 ];
		
		public var newState:int;

		public function ItemView( size:int ) {
			itemState = newState = EMPTY;
			dimension = size;
			draw();
			
			buttonMode = true;
			addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			addEventListener( MouseEvent.CLICK, onClick );
		}

		private function draw():void{
			graphics.clear();
			graphics.beginFill( colours[ itemState ] );
			graphics.drawRect(0, 0, dimension, dimension);
			graphics.endFill();
		}
		
		private function onMouseOver( e:MouseEvent ):void{
			graphics.clear();
			graphics.lineStyle( 2, 0xFFFFFF );
			graphics.beginFill( 0x2b2b2b );
			graphics.drawRect(0, 0, dimension, dimension);
			graphics.endFill();
		}
		
		private function onMouseOut( e:MouseEvent ):void{
			draw();
		}
		
		private function onClick( e:MouseEvent ):void{
			state = ( itemState == ALIVE ? EMPTY : ALIVE );
		}

		public function set state( status:int ):void{
			itemState = status;
			draw();
		}
		
		public function get state():int { return itemState }
		public function get ok():Boolean { return ( itemState == ALIVE || itemState == SPAWN ) }
		
	}
	
}
