package {
	import asunit.textui.TestRunner;
	
	public class EmberTestRunner extends TestRunner {
		
		public function EmberTestRunner() {
			start(AllTests);
		}
	}
}