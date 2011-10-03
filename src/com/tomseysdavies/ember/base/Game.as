/*
* Copyright (c) 2010 Tom Davies
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package com.tomseysdavies.ember.base{
	
	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IGame;
	import com.tomseysdavies.ember.core.ISystemManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import org.swiftsuspenders.Injector;
	
	public class Game implements IGame  {

		private var _contextView:DisplayObjectContainer;
		private var _entityManager:IEntityManager;
		private var _systemManager:ISystemManager;
		private var _injector:Injector;
		
		
		/**
		 * Abstract IGame Implementation
		 *
		 * <p>Extend this class to create a Game</p>
		 */
		public function Game(contextView:DisplayObjectContainer = null){
			_contextView = contextView;
			if(_contextView){
				mapInjectors();
				startUp();
			}
		}
		
		
		/**
		 * The Startup Hook
		 *
		 * <p>Override this in your Game</p>
		 */
		protected function startUp():void{
			
		}
		
		/**
		 * The ShutDown Hook
		 *
		 * <p>Override this in your Game</p>
		 */
		protected function shutDown():void{
			
		}		
		
		/**
		 * Injection Mapping Hook
		 *
		 * <p>Override this in your Game if you want to customise</p>
		 */
		protected function mapInjectors():void{
			injector.mapValue(IEntityManager,entityManager);
			injector.mapValue(DisplayObjectContainer,contextView);
		} 
		
		/**
		 * @inheritDoc
		 */
		public function set contextView(value:DisplayObjectContainer):void{
			_contextView = value;
			checkAutoStartup();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get contextView():DisplayObjectContainer{
			return _contextView;
		}
		
		/**
		 * @inheritDoc
		 */
		final public function dispose():void{
			_entityManager.dispose();
			_entityManager = null;
			_systemManager.dispose();
			_systemManager = null;
			_contextView = null;
			_injector = null;
			shutDown();
		}
		
		/**
		* The <code>Injector</code> for this <code>IGame</code>
		*/
		protected function get injector():Injector{
			return _injector || (_injector = new Injector());
		}
		
		/**
		 * The <code>IEntityManger</code> for this <code>IGame</code>
		 */
		protected function get entityManager():IEntityManager{
			return _entityManager || (_entityManager = new EntityManager());
		}
		
		/**
		 * The <code>ISystemManager</code> for this <code>IGame</code>
		 */
		protected function get systemManager():ISystemManager{
			return _systemManager || (_systemManager = new SystemManager(injector));
		}
		
		//---------------------------------------------------------------------
		// Internal
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function checkAutoStartup():void{
			if (contextView){
				mapInjectors();
				contextView.stage ? startUp() : contextView.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
			}
		}
		
		/**
		 * @private
		 */
		private function onAddedToStage(event:Event):void{
			startUp();
		}
		
		
				
	}	
	
}