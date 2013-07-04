/**

*/

public with sharing class DesktopController extends AbstractController {

	public Integer value {get;set;}

	public DesktopController () {
		super();
		value =1;
		
	}
	public Pagereference doSomeThing () {
		value *=2;
		addInfo(' value is '+ value);
		return null;
	}
	
	
	private   void addInfo(String msg) {
		Apexpages.addMessage( new Apexpages.Message ( Apexpages.Severity.INFO, msg));
		
	}
	
}