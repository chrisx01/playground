public abstract class AbstractController {

public Integer value {get;set;}  

 abstract void addInfo(String msg) ;

@RemoteAction
    public static String getAllAccounts() //Need to define as a remote action as we will be calling this through javascript
    {
        List<Account> accounts = [SELECT Id, Name, Type, Phone FROM Account];
        String JSONString = JSON.serialize(accounts);//This is how we can serailize our response into JSON format
        return '{\"Records\":' +JSONString+', \"error\": \"null\", \"status\":\"SUCCESS\", \"count\":\"' + accounts.size() + '\" }';
    }
   
    
    public Pagereference doSomeThingOther() {
    	if (value == null) { 
    		value=1;
    	 }
		value ++;
		addInfo(' value is '+ value);
		return null;
	}
	
//test	
}
