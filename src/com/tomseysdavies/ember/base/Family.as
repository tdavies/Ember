package com.tomseysdavies.ember.base
{
	import com.tomseysdavies.ember.core.IEntity;
	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IFamily;
	
	import org.osflash.signals.Signal;
	
	internal class Family implements IFamily
	{
		
		private const ENTITY_ADDED:Signal = new Signal(IEntity);
		private const ENTITY_REMOVED:Signal = new Signal(IEntity);
		private var _entities:Vector.<IEntity>;
		private var _loopSignal:Signal;
		private var _currentEntity:IEntity;
		private var _components:Array;
		private var _canceled:Boolean
		
		public function Family(components:Array)
		{
			_components = components;
			_loopSignal = new Signal();
			_loopSignal.valueClasses = _components;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get entities():Vector.<IEntity>{
			return _entities;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set entities(value:Vector.<IEntity>):void{
			_entities = value;
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
		public function get iterator():Signal{
			return _loopSignal;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get size():uint{
			if(_entities == null) return 0;
			return _entities.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function startIterator():void{
			_canceled = false;
			for each(var entity:IEntity in _entities){
				_currentEntity = entity;
				_loopSignal.dispatch.apply(this,extractComponents(entity));
				if(_canceled){
					break;
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function stopIterator():void{
			_canceled = true;
		}
		
		/**
		 * @inheritDoc
		 */
		private function extractComponents(entity:IEntity):Array{
			var components:Array = [];
			for each(var Component:Class in _components){
				components.push(entity.getComponent(Component));
			}
			return components;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get currentEntity():IEntity{
			return _currentEntity;
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void{
			_entities = null;
			ENTITY_ADDED.removeAll();
			ENTITY_REMOVED.removeAll();
			_loopSignal.removeAll();
		}
	}
}