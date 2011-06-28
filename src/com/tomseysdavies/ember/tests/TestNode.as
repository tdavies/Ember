package com.tomseysdavies.ember.tests
{
	import com.tomseysdavies.ember.base.Node;
	
	import flash.utils.Dictionary;
	
	public class TestNode extends Node
	{
		
		public static const componentClasses:Array = [ComponentA,ComponentB];
		
		
		
		public function TestNode(entityID:String, components:Dictionary)
		{
			super(entityID, components);
		}
	}
}