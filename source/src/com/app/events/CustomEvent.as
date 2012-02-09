/**
 *	@author Linto K A
 *	@mail lintoka123@gmail.com
 */
package com.app.events {
	import flash.events.Event;
	public class CustomEvent extends Event {
		public var data:Object;
		
		public function CustomEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
	}
}
