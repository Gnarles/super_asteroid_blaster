package com.gnarles.super_asteroid_blaster.gameobjects 
{
	import com.gnarles.super_asteroid_blaster.Game;
	import com.gnarles.super_asteroid_blaster.helpers.CachedSprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author gnarles
	 */
	public class Ship extends CachedSprite 
	{
		private var speed:Point;
		public var fireDelay:int = 200;
		public var lastFired:int = 0;
		
		private var speedMultiplier:Number = 0.5;
		private var friction:Number = 0.95;
		private var rotationAmount:int = 10;
		
		
		public function Ship(image:Class) 
		{
			super(image, true);
			
			speed = new Point(0, 0);
		}
		
		public function update():void
		{			
			x += speed.x;
			y += speed.y;
			speed.x *= friction;
			speed.y *= friction;
			
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
		
		public function thrust(forward:Boolean=true):void
		{
			var angleInRadians:Number = getAngleInRadians();
			if (forward)
			{
				speed.x += speedMultiplier * Math.sin(angleInRadians);
				speed.y -= speedMultiplier * Math.cos(angleInRadians);
			}
			else
			{
				speed.x -= speedMultiplier * Math.sin(angleInRadians);
				speed.y += speedMultiplier * Math.cos(angleInRadians);
			}
		}
		
		public function rotate(clockwise:Boolean=true):void
		{
			if (clockwise)
			{
				this.rotation += rotationAmount;
			}
			else
			{
				this.rotation -= rotationAmount;
			}
		}
		
		public function getAngleInRadians():Number
		{
			return rotation * (Math.PI / 180.0);
		}
	}
}