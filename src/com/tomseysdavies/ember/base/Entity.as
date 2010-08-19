/*
* Copyright (c) 2010 Tom Davies
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package com.tomseysdavies.ember.base{
		
	import com.tomseysdavies.ember.core.IEntity;
	import com.tomseysdavies.ember.core.IEntityManger;
	
	
	/**
	 * this is just a unique key used to retrieve components. It also has some helper function for convenience.
	 * @author Tom Davies
	 */
	public class Entity implements IEntity{

		private var _entityManger:IEntityManger;
				
		public function Entity(){
		}
		
		/**
		 * @inheritDoc
		 */
		public function addComponent(component:Object):void {
			return _entityManger.addComponent(this,component);
		}

		/**
		 * @inheritDoc
		 */
		public function getComponent(Component:Class):* {
			return _entityManger.getComponent(this,Component);						
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeComponent(Component:Class):void {
			_entityManger.removeComponent(this,Component);
		}
		
		/**
		 * @inheritDoc
		 */
		public function destroy():void{
			_entityManger.removeEntity(this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function set manager(value:IEntityManger):void{
			_entityManger = value;
		}

	}
}