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
		
		private var _entityMap:Dictionary;
		private var _families:Dictionary;
		private var _componentFamilyMap:Dictionary;
		private var _currentKey:int;
		
		public function EntityManager() {
			_entityMap = new Dictionary(true);
			_families = new Dictionary(true);
			_componentFamilyMap = new Dictionary(true);
			_currentKey = 0;
		}
		
		//---------------------------------------------------------------------
		// API
		//---------------------------------------------------------------------
		
		
		/**
		 * @inheritDoc
		 */
		public function assignEntity(id:String = null):String{
			var key:String = id; 
			if(key == null || key == ""){
				_currentKey ++;
				key = "id_" + _currentKey;
			}else if(_entityMap[id]){
				throw new Error("Entity " + id + " already exisits in Entity Manager");
			}
			_entityMap[key] = new Dictionary(true);
			return key;
		}
		
		/**
		 * @inheritDoc
		 */
		public function createEntity(id:String = null):IEntity{
			return new Entity(this,assignEntity(id));
		}
		
		/**
		 * @inheritDoc
		 */
		public function hasEntity(id:String):Boolean
		{
			return (_entityMap[id]);
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeEntity(entityId:String):void {
			
			if(!hasEntity(entityId)){
				throw new Error("Entity " + entityId + " not found in Entity Manager");
			}
			for each(var component:Object in _entityMap[entityId]){				
				removeEntityFromFamilies(entityId,getClass(component));
			}
			_entityMap[entityId] = null;
			delete _entityMap[entityId];
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAll():void {
			for(var entityId:String in _entityMap){
				removeEntity(entityId);
			}
			_currentKey = 0;
		}
				
		
		/**
		 * @inheritDoc
		 */
		public function addComponent(entityId:String,component:Object):void{
			if(!hasEntity(entityId)){
				throw new Error("Entity " + entityId + " not found in Entity Manager");
			}
			var Component:Class = getClass(component);			
			_entityMap[entityId][Component] = component;
			addEntityToFamilies(entityId,Component);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getComponent(entityId:String,Component:Class):*{
			var component:* =  _entityMap[entityId][Component];
			if(!component){
				if(!hasEntity(entityId)){
					throw new Error("Entity " + entityId + " not found in Entity Manager");
				}else{
					throw new Error("Component " + Component + " not found on entity " + entityId);
				}				
			}else{
				return component;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function getComponents(entityId:String):Dictionary{
			return _entityMap[entityId];
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeComponent(entityId:String,Component:Class):void{
			removeEntityFromFamilies(entityId,Component);
			delete _entityMap[entityId][Component];
		}
		
		/**
		 * @inheritDoc
		 */
		public function getEntityFamily(Node:Class):IFamily{
			return getFamily(Node);
		}
			
		/**
		 * @inheritDoc
		 */
		public function dispose():void {
			_entityMap = null;	
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
		private function poputlateFamily(family:IFamily,Components:Array):void{
			for(var entityId:String in _entityMap){
				if(hasAllComponents(entityId,Components)){
					family.add(entityId,_entityMap[entityId]);
				}
			}
		}
		
		/**
		 * checks if a entity has a set of Components
		 */ 
		private function hasAllComponents(entityId:String,Components:Array):Boolean{
			for each(var Component:Class in Components){
				if(!_entityMap[entityId][Component]){
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
			for each(var Components:Array in families){
				if(hasAllComponents(entityId,Components)){
					_families[Components].add(entityId,_entityMap[entityId]);
				}
			}
		}		
		
		/**
		 * updates families when a component is removed from an entity
		 */ 
		private function removeEntityFromFamilies(entityId:String,Component:Class):void{		
			for each(var Components:Array in getFamiliesWithComponent(Component)){
				_families[Components].remove(entityId);
			}
		}
		
		private function removeFamily(Components:Array):void{
			_families[Components].dispose();
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
		private function getFamily(Node:Class):IFamily{
			return _families[Node.componentClasses] ||= newFamily(Node,Node.componentClasses);
		}
		
		/**
		 * creates a new family and updates references
		 */
		private function newFamily(Node:Class,components:Array):IFamily{
			for each(var Component:Class in components){
				getFamiliesWithComponent(Component).push(components);
			}
			var family:Family = new Family(Node);
			poputlateFamily(family,components)
			return family;
		}

	}
	
}