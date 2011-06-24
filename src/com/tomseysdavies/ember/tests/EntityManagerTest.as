package com.tomseysdavies.ember.tests
{
	import com.tomseysdavies.ember.base.EntityManager;
	import com.tomseysdavies.ember.core.IEntity;
	import com.tomseysdavies.ember.core.IEntityManager;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertStrictlyEquals;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.core.throws;
	
	public class EntityManagerTest
	{		
		private static const TEST_ID:String = "TEST_ID";
		private var _entityManager:IEntityManager;
		
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
				
		[Test( description = "tests Entity creation" )]
		public function testCreateEntityWithID():void
		{
			_entityManager.assignEntity(TEST_ID);
			assertTrue(_entityManager.hasEntity(TEST_ID));
		}
		
		[Test]
		public function testRemoveEntity():void
		{
			_entityManager.assignEntity(TEST_ID);
			_entityManager.removeEntity(TEST_ID);
			assertFalse(_entityManager.hasEntity(TEST_ID));
		}
		
		[Test]
		public function testCreateEntityWithoutID():void
		{
			var entity:IEntity = _entityManager.createEntity();
			assertNotNull(entity);
		}

		[Test]
		public function testCreateTwoEntitesWithSameIDFails():void
		{
			_entityManager.assignEntity(TEST_ID);
			var wasThrown:Boolean = false;
			try {
				_entityManager.assignEntity(TEST_ID);
			} catch ( e : Error ) {
				wasThrown = true;
			}
			assertTrue(wasThrown);
		}

		
		[Test]
		public function testAddComponent():void
		{
			_entityManager.createEntity(TEST_ID);
			var wasThrown:Boolean = false;
			try {
				_entityManager.addComponent(TEST_ID,new ComponentA());
			} catch ( e : Error ) {
				wasThrown = true;
			}
			assertFalse(wasThrown); 
		}
		
		[Test]
		public function testGetComponent():void
		{
			_entityManager.createEntity(TEST_ID);
			var testComponent:ComponentA = new ComponentA();
			_entityManager.addComponent(TEST_ID,testComponent);
			var compoment:ComponentA = _entityManager.getComponent(TEST_ID,ComponentA);
			assertStrictlyEquals(testComponent,compoment);
		}

		[Test]
		public function testRemoveComponent():void
		{
			_entityManager.createEntity(TEST_ID);
			var testComponent:ComponentA = new ComponentA();
			_entityManager.addComponent(TEST_ID,testComponent);
			_entityManager.removeComponent(TEST_ID,ComponentA);
			
			var wasThrown:Boolean = false;
			try {
				_entityManager.getComponent(TEST_ID,ComponentA);
			} catch ( e : Error ) {
				wasThrown = true;
			}
			assertTrue(wasThrown); 
		}
		
	
		
	}
}