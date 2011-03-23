package
{
	import asunit.framework.TestSuite;
	
	import ember.EntityManagerTest;
	
	public class AllTests extends TestSuite
	{
		public function AllTests()
		{
			super();
			addTest(new EntityManagerTest());
		}
	}
}