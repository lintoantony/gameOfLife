package com.app.view{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.app.view.ItemView;

	public class GridView extends Sprite{
		
		private var maxVal:int;
		private var dimention:int;
		private var segNums:int;
		private var itemSize:int;
		private var itemPad:int = 1;
		private var items:Array;
		
		public function GridView( numOfSegments:int, sizeOfGrid:int ){
			dimention = sizeOfGrid;
			segNums = numOfSegments;
			maxVal = numOfSegments - 1;
			
			calculateGrid();
			createGrid();
		}
		
		private function calculateGrid():void{
			itemSize = (( dimention / segNums ) - itemPad) << 0;
		}

		private function createGrid():void{
			items = new Array();
			while ( numChildren > 0 ) removeChildAt(0);
			
			for (var x:int = 0; x < segNums; x++) {
				items[x] = new Array();
				for (var y:int = 0; y < segNums; y++) {
					var cell:ItemView = new ItemView( itemSize );
					cell.x = x * (itemSize + itemPad);
					cell.y = y * (itemSize + itemPad);
					
					items[x][y] = addChild( cell );
				}
			}
		}

		public function update( e:Event = null ):void {
			var x:int;
			var y:int;
			
			var cell:ItemView;
			var bros:int;
			
			for (x = 0; x < segNums; x++) {
				for (y = 0; y < segNums; y++) {
					cell = items[x][y];
					bros = 0;

					if ( y > 0 )
						if ( items[x][y-1].ok ) bros++;
					
					if ( x < maxVal && y > 0 )
						if ( items[x+1][y-1].ok ) bros++;
					
					if ( x > 0 && y > 0 )
						if ( items[x-1][y-1].ok ) bros++;
					
					if ( y < maxVal )
						if ( items[x][y+1].ok ) bros++;
					
					if ( x < maxVal && y < maxVal )
						if ( items[x+1][y+1].ok ) bros++;
					
					if ( x > 0 && y < maxVal )
						if ( items[x-1][y+1].ok ) bros++;
					
					if ( x < maxVal )
						if ( items[x+1][y].ok ) bros++;

					if ( x > 0 )
						if ( items[x-1][y].ok ) bros++;

					if ( cell.ok ){
						switch( bros ){
							case 2 :
								cell.newState = ItemView.ALIVE;
							break;
							
							case 3 :
								cell.newState = ItemView.ALIVE;
							break;
							
							default :
								cell.newState = ItemView.DEAD;
						}
						continue;
					}
					
					if ( bros == 3 ){
						cell.newState = ItemView.SPAWN;
						continue;
					}
					
					cell.newState = ItemView.EMPTY;
				}
			}
			
			for (x = 0; x < segNums; x++) {
				for (y = 0; y < segNums; y++) {
					cell = items[x][y];
					cell.state = cell.newState;
				}	
			}
			
		}
		
		public function randomise( onProbability:Number = .2 ):void{
			for ( var x:int = 0; x < segNums; x++) {
				for ( var y:int = 0; y < segNums; y++) {
					var cell:ItemView = items[x][y];
					cell.state = Math.random() < onProbability ? ItemView.ALIVE : ItemView.EMPTY;
				}	
			}
		}

		public function reset():void{
			for ( var x:int = 0; x < segNums; x++) {
				for ( var y:int = 0; y < segNums; y++) {
					var cell:ItemView = items[x][y];
					cell.state = ItemView.EMPTY;
				}	
			}
		}
		
		public function set size( size:int ):void{
			dimention = size;
			calculateGrid();
			createGrid();
		}

		public function set segments( segments:int ):void{
			maxVal = segments - 1;
			segNums = segments;
			calculateGrid();
			createGrid();
		}
	}
}
