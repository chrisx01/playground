@isTest
private class TestAccoutTrigger {


 static testMethod void AccountTrigger () {
	
	List<testCustomSet__c> testCSs = [ select Id,name From testCustomSet__c];

	Map<Id,RecordType> rtMap =  new Map<Id,RecordType>([ Select r.SobjectType, r.Name, r.IsActive, r.Id, r.DeveloperName From RecordType r  Where  r.SobjectType='Account' and r.IsActive =true]);

	Set<String> csName = new Set<String>();

	for(testCustomSet__c cs: testCSs){ 
		csName.add(cs.Name);
		System.debug(cs.Name);
	} 
	  Account a1 = new Account(Name = 'a001exec');
	  Account a2 = new Account(Name = 'a002notexec');
//	  Account.RecordTypeId = testCs
	test.startTest();
	
	insert a1;
	System.debug(a1.Name);
	insert a2;
	System.debug(a2.Name);
	
	Account a3 = [select Id,name, RecordTypeId from Account Where name='a001exec'];
	Account a4 = [select Id,name, RecordTypeId from Account Where name='a002notexec'];
	System.debug('#######'+a3.Name);
	System.debug('#######'+a4.Name);
	
	a3.Name ='a001exec_change';
	a4.Name ='a002exec_change';
	
	update a3;
	update a4;
	
		
	try {
	Account a5 = [select Id,name, RecordTypeId from Account Where name='a001exec_change'];
	Account a6 = [select Id,name, RecordTypeId from Account Where name='a002notexec'];

	System.debug(a5.Name);
	System.debug(a6.Name);
	
	
	System.assertEquals('a001exec_change',a5.Name );
	System.assertEquals('a002notexec',a6.Name );
	
	
	} catch (Exception e) {
		
	}
	
	
	test.stopTest();
	
	}
	
}