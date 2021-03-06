package com.gnarles.super_asteroid_blaster 
{
	import com.gnarles.super_asteroid_blaster.gameobjects.Asteroid;
	import com.gnarles.super_asteroid_blaster.gameobjects.Bullet;
	import com.gnarles.super_asteroid_blaster.gameobjects.Ship;
	import com.gnarles.super_asteroid_blaster.helpers.Images;
	import com.gnarles.super_asteroid_blaster.helpers.KeyboardState;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author gnarles
	 */
	public class Game extends Sprite 
	{
		public static var gameHeight:int;
		public static var gameWidth:int;
		
		private var background:Sprite;
		private var ship:Ship;
		private var keyboardState:KeyboardState;
		private var bullets:Array;
		private var asteroids:Array;
		private var currentTime:Number;
		
		private var playerSpawn:Point;
		private var spawnProtectionArea:Rectangle;
		
		public function Game(width:int, height:int) 
		{
			gameWidth = width;
			gameHeight = height;
			bullets = new Array();
			asteroids = new Array();
			playerSpawn = new Point((gameWidth / 2), (gameHeight / 2));
			spawnProtectionArea = new Rectangle(playerSpawn.x - 300, playerSpawn.y - 200, 600, 400);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			keyboardState = new KeyboardState();
			
			createBackground();
			createShip();
			createAsteroids();
			
			hookUpEvents();
		}
		
		private function update(e:Event):void
		{
			currentTime = getTimer();
			
			if (ship.visible)
			{
				if (keyboardState.checkKeyDown(KeyboardState.UP))
				{
					ship.thrust(true);
				}
				if (keyboardState.checkKeyDown(KeyboardState.DOWN))
				{
					ship.thrust(false);
				}
				if (keyboardState.checkKeyDown(KeyboardState.LEFT))
				{
					ship.rotate(false);
				}
				if (keyboardState.checkKeyDown(KeyboardState.RIGHT))
				{
					ship.rotate(true);
				}
				if (keyboardState.checkKeyDown(KeyboardState.SPACE) && currentTime - ship.lastFired > ship.fireDelay)
				{
					FireBullet();
				}
				
				ship.update();
			}
			
			updateBullets();
			updateAsteroids();
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			keyboardState.setKeyDown(e.keyCode);
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			keyboardState.setKeyUp(e.keyCode);
		}
		
		private function createShip():void
		{
			ship = new Ship(Images.SHIP);
			ship.width = 10;
			ship.height = 20;
			ship.x = playerSpawn.x;
			ship.y = playerSpawn.y;
			addChild(ship);
		}
		
		private function createBackground():void 
		{
			background = new Sprite();
			background.graphics.beginFill(0x000000);
			background.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			
			addChildAt(background, 0);
		}
		
		private function createAsteroids():void
		{
			for (var i:int = 0; i < 8; i++) 
			{
				createAsteroid();
			}
		}
		
		private function createAsteroid():void
		{
			var directionInDegrees:int = generateRandomInteger(0, 360);
			var directionInRadians:Number = directionInDegrees * (Math.PI / 180.0);
			
			
			var asteroid:Asteroid = new Asteroid(Images.ASTEROID, directionInRadians);
			asteroid.x = generateRandomInteger(10, gameWidth);
			asteroid.y = generateValidRandomYCoord(asteroid.x);
			asteroid.width = 40;
			asteroid.height = 40;
			addChild(asteroid);
			
			asteroids.push(asteroid);
		}
		
		private function generateValidRandomYCoord(xCoord:int):int
		{
			var isValidYCoord:Boolean = false;
			var randomYCoord:int = 0;
			
			while (!isValidYCoord)
			{
				randomYCoord = generateRandomInteger(10, gameHeight);
				
				if (!spawnProtectionArea.containsPoint(new Point(xCoord, randomYCoord)))
				{
					isValidYCoord = true;
				}
			}
			
			return randomYCoord;
		}
		
		private function generateRandomInteger(min:int, max:int):int
		{
			var randomNumber:int = Math.floor(min + (Math.random() * (max - min + 1)));
			return randomNumber;
			
		}
		
		private function hookUpEvents():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			//Set up the game loop. The update function will
			//be called every frame.
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function FireBullet():void 
		{
			var shipAngleInRadians:Number = ship.getAngleInRadians();
			var fireFromX:int = ship.x + ((10) * Math.sin(shipAngleInRadians));
			var fireFromY:int = ship.y - ((10) * Math.cos(shipAngleInRadians));
			
			var bullet:Bullet = new Bullet(currentTime, shipAngleInRadians);
			bullet.x = fireFromX;
			bullet.y = fireFromY;
			addChild(bullet);
			bullets.push(bullet);
			ship.lastFired = currentTime;
		}
		
		private function updateBullets():void
		{
			var bulletsToDelete:Array = new Array();
			
			for (var i:int = 0; i < bullets.length; i++)
			{
				bullets[i].update();
				
				if (currentTime - bullets[i].createdTime > bullets[i].maxDuration)
				{
					bulletsToDelete.push(i);
				}
			}
		
			for (var j:int = 0; j < bulletsToDelete.length;j++ )
			{
				removeChild(bullets[bulletsToDelete[j]]);
				bullets.splice(bulletsToDelete[j], 1);
			}
		}
	
		private function updateAsteroids():void
		{
			for (var i:int = 0; i < asteroids.length; i++)
			{
				asteroids[i].update();
			}
		}
	}
}