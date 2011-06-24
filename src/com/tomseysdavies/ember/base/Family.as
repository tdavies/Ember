package com.tomseysdavies.ember.base
{
	import com.tomseysdavies.ember.core.IEntity;
	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IFamily;
	
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	
	internal class Family implements IFamily
	{
		
		private const ENTITY_ADDED:Signal = new Signal(String);
		private const ENTITY_REMOVED:Signal = new Signal(String);
		private var _entities:Vector.<String>;
		private var _components:Dictionary;
		private var _index:uint;
		private var _id:String;
		private var _entityManager:EntityManager;
		
		public function Family(entityManager:EntityManager)
		{
			_entityManager = entityManager;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get entities():Vector.<String>{
			return _entities;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set entities(value:Vector.<String>):void{
			_entities = value;
			reset();
		}
		
		
		/**
		 * @inheritDoc
		 */
		public function get entityAdded():Signal{
			return ENTITY_ADDED;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get entityRemoved():Signal{
			return ENTITY_REMOVED;
		}
				
		/**
		 * @inheritDoc
		 */
		public function get size():uint{
			if(_entities == null) return 0;
			return _entities.length;
		}
		
		public function reset():void{
			_index = 0;
		}
		
		public function hasNext():Boolean{
			return (_index < size);
		}
		
		public function getNext():void{
			_id = _entities[_index];
			_components =  _entityManager.getComponents(_id);
			_index ++;
		}
		
		public function get id():String{
			return _id;
		}
		
		public function get components():Dictionary{
			return _components;
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void{
			_entityManager = null;
			_entities = null;
			ENTITY_ADDED.removeAll();
			ENTITY_REMOVED.removeAll();
		}
	}
}