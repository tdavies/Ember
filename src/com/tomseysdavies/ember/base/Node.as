package com.tomseysdavies.ember.base
{
	import flash.utils.Dictionary;

	public class Node
	{
		
		public var next:Node;
		public var previous:Node;
		public var entityID:String;
		
		public function Node(entityID:String,components:Dictionary)
		{
			this.entityID = entityID;
		}

	}
}