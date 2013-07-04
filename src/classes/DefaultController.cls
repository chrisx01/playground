/**
default controller
*/
public  class DefaultController {

	public String storeName {get;set;}
	public String storeMsg {get;set;}
	
	public Pagereference printMsg() {
		
		storeMsg = 'new Store' + storeName; 
		return null;
	}
	
	public DefaultController() {
		System.debug('contructor');
	}
	
		public boolean isSomeThing() {
System.debug('isSomeThing');
		
		return true;
	}
		public boolean isAnyThing() {
System.debug('isAnyThing');
		
		return false;
	}
}