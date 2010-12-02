/*
* Copyright (c) 2010 Tom Davies
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package com.tomseysdavies.ember.base {
	import com.tomseysdavies.ember.core.IEntity;
	import com.tomseysdavies.ember.core.IEntityManger;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * manages the relations between compoments and entites and keeps entity families upto date.
	 * @author Tom Davies
	 */
	public class EntityManager implements IEntityManger {
		
		private var _components:Dictionary;
		private var _families:Object;
		private var _componentFamilyMap:Dictionary;
		private var _currentKey:int;
		
		public function EntityManager() {
			_components = new Dictionary();
			_families = new Object();
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
			if(key == null){
				_currentKey ++;
				key = "id_" + _currentKey;
			}			
			var entity:IEntity = new Entity(this,key);
			_components[entity.id] = new Dictionary();
			return entity;
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
		public function addComponent(entityId:String,compoment:Object):void{
			var Compoment:Class = getClass(compoment);
			_components[entityId][Compoment] = compoment;
			addEntityToFamilies(entityId,Compoment);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getComponent(entityId:String,Component:Class):*{	
			return _components[entityId][Component];
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
		public function getEntityFamily(...Components):Vector.<IEntity>{
			Components.sort();
			return getFamily(Components);
		}
			
		/**
		 * @inheritDoc
		 */
		public function destroy():void {
			_components = null;
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
		private function getAllComposingX(Components:Array):Vector.<IEntity>{
			var entityList:Vector.<IEntity> = new Vector.<IEntity>;
			for(var entityId:String in _components){
				//var enity:IEntity = e as IEntity;
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
					var family:Vector.<IEntity> = getFamily(Components);
					family.push(new Entity(this,entityId));
				}
			}
		}		
		
		/**
		 * updates families when a component is removed from an entity
		 */ 
		private function removeEntityFromFamilies(entityId:String,Component:Class):void{
			var families:Vector.<Array> = getFamiliesWithComponent(Component);			
			for each(var Components:Array in getFamiliesWithComponent(Component)){
				var family:Vector.<IEntity> = getFamily(Components);
				for(var i:int=0; i<family.length; i++){
					var entity:IEntity = family[i] as IEntity;
					if(entity.id == entityId){
						family.splice(i,1)
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
		private function getFamily(Components:Array):Vector.<IEntity>{
			return _families[Components] ||= newFamily(Components);
		}		
		
		/**
		 * creates a new family and updates references
		 */
		private function newFamily(Components:Array):Vector.<IEntity>{
			for each(var Component:Class in Components){
				getFamiliesWithComponent(Component).push(Components);
			}
			return getAllComposingX(Components);
		}

		
	}
	
}