/**
*/
public with sharing class ContactController {
	
	public List<Account> accs {get;set;}
	
	 public ContactController() {
        accs = [SELECT Id, Name FROM Account ];
    }

    public List<Account> getAccounts() {
        return accs;
    }

    
}