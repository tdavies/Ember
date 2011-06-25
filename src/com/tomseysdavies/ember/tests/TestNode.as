package com.tomseysdavies.ember.tests
{
	import com.tomseysdavies.ember.base.Node;
	
	import flash.utils.Dictionary;
	
	public class TestNode extends Node
	{
		
		public static const componentClasses:Array = [ComponentA,ComponentB];
		public var componentA:ComponentA;
		public var componentB:ComponentB;
		
		public function TestNode(entityID:String, components:Dictionary)
		{
			componentA = components[ComponentA];
			componentB = components[componentB];
			super(entityID, components);
		}
				
		public function get nextNode():TestNode
		{
			return next as TestNode;
		}
	}
}