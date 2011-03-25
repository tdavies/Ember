/*
* Copyright (c) 2010 Tom Davies
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package com.tomseysdavies.ember.base {
	import com.tomseysdavies.ember.core.IEntity;
	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IFamily;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * manages the relations between components and entites and keeps entity families upto date.
	 * @author Tom Davies
	 */
	public class EntityManager implements IEntityManager {
		
		private var _components:Dictionary;
		private var _families:Dictionary;
		private var _componentFamilyMap:Dictionary;
		private var _currentKey:int;
		
		public function EntityManager() {
			_components = new Dictionary();
			_families = new Dictionary();
			_componentFamilyMap = new Dictionary();
			_currentKey = 0;
		}
		
		//---------------------------------------------------------------------
		// API
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function createEntity(Id:String = null):IEntity{
			var key:String = Id; 
			if(key == null || key == ""){
				_currentKey ++;
				key = "id_" + _currentKey;
			}else if(_components[Id]){
				return null;
			}
			var entity:IEntity = new Entity(this,key);
			_components[entity.id] = new Dictionary();
			return entity;
		}
		
		/**
		 * @inheritDoc
		 */
		public function hasEntity(id:String):Boolean
		{
			return _components[id] != null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeEntity(entityId:String):void {
			for each(var component:Object in _components[entityId]){				
				removeEntityFromFamilies(entityId,getClass(component));
			}
			delete _components[entityId];
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAll():void {
			for(var entityId:String in _components){
				removeEntity(entityId);
			}
			_currentKey = 0;
		}
				
		
		/**
		 * @inheritDoc
		 */
		public function addComponent(entityId:String,component:Object):Boolean{
			var Component:Class = getClass(component);
			if(!hasEntity(entityId)){
				return false;
			}
			_components[entityId][Component] = component;
			addEntityToFamilies(entityId,Component);
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getComponent(entityId:String,Component:Class):*{
			var entityComponents:Dictionary = _components[entityId];
			if(entityComponents == null){
				throw new Error("Entity " + entityId + " not found in Entity Manager");
			}
			try{
				return entityComponents[Component];
			}catch(e:Error){
				throw new Error("Component " + Component + " not found on entity " + entityId);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeComponent(entityId:String,Component:Class):void{
			removeEntityFromFamilies(entityId,Component);
			delete _components[entityId][Component];
		}
		
		/**
		 * @inheritDoc
		 */
		public function getEntityFamily(...Components):IFamily{
			return getFamily(Components);
		}
			
		/**
		 * @inheritDoc
		 */
		public function dispose():void {
			_components = null;	
			for each(var family:IFamily in _families){
				family.dispose();
			}
			_families = null;
			_componentFamilyMap = null;
			_currentKey = 0;
		}
		
		//---------------------------------------------------------------------
		// Internal
		//---------------------------------------------------------------------

		/**
		 * gets all Entities with specifed Components
		 */ 
		private function getEntitiesAllComposingOf(Components:Array):Vector.<IEntity>{
			var entityList:Vector.<IEntity> = new Vector.<IEntity>();
			for(var entityId:String in _components){
				if(hasAllComponents(entityId,Components)){
					entityList.push(new Entity(this,entityId));
				}
			}
			return entityList;
		}
		
		/**
		 * checks if a entity has a set of Components
		 */ 
		private function hasAllComponents(entityId:String,Components:Array):Boolean{
			for each(var Component:Class in Components){
				if(!_components[entityId][Component]){
					return false;
				}	
			}
			return true;
		}
		
		/**
		 * updates families when a component is added to an entity
		 */ 
		private function addEntityToFamilies(entityId:String,Component:Class):void{
			var families:Vector.<Array> = getFamiliesWithComponent(Component);				
			for each(var Components:Array in getFamiliesWithComponent(Component)){
				if(hasAllComponents(entityId,Components)){
					var family:IFamily = getFamily(Components);
					var newEntity:Entity =  new Entity(this,entityId)
					family.entities.push(newEntity);
					family.entityAdded.dispatch(newEntity);
				}
			}
		}		
		
		/**
		 * updates families when a component is removed from an entity
		 */ 
		private function removeEntityFromFamilies(entityId:String,Component:Class):void{		
			for each(var Components:Array in getFamiliesWithComponent(Component)){
				var family:IFamily = getFamily(Components);
				for(var i:int=0; i<family.entities.length; i++){
					var entity:IEntity = family.entities[i] as IEntity;
					if(entity.id == entityId){
						family.entities.splice(i,1)
						family.entityRemoved.dispatch(entity);
					}
				}
			}
		}
		
		private function removeFamily(Components:Array):void{
			_families[Components].destroy();
			delete _families[Components];
			
			for each(var familyRefList:Vector.<Array> in _componentFamilyMap){
				for(var i:int=0; i<familyRefList.length; i++){
					if(familyRefList[i] == Components){
						familyRefList.splice(i,1);
						i--;
					}
				}
			}
		}
		
		/**
		 * gets class name from instance
		 */
		private function getClass(obj:Object):Class{
			return Class(getDefinitionByName(getQualifiedClassName(obj)));
		}
			
		/**
		 * retrieves a list of Families with Component or creates a new one
		 */
		private function getFamiliesWithComponent(Component:Class):Vector.<Array>{
			return _componentFamilyMap[Component] ||= new Vector.<Array>();
		}
		
		/**
		 * retrieves an existing Family with set of Components or creates a new one
		 */
		private function getFamily(components:Array):IFamily{
			return _families[components] ||= newFamily(components);
		}
		
		/**
		 * creates a new family and updates references
		 */
		private function newFamily(components:Array):IFamily{
			for each(var Component:Class in components){
				getFamiliesWithComponent(Component).push(components);
			}
			var family:Family = new Family(components);
			family.entities = getEntitiesAllComposingOf(components)
			return family;
		}

		
	}
	
}