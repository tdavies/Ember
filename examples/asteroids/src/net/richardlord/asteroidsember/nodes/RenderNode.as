package net.richardlord.asteroidsember.nodes
{
	import net.richardlord.asteroidsember.components.Display;
	import net.richardlord.asteroidsember.components.Position;

	import com.tomseysdavies.ember.base.Node;

	import flash.utils.Dictionary;

	public class RenderNode extends Node
	{
		public static const componentClasses : Array = [ Position, Display ];
		
		public var position : Position;
		public var display : Display;
		
		public function RenderNode( entityID : String, components : Dictionary )
		{
			super( entityID, components );
			position = components[ Position ];
			display = components[ Display ];
		}
	}
}
