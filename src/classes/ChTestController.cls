global class ChTestController {
	
	private DesktopController controller;
	
	public ChTestController(DesktopController controller) {
	this.controller = controller;
	}
	
    @RemoteAction
    global static String getAllAccounts() //Need to define as a remote action as we will be calling this through javascript
    {
        List<Account> accounts = [SELECT Id, Name, Type, Phone FROM Account];
        String JSONString = JSON.serialize(accounts);//This is how we can serailize our response into JSON format
        return '{\"Records\":' +JSONString+', \"error\": \"null\", \"status\":\"SUCCESS\", \"count\":\"' + accounts.size() + '\" }';
    }
}