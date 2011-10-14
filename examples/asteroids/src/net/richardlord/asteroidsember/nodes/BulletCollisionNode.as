package net.richardlord.asteroidsember.nodes
{
	import net.richardlord.asteroidsember.components.Bullet;
	import net.richardlord.asteroidsember.components.Position;

	import com.tomseysdavies.ember.base.Node;

	import flash.utils.Dictionary;

	public class BulletCollisionNode extends Node
	{
		public static const componentClasses : Array = [ Bullet, Position ];
		
		public var bullet : Bullet;
		public var position : Position;
		
		public function BulletCollisionNode( entityID : String, components : Dictionary )
		{
			super( entityID, components );
			bullet = components[ Bullet ];
			position = components[ Position ];
		}
	}
}
