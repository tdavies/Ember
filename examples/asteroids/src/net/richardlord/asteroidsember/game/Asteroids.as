package net.richardlord.asteroidsember.game
{
	import net.richardlord.asteroidsember.components.GameState;
	import net.richardlord.asteroidsember.signals.*;
	import net.richardlord.asteroidsember.systems.*;
	import net.richardlord.utils.KeyPoll;

	import com.tomseysdavies.ember.base.Game;

	import flash.display.DisplayObjectContainer;

	public class Asteroids extends Game
	{
		[Inject]
		public var entityCreator : EntityCreator;
		
		[Inject]
		public var gameState : GameState;
		
		public function Asteroids( contextView : DisplayObjectContainer = null )
		{
			super( contextView );
		}
		
		override protected function startUp() : void
		{
			injector.injectInto( this );
			
			gameState.level = 0;
			gameState.lives = 3;
			gameState.points = 0;
			gameState.width = contextView.stage.stageWidth;
			gameState.height = contextView.stage.stageHeight;
			
			addSystems();
		}
		
		override protected function mapInjectors() : void
		{
			super.mapInjectors();
			injector.mapSingleton( EntityCreator );
			injector.mapSingleton( GameState );
			injector.mapSingleton( PreUpdate );
			injector.mapSingleton( Update );
			injector.mapSingleton( Move );
			injector.mapSingleton( ResolveCollisions );
			injector.mapSingleton( Render );
			injector.mapValue( KeyPoll, new KeyPoll( contextView.stage ) );
		}
		
		private function addSystems() : void
		{
			systemManager.addSystem( GameManager );
			systemManager.addSystem( MotionControlSystem );
			systemManager.addSystem( GunControlSystem );
			systemManager.addSystem( BulletAgeSystem );
			systemManager.addSystem( MovementSystem );
			systemManager.addSystem( CollisionSystem );
			systemManager.addSystem( RenderSystem );
			systemManager.addSystem( ProcessManager );
		}
	}
}
