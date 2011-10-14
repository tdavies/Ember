package net.richardlord.asteroidsember.systems
{
	import net.richardlord.asteroidsember.signals.Move;
	import net.richardlord.asteroidsember.signals.PreUpdate;
	import net.richardlord.asteroidsember.signals.Render;
	import net.richardlord.asteroidsember.signals.ResolveCollisions;
	import net.richardlord.asteroidsember.signals.Update;

	import com.tomseysdavies.ember.core.ISystem;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.getTimer;

	public class ProcessManager implements ISystem
	{
		private static const MAX_FRAME_TIME : Number = 0.05;
		
		[Inject]
		public var preUpdate : PreUpdate;
		
		[Inject]
		public var update : Update;
		
		[Inject]
		public var move : Move;
		
		[Inject]
		public var resolveCollisions : ResolveCollisions;
		
		[Inject]
		public var render : Render;
		
		[Inject]
		public var viewContext : DisplayObjectContainer;
		
		private var time : uint;

		public function onRegister() : void
		{
			time = getTimer();
			viewContext.addEventListener( Event.ENTER_FRAME, frameUpdate );
		}

		private function frameUpdate( event : Event ) : void
		{
			var oldTime : uint = time;
			time = getTimer();
			var frameTime : Number = ( time - oldTime ) / 1000;
			if( frameTime > MAX_FRAME_TIME )
			{
				frameTime = MAX_FRAME_TIME;
			}
			
			preUpdate.dispatch();
			update.dispatch( frameTime );
			move.dispatch( frameTime );
			resolveCollisions.dispatch( frameTime );
			render.dispatch();
		}

		public function dispose() : void
		{
			viewContext.removeEventListener( Event.ENTER_FRAME, frameUpdate );
		}
	}
}
