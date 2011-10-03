package com.tomseysdavies.ember.core
{
	import com.tomseysdavies.ember.base.Node;
	
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;

	public interface IFamily extends IDisposable
	{
		
		
			
		function remove(entiyId:String):void
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
		function get empty():Boolean;
		
		function add(entiyId:String,components:Dictionary):void;
		function get first():Node;
		function get last():Node;
		function start():void;
		function next():void;
		function get hasNext():Boolean;
		function get currentNode():*;
		
		function get size():int;

	}
}