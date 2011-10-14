package net.richardlord.asteroidsember.systems
{
	import net.richardlord.asteroidsember.components.Motion;
	import net.richardlord.asteroidsember.components.MotionControls;
	import net.richardlord.asteroidsember.components.Position;
	import net.richardlord.asteroidsember.nodes.MotionControlNode;
	import net.richardlord.asteroidsember.signals.Update;
	import net.richardlord.utils.KeyPoll;

	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IFamily;
	import com.tomseysdavies.ember.core.ISystem;

	import flash.display.DisplayObjectContainer;

	public class MotionControlSystem implements ISystem
	{
		[Inject]
		public var entityManager : IEntityManager;

		[Inject]
		public var tick : Update;

		[Inject]
		public var contextView : DisplayObjectContainer;

		[Inject]
		public var keyPoll : KeyPoll;

		private var family : IFamily;

		public function onRegister() : void
		{
			family = entityManager.getEntityFamily( MotionControlNode );
			tick.add( update );
		}

		private function update( time : Number ) : void
		{
			var node : MotionControlNode;
			var control : MotionControls;
			var position : Position;
			var motion : Motion;

			for ( family.start(); family.hasNext; family.next() )
			{
				node = family.currentNode;
				control = node.control;
				position = node.position;
				motion = node.motion;

				if ( keyPoll.isDown( control.left ) )
				{
					position.rotation -= control.rotationRate * time;
				}

				if ( keyPoll.isDown( control.right ) )
				{
					position.rotation += control.rotationRate * time;
				}

				if ( keyPoll.isDown( control.accelerate ) )
				{
					motion.velocity.x += Math.cos( position.rotation ) * control.accelerationRate * time;
					motion.velocity.y += Math.sin( position.rotation ) * control.accelerationRate * time;
				}
			}
		}

		public function dispose() : void
		{
			tick.remove( update );
		}
	}
}
