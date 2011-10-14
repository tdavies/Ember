package net.richardlord.asteroidsember.nodes
{
	import net.richardlord.asteroidsember.components.Gun;
	import net.richardlord.asteroidsember.components.GunControls;
	import net.richardlord.asteroidsember.components.Position;

	import com.tomseysdavies.ember.base.Node;

	import flash.utils.Dictionary;

	public class GunControlNode extends Node
	{
		public static const componentClasses : Array = [ GunControls, Gun, Position ];
		
		public var control : GunControls;
		public var gun : Gun;
		public var position : Position;
		
		public function GunControlNode( entityID : String, components : Dictionary )
		{
			super( entityID, components );
			control = components[ GunControls ];
			gun = components[ Gun ];
			position = components[ Position ];
		}
	}
}
