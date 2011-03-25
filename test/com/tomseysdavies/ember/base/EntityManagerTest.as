package com.tomseysdavies.ember.base
{
	import asunit.framework.TestCase;
	
	import com.tomseysdavies.ember.core.IEntity;
	import com.tomseysdavies.ember.core.IFamily;
	
	public class EntityManagerTest extends TestCase
	{
		public function EntityManagerTest()
		{
			super();
		}
		
		override protected function setUp():void
		{
			_entityManager = new EntityManager();
		}
		
		override protected function tearDown():void
		{
			_entityManager.dispose();
			_entityManager = null;
		}
		
		public function testVerifyExistenceOf():void
		{
			_entityManager.createEntity(SOME_ID);
			assertTrue("Entity was proven to exist.", _entityManager.hasEntity(SOME_ID));
		}
		
		public function testVerifyExistenceOfFailure():void
		{
			_entityManager.createEntity(SOME_ID);
			assertFalse("Entity was not proven to exist.", _entityManager.hasEntity("FAIL"));
		}
		
		public function testEntityWithoutIDCreated():void
		{
			var entity:IEntity = _entityManager.createEntity();
			assertNotNull("Entity was created WITHOUT an id specified.", entity);
		}
		
		public function testEntityWithIDCreated():void
		{
			var entity:IEntity = _entityManager.createEntity("SOME_ID");
			assertNotNull("Entity was created WITH an id specified.", entity);
		}
		
		public function testDuplicateIDDoesNotCreateEntity():void
		{
			_entityManager.createEntity(SOME_ID);
			assertNull("Entity with duplicate ID won't be created.", _entityManager.createEntity(SOME_ID));
		}
		
		public function testEntityIsDeleted():void
		{
			_entityManager.createEntity(SOME_ID);
			_entityManager.removeEntity(SOME_ID);
			assertFalse("Entity was removed.", _entityManager.hasEntity(SOME_ID));
		}
		
		public function testComponentAdded():void
		{
			var result:Boolean;
			_entityManager.createEntity(SOME_ID);
			result = _entityManager.addComponent(SOME_ID, new ComponentA());
			assertTrue("Component was added.", result);
		}
		
		public function testComponentNotAddedIfNoEntity():void
		{
			var result:Boolean = _entityManager.addComponent("FAIL", new ComponentA());
			assertFalse("Component was not added.", result);
		}
		
		public function testComponentFound():void
		{
			var result:ComponentA;
			_entityManager.createEntity(SOME_ID);
			_entityManager.addComponent(SOME_ID, new ComponentA());
			result = _entityManager.getComponent(SOME_ID, ComponentA);
			assertNotNull("Component was found.", result);
		}
		
		public function testComponentRemoved():void
		{
			var result:ComponentA;
			_entityManager.createEntity(SOME_ID);
			_entityManager.addComponent(SOME_ID, new ComponentA());
			_entityManager.removeComponent(SOME_ID, ComponentA);
			result = _entityManager.getComponent(SOME_ID, ComponentA);
			assertNull("Component was removed.", result);
		}
		
		public function testFamilyCreatedWithOneComponent():void
		{
			var result:IFamily = _entityManager.getEntityFamily(ComponentA);
			assertTrue("Family was retrieved.", result is IFamily);
		}
		
		public function testFamilyCreatedWithManyComponents():void
		{
			var result:IFamily = _entityManager.getEntityFamily(ComponentA, ComponentB);
			assertTrue("Family was retrieved.", result is IFamily);
		}
		
		/*public function testFamilyContainsComponents():void
		{
			var family:IFamily;
			var entity:IEntity = _entityManager.createEntity();
			_entityManager.addComponent(entity.id, new ComponentA());
			family = _entityManager.getEntityFamily(ComponentA);
			assertTrue("Contains one component.", family.
		}
		*/
		//_________________PRIVATE
		private static const SOME_ID:String = "SOME_ID";
		private var _entityManager:EntityManager;
	}
}