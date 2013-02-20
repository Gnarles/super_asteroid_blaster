package com.gnarles.super_asteroid_blaster.gameobjects 
{
	import com.gnarles.super_asteroid_blaster.Game;
	import com.gnarles.super_asteroid_blaster.helpers.CachedSprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author gnarles
	 */
	public class Asteroid extends CachedSprite 
	{
		private var direction:Number;
		private var speed:Point;
		
		public function Asteroid(image:Class, direction:Number) 
		{
			super(image, true);
			
			direction = direction;
			speed = new Point(-3 * Math.cos(direction), -3 * Math.sin(direction));
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
	}
}