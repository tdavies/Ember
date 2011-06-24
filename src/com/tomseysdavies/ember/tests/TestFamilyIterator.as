package com.tomseysdavies.ember.tests
{
	import com.tomseysdavies.ember.base.EntityManager;
	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IFamily;
	
	import flash.utils.Dictionary;

	public class TestFamilyIterator
	{
		
		private var _family:IFamily;
		
		public function TestFamilyIterator(entityManager:IEntityManager)
		{
			_family = entityManager.getEntityFamily(ComponentA,ComponentB);
		}
		
		public function get family():IFamily{
			return _family;
		}
		

		public function get compomentA():ComponentA {
			return _family.components[ComponentA];
		}
		
		public function get compomentB():ComponentB {
			return _family.components[ComponentB];
		}

	}
}