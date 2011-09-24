/*
* Copyright (c) 2010 Tom Davies
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package com.tomseysdavies.ember.base{
	
	import com.tomseysdavies.ember.core.IDisposable;
	import com.tomseysdavies.ember.core.ISystem;
	import com.tomseysdavies.ember.core.ISystemManager;
	
	import flash.utils.Dictionary;
	
	import org.swiftsuspenders.Injector;

	
	/**
	 * responsible for registering and unregistering systems
	 * @author Tom Davies
	 */
	public class SystemManager implements ISystemManager{
		
		private var _injector:Injector;
		private var _systems:Dictionary;
		
		/**
		 * Creates a new <code>SystemManager</code> object
		 *
		 * @param injector An <code>Injector</code> to use for this game
		 */
		public function SystemManager(injector:Injector){
			_injector = injector;
			_systems = new Dictionary();
		}
		
		/**
		 * @inheritDoc
		 */
		public function addSystem(System:Class):*{
			if(_systems[System] != null){
				trace("Warning system "+System+" already exists in system manager");
			}
			var system:ISystem = _injector.instantiate(System);
			_systems[System] = system;
			system.onRegister();
			return system;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeSystem(System:Class):void{
			try{
				ISystem( _systems[System] ).dispose();
				delete _systems[System];
			}catch(e:Error){
				trace("Warning system "+ System +" dosn't exist in system manager");
			}
		}

		/**
		 * @inheritDoc
		 */
		public function dispose():void{
			for each(var item:IDisposable in _systems) {
				item.dispose();
			}
			_systems = new Dictionary();
		}

	}
}