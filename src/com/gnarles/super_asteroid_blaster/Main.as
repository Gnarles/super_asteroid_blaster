package com.gnarles.super_asteroid_blaster
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author gnarles
	 */
	public class Main extends Sprite 
	{
		private var game:Game;
		
		public function Main():void 
		{
			if (stage) 
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// entry point
			game = new Game();
			stage.addChild(game);
		}
		
	}
	
}