/*
* Copyright (c) 2010 Tom Davies
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package com.tomseysdavies.ember.core{
	
	public interface IEntity extends IDestroyable{
		
		/**
		 * registers a compoment with the entity
		 * 
		 * @param component to be added
		 * 
		 */		
		function addComponent(component:Object):void;
		
		/**
		 * retrieves a components instance based on class name
		 * 
		 * @param Component class name of component to be retrieved
		 * 
		 */	
		function getComponent(Component:Class):*;
		
		/**
		 * unregisterers a component from the entity
		 * 
		 * @param Component class name of component to be unregistered
		 * 
		 */	
		function removeComponent(Component:Class):void;

		/**
		 * provides a referance to the entity manager 
		 * 
		 * @param manager instance of EntityManger
		 * 
		 */		
		function set manager(manager:IEntityManger):void;
		
	}
}