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
		private var _last:Node;
		private var _first:Node;
		private var _nodeMap:Dictionary;
		private var _Node:Class;
		
		public function Family(Node:Class)
		{
			_Node = Node;
			_nodeMap = new Dictionary();
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
		public function add(entityId:String,components:Dictionary):void{
			var node:Node = new _Node(entityId,components);
			if(_first){
				_last.next = node;
			}else{
				_first = node;
			}			
			node.previous = _last;
			_last = node;
			_nodeMap[entityId] = node;
			entityAdded.dispatch(entityId);
		}
		
		public function remove(entityId:String):void{
			var node:Node = _nodeMap[entityId];
			if(node.previous){
				node.previous.next = node.next;
			}else{
				if(node.next){
					_first = node;
				}else{
					_first = null;
				}				
			}
			if(node.next){
				node.next.previous = node.previous;
			}else{
				if(node.previous){
					_last = node;
				}else{
					_last = null;
				}				
			}
			
			node.next = node.previous = null;
			delete _nodeMap[entityId];
		}
		
		public function get empty():Boolean{
			return (!_first);
		}
				
		public function get first():Node{
			return _first;
		}
		public function get last():Node{
			return _last;
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void{
			ENTITY_ADDED.removeAll();
			ENTITY_REMOVED.removeAll();
		}
	}
}