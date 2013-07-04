/**
sample class
@
*/
public class StyledComponentController {
	
private Apexpages.Standardcontroller controller;

public List<Store__c> stores ;
public Store__c store {get;set;}

public StyledComponentController(Apexpages.StandardSetController controller) {
	this.stores = (List<Store__c>) controller.getRecords();
}

public Pagereference initPage () 
{
	stores = [SELECT StoreName__c FROM Store__c LIMIT 1];
	/*
	stores = new List<Store__c>();
	stores.add( new Store__c (StoreName__c='new 1 item',StoreNumber__c =10.00));
	stores.add( new Store__c (StoreName__c='new 2 item',StoreNumber__c =12.00));
	stores.add( new Store__c (StoreName__c='new 3 item',StoreNumber__c =13.00));
	stores.add( new Store__c (StoreName__c='new 4 item',StoreNumber__c =15.00));
	
	insert stores;*/
	store = [SELECT StoreName__c FROM Store__c LIMIT 1];
	System.debug('call');

Apexpages.addMessage( new Apexpages.Message(ApexPages.Severity.INFO,'Hello Chris Welcome to Starbucks Coffee'));
	return null;
}

}