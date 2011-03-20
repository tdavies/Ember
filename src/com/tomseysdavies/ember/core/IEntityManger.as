/*
* Copyright (c) 2010 Tom Davies
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package com.tomseysdavies.ember.core{
	
	public interface IEntityManger extends IDisposable	{
		
		/**
		 * creates a new entity with the id provided. If no id is provided a unique id will be auto generated
		 * 
		 * @return the new entity
		 * 
		 */		
		function createEntity(Id:String = null):IEntity;	
		
		/**
		 * unregisters an entity
		 * 
		 * @param entity
		 * 
		 */	
		function removeEntity(entityId:String):void;
		
		/**
		 * unregisters all entities and resets the entity manager 
		 * 
		 */	
		function removeAll():void;
		
		/**
		 * registers a component with an entity
		 * 
		 * @param entity the component is to be registered with
		 * @param component to be registered
		 */	
		function addComponent(entityId:String,component:Object):void;
		
		/**
		 *retrieves a component
		 *  
		 * @param entity the component is registered with
		 * @param Component to be retrieves
		 * @return component 
		 * 
		 */		
		function getComponent(entityId:String,Component:Class):*;	
		
		/**
		 *unregisters a component from an entity
		 *  
		 * @param entity the component is registered with
		 * @param Component to be unregisters
		 * 
		 */	
		function removeComponent(entityId:String,Component:Class):void;
		
		/**
		 *returns a pointer to a list of entities that have a specified set of components
		 *  
		 * @param Components set of components entities must have 
		 * @return entities with specifed component set
		 * 
		 */		
		function getEntityFamily(...Components):IFamily;
	}
}