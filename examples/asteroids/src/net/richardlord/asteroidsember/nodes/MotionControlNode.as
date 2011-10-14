package net.richardlord.asteroidsember.nodes
{
	import net.richardlord.asteroidsember.components.Motion;
	import net.richardlord.asteroidsember.components.MotionControls;
	import net.richardlord.asteroidsember.components.Position;

	import com.tomseysdavies.ember.base.Node;

	import flash.utils.Dictionary;

	public class MotionControlNode extends Node
	{
		public static const componentClasses : Array = [ MotionControls, Position, Motion ];
		
		public var control : MotionControls;
		public var position : Position;
		public var motion : Motion;
		
		public function MotionControlNode( entityID : String, components : Dictionary )
		{
			super( entityID, components );
			control = components[ MotionControls ];
			position = components[ Position ];
			motion = components[ Motion ];
		}
	}
}
