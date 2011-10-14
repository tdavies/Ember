package net.richardlord.asteroidsember.systems
{
	import net.richardlord.asteroidsember.game.EntityCreator;
	import net.richardlord.asteroidsember.nodes.AsteroidCollisionNode;
	import net.richardlord.asteroidsember.nodes.SpaceshipCollisionNode;
	import net.richardlord.asteroidsember.nodes.BulletCollisionNode;
	import net.richardlord.asteroidsember.signals.ResolveCollisions;

	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IFamily;
	import com.tomseysdavies.ember.core.ISystem;

	import flash.geom.Point;

	public class CollisionSystem implements ISystem
	{
		[Inject]
		public var entityManager : IEntityManager;

		[Inject]
		public var entityCreator : EntityCreator;

		[Inject]
		public var tick : ResolveCollisions;

		private var spaceships : IFamily;
		private var asteroids : IFamily;
		private var userBullets : IFamily;

		public function onRegister() : void
		{
			spaceships = entityManager.getEntityFamily( SpaceshipCollisionNode );
			asteroids = entityManager.getEntityFamily( AsteroidCollisionNode );
			userBullets = entityManager.getEntityFamily( BulletCollisionNode );
			tick.add( update );
		}

		private function update( time : Number ) : void
		{
			var bullet : BulletCollisionNode;
			var asteroid : AsteroidCollisionNode;
			var spaceship : SpaceshipCollisionNode;

			for ( userBullets.start(); userBullets.hasNext; userBullets.next() )
			{
				bullet = userBullets.currentNode;
				for ( asteroids.start(); asteroids.hasNext; asteroids.next() )
				{
					asteroid = asteroids.currentNode;
					if ( Point.distance( asteroid.position.position, bullet.position.position ) <= asteroid.position.collisionRadius )
					{
						entityCreator.destroyEntity( bullet.entityID );
						if ( asteroid.position.collisionRadius > 10 )
						{
							entityCreator.createAsteroid( asteroid.position.collisionRadius - 10, asteroid.position.position.x + Math.random() * 10 - 5, asteroid.position.position.y + Math.random() * 10 - 5 );
							entityCreator.createAsteroid( asteroid.position.collisionRadius - 10, asteroid.position.position.x + Math.random() * 10 - 5, asteroid.position.position.y + Math.random() * 10 - 5 );
						}
						entityCreator.destroyEntity( asteroid.entityID );
						break;
					}
				}
			}

			for ( spaceships.start(); spaceships.hasNext; spaceships.next() )
			{
				spaceship = spaceships.currentNode;
				for ( asteroids.start(); asteroids.hasNext; asteroids.next() )
				{
					asteroid = asteroids.currentNode;
					if ( Point.distance( asteroid.position.position, spaceship.position.position ) <= asteroid.position.collisionRadius + spaceship.position.collisionRadius )
					{
						entityCreator.destroyEntity( spaceship.entityID );
						break;
					}
				}
			}
		}

		public function dispose() : void
		{
			tick.remove( update );
		}
	}
}
