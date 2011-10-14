package net.richardlord.asteroidsember.systems
{
	import net.richardlord.asteroidsember.components.GameState;
	import net.richardlord.asteroidsember.game.EntityCreator;
	import net.richardlord.asteroidsember.nodes.AsteroidCollisionNode;
	import net.richardlord.asteroidsember.nodes.SpaceshipCollisionNode;
	import net.richardlord.asteroidsember.nodes.BulletCollisionNode;
	import net.richardlord.asteroidsember.signals.PreUpdate;

	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IFamily;
	import com.tomseysdavies.ember.core.ISystem;

	import flash.geom.Point;

	public class GameManager implements ISystem
	{
		[Inject]
		public var entityManager : IEntityManager;
		
		[Inject]
		public var entityCreator : EntityCreator;
		
		[Inject]
		public var gameState : GameState;

		[Inject]
		public var tick : PreUpdate;

		private var spaceships : IFamily;
		private var asteroids : IFamily;
		private var bullets : IFamily;

		public function onRegister() : void
		{
			spaceships = entityManager.getEntityFamily( SpaceshipCollisionNode );
			asteroids = entityManager.getEntityFamily( AsteroidCollisionNode );
			bullets = entityManager.getEntityFamily( BulletCollisionNode );
			tick.add( update );
		}

		private function update() : void
		{
			if( spaceships.empty )
			{
				if( gameState.lives > 0 )
				{
					var newSpaceshipPosition : Point = new Point( gameState.width * 0.5, gameState.height * 0.5 );
					var clearToAddSpaceship : Boolean = true;
					for( asteroids.start(); asteroids.hasNext; asteroids.next() )
					{
						var asteroid : AsteroidCollisionNode = asteroids.currentNode;
						if( Point.distance( asteroid.position.position, newSpaceshipPosition ) <= asteroid.position.collisionRadius + 50 )
						{
							clearToAddSpaceship = false;
							break;
						}
					}
					if( clearToAddSpaceship )
					{
						entityCreator.createSpaceship();
						gameState.lives--;
					}
				}
				else
				{
					// game over
				}
			}
			
			if( asteroids.empty && bullets.empty && !spaceships.empty )
			{
				// next level
				spaceships.start();
				var spaceship : SpaceshipCollisionNode = spaceships.currentNode;
				gameState.level++;
				var asteroidCount : int = 2 + gameState.level;
				for( var i:int = 0; i < asteroidCount; ++i )
				{
					// check not on top of spaceship
					do
					{
						var position : Point = new Point( Math.random() * gameState.width, Math.random() * gameState.height );
					}
					while ( Point.distance( position, spaceship.position.position ) <= 80 );
					entityCreator.createAsteroid( 30, position.x, position.y );
				}
			}
		}

		public function dispose() : void
		{
			tick.remove( update );
		}
	}
}
