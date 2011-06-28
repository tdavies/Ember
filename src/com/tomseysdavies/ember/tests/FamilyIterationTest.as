package com.tomseysdavies.ember.tests
{
	import com.tomseysdavies.ember.base.EntityManager;
	import com.tomseysdavies.ember.base.Node;
	import com.tomseysdavies.ember.core.IEntity;
	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IFamily;
	
	import org.flexunit.asserts.assertStrictlyEquals;
	import org.flexunit.asserts.assertTrue;

	public class FamilyIterationTest
	{		
		private var _entityManager:IEntityManager;
		private static const TEST_ID:String = "TEST_ID";
		
		[Before]
		public function setUp():void
		{
			_entityManager = new EntityManager();
		}
		
		[After]
		public function tearDown():void
		{
			_entityManager.dispose();
			_entityManager = null;
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
		[Test]
		public function testFamilyIteration():void
		{
			var testComponentA:ComponentA = new ComponentA();
			var testComponentB:ComponentB = new ComponentB();
			var entiyOne:IEntity = _entityManager.createEntity();	
			entiyOne.addComponent(testComponentA);
			entiyOne.addComponent(testComponentB);
			
			var entiyTwo:IEntity = _entityManager.createEntity();	
			entiyTwo.addComponent(testComponentA);
			entiyTwo.addComponent(testComponentB);
		
			var family:IFamily = _entityManager.getEntityFamily(TestNode);
		}
		
	}
}