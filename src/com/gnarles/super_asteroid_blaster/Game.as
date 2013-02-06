package com.gnarles.super_asteroid_blaster 
{
	import com.gnarles.super_asteroid_blaster.gameobjects.Ship;
	import com.gnarles.super_asteroid_blaster.helpers.Images;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author gnarles
	 */
	public class Game extends Sprite 
	{
		private var background:Sprite;
		private var ship:Ship;
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			createBackground();
			createShip();
			
			//Set up the game loop. The update function will
			//be called every frame.
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			
		}
		
		private function createShip():void
		{
			ship = new Ship(Images.SHIP);
			ship.width = 10;
			ship.height = 20;
			ship.x = (stage.stageWidth / 2) - (ship.width / 2);
			ship.y = (stage.stageHeight / 2) - (ship.height / 2);
			addChild(ship);
		}
		
		private function createBackground():void 
		{
			background = new Sprite();
			background.graphics.beginFill(0x000000);
			background.graphics.drawRect(0,0,stage.stageWidth, stage.stageHeight);
			addChildAt(background, 0);
		}
	}
}