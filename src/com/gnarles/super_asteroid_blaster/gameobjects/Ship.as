package com.gnarles.super_asteroid_blaster.gameobjects 
{
	import com.gnarles.super_asteroid_blaster.helpers.CachedSprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author gnarles
	 */
	public class Ship extends CachedSprite 
	{
		public var speed:Point;
		private var speed_multi:Number = 0.5;
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
		}
		
		public function thrust(forward:Boolean=true):void
		{
			var angleInRadians:Number = rotation * (Math.PI / 180.0);
			if (forward)
			{
				speed.x += speed_multi * Math.sin(angleInRadians);
				speed.y -= speed_multi * Math.cos(angleInRadians);
			}
			else
			{
				speed.x -= speed_multi * Math.sin(angleInRadians);
				speed.y += speed_multi * Math.cos(angleInRadians);
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
	}
}