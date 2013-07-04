/**
sample class
@
*/
public with sharing  class SampleController {
private Apexpages.Standardcontroller controller;

public List<string> stores {get;set;} 

public List<employe__c> employees {get;set;} 
public employe__c emp {get;set;} 

public SampleController(Apexpages.Standardcontroller controller) {
	this.controller = controller;
	this.employees = new List<employe__c>([select id,name from employe__c limit 1]);
	this.emp = employees.get(0);
}

public Pagereference call () 
{
	stores = new List<string>();
	stores.add('1 item');
	stores.add('2 item');
	stores.add('3 item');
	stores.add('4 item');
	
	System.debug('call');
	return null;
}
}