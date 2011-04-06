/*
* Copyright (c) 2010 Tom Davies
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package com.tomseysdavies.ember.core{
	import flash.utils.Dictionary;
	
	public interface IEntityManager extends IDisposable	{
		
		/**
		 * Creates a new entity with the id provided. If no id is provided a unique id will be auto generated.
		 * 
		 * If an id is provided but the entityManager already has an entity
		 * with the same id, no entity will be created.
		 * 
		 * @return the new entity
		 * 
		 */		
		function createEntity(Id:String = null):IEntity;	
		
		/**
		 * 
		 * @return Boolean, true if an entity with the provided id exists.
		 */
		function hasEntity(id:String):Boolean;
		
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
		 * 
		 * @return Boolean, true if the component was added.
		 */	
		function addComponent(entityId:String,component:Object):Boolean;
		
		/**
		 *retrieves a component
		 *  
		 * @param entity the component is registered with
		 * @param Component to be retrieves
		 * @return component 
		 * 
		 */		
		function getComponent(entityId:String, Component:Class):*;	
		
		/**
		 *retrieves all of an entities components 
		 *  
		 * @param entity the components are registered with
		 * @return a dictionary of the entites components with the component Class as the key
		 * 
		 */		
		function getComponents(entityId:String):Dictionary;	
		
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