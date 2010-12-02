/*
* Copyright (c) 2010 Tom Davies
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package com.tomseysdavies.ember.core{
	
	public interface ISystemManager extends IDestroyable{

		
		/**
		 * registers a system
		 * 
		 * @param System 
		 * 
		 */	
		function addSystem(System:Class):*;
		
		
		/**
		 * unregisters a system
		 * 
		 * @param system
		 * 
		 */	
		function removeSystem(System:Class):void;

	}
}