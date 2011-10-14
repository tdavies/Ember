package net.richardlord.asteroidsember.systems
{
	import net.richardlord.asteroidsember.components.Bullet;
	import net.richardlord.asteroidsember.game.EntityCreator;
	import net.richardlord.asteroidsember.nodes.BulletAgeNode;
	import net.richardlord.asteroidsember.signals.Update;

	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IFamily;
	import com.tomseysdavies.ember.core.ISystem;

	public class BulletAgeSystem implements ISystem
	{
		[Inject]
		public var entityManager : IEntityManager;
		
		[Inject]
		public var entityCreator : EntityCreator;
		
		[Inject]
		public var tick : Update;
		
		private var family : IFamily;

		public function onRegister() : void
		{
			family = entityManager.getEntityFamily( BulletAgeNode );
			tick.add( update );
		}

		private function update( time : Number ) : void
		{
			var node : BulletAgeNode;
			var bullet : Bullet;

			for ( family.start(); family.hasNext; family.next() )
			{
				node = family.currentNode;
				bullet = node.bullet;

				bullet.lifeRemaining -= time;
				if ( bullet.lifeRemaining <= 0 )
				{
					entityCreator.destroyEntity( node.entityID );
				}
			}
		}

		public function dispose() : void
		{
			tick.remove( update );
		}
	}
}
