package
{
	import asunit.framework.TestSuite;
	
	import ember.base.EntityManagerTest;
	
	public class AllTests extends TestSuite
	{
		public function AllTests()
		{
			super();
			addTest(new EntityManagerTest());
		}
	}
}