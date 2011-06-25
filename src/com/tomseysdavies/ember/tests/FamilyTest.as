package com.tomseysdavies.ember.tests
{
	import com.tomseysdavies.ember.base.EntityManager;
	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IFamily;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	public class FamilyTest
	{		
		
		private var _entityManager:IEntityManager;
		private static const TEST_ID:String = "TEST_ID";
		private static const TEST_ID_2:String = "TEST_ID_2";
		
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
		public function testCreateFamilyAfterEntities():void
		{
			var testComponentA:ComponentA = new ComponentA();
			var testComponentB:ComponentB = new ComponentB();
			_entityManager.createEntity(TEST_ID);			
			_entityManager.addComponent(TEST_ID,testComponentA);
			_entityManager.addComponent(TEST_ID,testComponentB);			
			var family:IFamily = _entityManager.getEntityFamily(TestNode);
			assertFalse(family.empty);
		}
		
		[Test]
		public function testFamilyKetpUptoDate():void
		{
			var testComponentA:ComponentA = new ComponentA();
			var testComponentB:ComponentB = new ComponentB();
			
			_entityManager.createEntity(TEST_ID);			
			_entityManager.addComponent(TEST_ID,testComponentA);
			_entityManager.addComponent(TEST_ID,testComponentB);			
			var family:IFamily = _entityManager.getEntityFamily(TestNode);
			assertFalse(family.empty);
			
			_entityManager.createEntity(TEST_ID_2);			
			_entityManager.addComponent(TEST_ID_2,testComponentA);
			_entityManager.addComponent(TEST_ID_2,testComponentB);
			assertFalse(family.empty);
			
			_entityManager.removeComponent(TEST_ID,ComponentA);
			assertFalse(family.empty);
			_entityManager.removeComponent(TEST_ID_2,ComponentB);
			assertTrue(family.empty);
		}
		
		
	}
}