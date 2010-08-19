/*
* Copyright (c) 2010 Tom Davies
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package com.tomseysdavies.ember.core
{
	import flash.display.DisplayObjectContainer;

	public interface IGame extends IDestroyable{
		
		
		/**
		 * sets the <code>DisplayObjectContainer</code> as a view for the game 
		 * @param value 
		 * 
		 */
		function set contextView(value:DisplayObjectContainer):void;
		
		function get contextView():DisplayObjectContainer;
	}
}