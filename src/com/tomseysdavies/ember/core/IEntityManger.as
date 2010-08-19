/*
* Copyright (c) 2010 Tom Davies
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package com.tomseysdavies.ember.core{
	
	public interface IEntityManger extends IDestroyable	{
		
		/**
		 * creates a new entity
		 * 
		 * @return the new entity
		 * 
		 */		
		function createEntity():IEntity;	
		
		/**
		 * unregisters an entity
		 * 
		 * @param entity
		 * 
		 */	
		function removeEntity(entity:IEntity):void;
		
		/**
		 * registers a component with an entity
		 * 
		 * @param entity the component is to be registered with
		 * @param component to be registered
		 */	
		function addComponent(entity:IEntity,component:Object):void;
		
		/**
		 *retrieves a component
		 *  
		 * @param entity the component is registered with
		 * @param Component to be retrieves
		 * @return component 
		 * 
		 */		
		function getComponent(entity:IEntity,Component:Class):*;	
		
		/**
		 *unregisters a component from an entity
		 *  
		 * @param entity the component is registered with
		 * @param Component to be unregisters
		 * 
		 */	
		function removeComponent(entity:IEntity,Component:Class):void;
		
		/**
		 *returns a pointer to a list of entities that have a specified set of components
		 *  
		 * @param Components set of components entities must have 
		 * @return entities with specifed component set
		 * 
		 */		
		function getEntityFamily(...Components):Vector.<IEntity>;
	}
}