package ember
{
	import asunit.framework.TestCase;
	
	import com.tomseysdavies.ember.base.EntityManager;
	import com.tomseysdavies.ember.core.IEntity;
	
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
			assertFalse("Entity was removed.", _entityManager.verifyExistenceOf(SOME_ID));
		}
		
		public function testComponentAdded():void
		{
			var result:Boolean;
			_entityManager.createEntity(SOME_ID);
			result = _entityManager.addComponent(SOME_ID, new MockComponent());
			assertTrue("Component was added.", result);
		}
		
		public function testComponentNotAddedIfNoEntity():void
		{
			var result:Boolean = _entityManager.addComponent("FAIL", new MockComponent());
			assertFalse("Component was not added.", result);
		}
		
		
		//_________________PRIVATE
		private static const SOME_ID:String = "SOME_ID";
		private var _entityManager:EntityManager;
	}
}