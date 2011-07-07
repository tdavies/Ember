package com.tomseysdavies.ember.base
{
	import com.tomseysdavies.ember.core.IEntity;
	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IFamily;
	
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	
	final public class Family implements IFamily
	{

		private const ENTITY_ADDED:Signal = new Signal(String);
		private const ENTITY_REMOVED:Signal = new Signal(String);
		private var _last:Node;
		private var _first:Node;
		private var _nodeMap:Dictionary;
		private var _currentNode:Node;
		private var _Node:Class;
		private var _hasNext:Boolean
		
		public function Family(Node:Class)
		{
			_Node = Node;
			_nodeMap = new Dictionary(true);
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
				node.previous = _last;
			}else{				
				_first = node;
			}
			_last = node;
			_nodeMap[entityId] = node;
			entityAdded.dispatch(entityId);
		}
		
		public function remove(entityId:String):void{
			entityRemoved.dispatch(entityId);
			var node:Node = _nodeMap[entityId];
			if(!node) return;
			
			if(node.previous){
				node.previous.next = node.next;
			}else{
				_first = node.next;			
			}
			if(node.next){
				node.next.previous = node.previous;	
			}else{
				_last = node.previous;		
			}
			updateNode(node.next);
			node.next = node.previous = null;
			node.entityID = null;
			node.dispose();
			_nodeMap[entityId] = null;
			delete _nodeMap[entityId];
			
		}
		
		public function start():void{
			updateNode(_first);
		}
		
		public function next():void{
			if(_currentNode){
				_currentNode = _currentNode.next;
			}
			_hasNext = (_currentNode != null);
		}
		
		public function get hasNext():Boolean{
			return _hasNext;
		}
		
		private function updateNode(node:Node):void{
			_currentNode = node;
			_hasNext = (currentNode != null);
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
		
		public function get currentNode():*{
			return _currentNode;
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