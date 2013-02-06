package com.gnarles.super_asteroid_blaster.helpers 
{
	/**
	 * ...
	 * @author gnarles
	 */
	public class KeyboardState
	{
		private var keysDown:Array;
		private var keysUp:Array;
		
		public static const SPACE:int = 32;
		public static const LEFT:int = 37;
		public static const UP:int = 38;
		public static const RIGHT:int = 39;
		public static const DOWN:int = 40;
		public static const P:int = 80;
		public static const R:int = 82;
		public static const ESC:int = 27;
		
		public function KeyboardState()
		{
			keysDown = new Array();
			keysUp = new Array();
		}
		
		public function setKeyDown(keyCode:int):void
		{
			var isKeyDown:Boolean = false;
			for (var i:int = 0; i < keysDown.length; i++)
			{
				if (keysDown[i] == keyCode)
				{
					isKeyDown = true;
				}
			}
 
			//add the key to the array of pressed keys if it wasn't already in there
			if (!isKeyDown)
			{
				keysDown.push(keyCode);
			}
		}
		
		public function setKeyUp(keyCode:int):void
		{
			//position of key in the array
			var key_pos:int = -1;
			for (var i:int = 0; i < keysDown.length; i++)
			{
				if (keyCode == keysDown[i])
				{
					//the key is found/was pressed before, so store the position
					key_pos = i;
					break;
				}
			}
			
			//remove the keycode from keys_down if found
			if (key_pos != -1)
			{
				keysDown.splice(key_pos, 1);
			}
			
			keysUp.push(keyCode);
		}
		
		public function checkKeyDown(keycode:int):Boolean
		{
			var result:Boolean = false;
			
			for (var i:int = 0; i < keysDown.length; i++)
			{
				if (keysDown[i] == keycode)
				{
					result = true;
					break;
				}
			}
			
			return result;
		}
		
		public function checkKeyUp(keycode:int):Boolean
		{
			var answer:Boolean = false;
			for (var i:int = 0; i < keysUp.length; i++)
				if (keysUp[i] == keycode)
				{
					answer = true;
					break;
				}
			return answer;
		}
	}

}