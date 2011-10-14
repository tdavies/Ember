package net.richardlord.asteroidsember.nodes
{
	import net.richardlord.asteroidsember.components.Bullet;

	import com.tomseysdavies.ember.base.Node;

	import flash.utils.Dictionary;

	public class BulletAgeNode extends Node
	{
		public static const componentClasses : Array = [ Bullet ];
		
		public var bullet : Bullet;
		
		public function BulletAgeNode( entityID : String, components : Dictionary )
		{
			super( entityID, components );
			bullet = components[ Bullet ];
		}
	}
}
