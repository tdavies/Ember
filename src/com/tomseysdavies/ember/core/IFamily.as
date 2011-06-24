package com.tomseysdavies.ember.core
{
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;

	public interface IFamily extends IDisposable
	{
		
		/**
		 * vector of all entities in family
		 * 
		 */		
		function get entities():Vector.<String>;
		function set entities(value:Vector.<String>):void;
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
		 *the number of entities in the family
		 *payload is families components
		 */	
		function get size():uint;
		
		function reset():void;
		
		function hasNext():Boolean;
		
		function getNext():void;
		
		function get id():String;
		
		function get components():Dictionary;

	}
}