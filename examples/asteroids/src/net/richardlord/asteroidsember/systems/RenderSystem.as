package net.richardlord.asteroidsember.systems
{
	import net.richardlord.asteroidsember.components.Display;
	import net.richardlord.asteroidsember.components.Position;
	import net.richardlord.asteroidsember.nodes.RenderNode;
	import net.richardlord.asteroidsember.signals.Render;

	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IFamily;
	import com.tomseysdavies.ember.core.ISystem;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;



	public class RenderSystem implements ISystem
	{
		[Inject]
		public var contextView : DisplayObjectContainer;
		
		[Inject]
		public var entityManager : IEntityManager;
		
		[Inject]
		public var tick : Render;
		
		private var family : IFamily;
		
		public function onRegister() : void
		{
			family = entityManager.getEntityFamily( RenderNode );
			tick.add( render );
		}
		
		public function render() : void
		{
			var node : RenderNode;
			var position : Position;
			var display : Display;
			var displayObject : DisplayObject;
			
			for( family.start(); family.hasNext; family.next() )
			{
				node = family.currentNode;
				display = node.display;
				displayObject = display.displayObject;
				position = node.position;
				
				if( !displayObject.parent )
				{
					contextView.addChild( displayObject );
				}
				displayObject.x = position.position.x;
				displayObject.y = position.position.y;
				displayObject.rotation = position.rotation * 180 / Math.PI;
			}
		}

		public function dispose() : void
		{
			tick.remove( render );
		}
	}
}
