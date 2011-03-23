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
			var entity:IEntity = _entityManager.createEntity('SOME_ID');
			assertNotNull("Entity was created WITH an id specified.", entity);
		}
		
		public function testDuplicateIDDoesNotCreateEntity():void
		{
			
		}
		
		//_________________PRIVATE
		private var _entityManager:EntityManager;
	}
}