package net.richardlord.asteroidsember.nodes
{
	import net.richardlord.asteroidsember.components.Position;
	import net.richardlord.asteroidsember.components.Spaceship;

	import com.tomseysdavies.ember.base.Node;

	import flash.utils.Dictionary;

	public class SpaceshipCollisionNode extends Node
	{
		public static const componentClasses : Array = [ Spaceship, Position ];
		
		public var spaceship : Spaceship;
		public var position : Position;
		
		public function SpaceshipCollisionNode( entityID : String, components : Dictionary )
		{
			super( entityID, components );
			spaceship = components[ Spaceship ];
			position = components[ Position ];
		}
	}
}
