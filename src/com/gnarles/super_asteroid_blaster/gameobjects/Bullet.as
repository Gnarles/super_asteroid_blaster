package com.gnarles.super_asteroid_blaster.gameobjects 
{
	import com.gnarles.super_asteroid_blaster.Game
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author gnarles
	 */
	public class Bullet extends Sprite 
	{
		private var maxSpeed:int;
		private var speed:Point;
		public var createdTime:int;
		public var maxDuration:int;
		
		public function Bullet(createdTime:int, angle:Number = 0) 
		{
			this.createdTime = createdTime
			maxSpeed = 10;
			maxDuration = 1000;
			speed = new Point(maxSpeed*Math.sin(angle), -maxSpeed*Math.cos(angle));
			
			drawBullet();
		}
		
		public function update():void
		{
			x += speed.x;
			y += speed.y;
			
			checkIfInGameBounds();
		}
		
		private function checkIfInGameBounds():void
		{
			if (x + width <= 0)
			{
				x = Game.gameWidth - width;
			}
			else if (x >= Game.gameWidth)
			{
				x = 0;
			}
 
			if (y + height <= 0)
			{
				y = Game.gameHeight - height;
			}
			else if (y >= Game.gameHeight)
			{
				y = 0;
			}
		}
		
		private function drawBullet():void
		{
			var rect:Sprite = new Sprite();
			rect.graphics.beginFill(0xFFFFFF);
			rect.graphics.drawRect(0, 0, 2, 2);
			rect.graphics.endFill();
			addChild(rect);
		}
	}
}