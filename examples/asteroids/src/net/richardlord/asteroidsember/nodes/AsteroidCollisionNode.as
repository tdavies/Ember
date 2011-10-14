package net.richardlord.asteroidsember.nodes
{
	import net.richardlord.asteroidsember.components.Asteroid;
	import net.richardlord.asteroidsember.components.Position;

	import com.tomseysdavies.ember.base.Node;

	import flash.utils.Dictionary;

	public class AsteroidCollisionNode extends Node
	{
		public static const componentClasses : Array = [ Asteroid, Position ];
		
		public var asteroid : Asteroid;
		public var position : Position;
		
		public function AsteroidCollisionNode( entityID : String, components : Dictionary )
		{
			super( entityID, components );
			asteroid = components[ Asteroid ];
			position = components[ Position ];
		}
	}
}
