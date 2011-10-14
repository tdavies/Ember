package net.richardlord.asteroidsember.nodes
{
	import net.richardlord.asteroidsember.components.Motion;
	import net.richardlord.asteroidsember.components.Position;

	import com.tomseysdavies.ember.base.Node;

	import flash.utils.Dictionary;

	public class MovementNode extends Node
	{
		public static const componentClasses : Array = [ Position, Motion ];
		
		public var position : Position;
		public var motion : Motion;
		
		public function MovementNode( entityID : String, components : Dictionary )
		{
			super( entityID, components );
			position = components[ Position ];
			motion = components[ Motion ];
		}
	}
}
