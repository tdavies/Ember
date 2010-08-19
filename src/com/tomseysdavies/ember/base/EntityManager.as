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
		
		public function EntityManager() {
			_components = new Dictionary();
			_families = new Object();
			_componentFamilyMap = new Dictionary();
		}
		
		//---------------------------------------------------------------------
		// API
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function createEntity():IEntity{
			var entity:IEntity = new Entity();
			entity.manager = this;
			_components[entity] = new Dictionary();
			return entity;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeEntity(entity:IEntity):void {
			for each(var component:Object in _components[entity]){				
				removeEntityFromFamilies(entity,getClass(component));
			}
			delete _components[entity];
		}
		
		/**
		 * @inheritDoc
		 */
		public function addComponent(entity:IEntity,compoment:Object):void{
			var Compoment:Class = getClass(compoment);
			_components[entity][Compoment] = compoment;
			addEntityToFamilies(entity,Compoment);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getComponent(entity:IEntity,Component:Class):*{	
			return _components[entity][Component];
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeComponent(entity:IEntity,Component:Class):void{
			removeEntityFromFamilies(entity,Component);
			delete _components[entity][Component];
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
		}
		
		//---------------------------------------------------------------------
		// Internal
		//---------------------------------------------------------------------
		
		
		/**
		 * gets all Entities with specifed Components
		 */ 
		private function getAllComposingX(Components:Array):Vector.<IEntity>{
			var entityList:Vector.<IEntity> = new Vector.<IEntity>;
			for(var e:Object in _components){
				var enity:IEntity = e as IEntity;
				if(hasAllComponents(enity,Components)){
					entityList.push(enity);
				}
			}
			return entityList;
		}
		
		/**
		 * checks if a entity has a set of Components
		 */ 
		private function hasAllComponents(entity:IEntity,Components:Array):Boolean{
			for each(var Component:Class in Components){
				if(!_components[entity][Component]){
					return false;
				}	
			}
			return true;
		}
		
		/**
		 * updates families when a component is added to an entity
		 */ 
		private function addEntityToFamilies(entity:IEntity,Component:Class):void{
			var families:Vector.<Array> = getFamiliesWithComponent(Component);				
			for each(var Components:Array in getFamiliesWithComponent(Component)){
				if(hasAllComponents(entity,Components)){
					var family:Vector.<IEntity> = getFamily(Components);
					family.push(entity);
				}
			}
		}		
		
		/**
		 * updates families when a component is removed from an entity
		 */ 
		private function removeEntityFromFamilies(entity:IEntity,Component:Class):void{
			var families:Vector.<Array> = getFamiliesWithComponent(Component);			
			for each(var Components:Array in getFamiliesWithComponent(Component)){
				var family:Vector.<IEntity> = getFamily(Components);
				var index:int = family.indexOf(entity);
				if(index > -1){
					family.splice(family.indexOf(entity),1)
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