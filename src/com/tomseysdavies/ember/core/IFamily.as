package com.tomseysdavies.ember.core
{
	import org.osflash.signals.Signal;

	public interface IFamily extends IDestroyable
	{
		
		
		/**
		 * vector of all entities in family
		 * 
		 */		
		function get entites():Vector.<IEntity>;
		function set entites(value:Vector.<IEntity>):void;
		/**
		 *signal that is dispached when entity is added to family. 
		 *
		 */	
		function get entityAdded():Signal;
		/**
		 *signal that is dispached when entity is remove from family.
		 *payload is the entity added
		 */	
		function get entityRemoved():Signal;
		/**
		 *signal that is dispached when interator increments
		 *payload is the entity removed 
		 */	
		function get iterator():Signal;
		/**
		 *the number of entities in the family
		 *payload is families components
		 */	
		function get size():uint;
		/**
		 *rests the cound and starts iterating though entities
		 * 
		 */	
		function startIterator():void;
		/**
		 *stop further iteration
		 * 
		 */	
		function stopIterator():void;
		/**
		 *get the current entity from the iterator
		 * 
		 */
		function get currentEntity():IEntity;
	}
}