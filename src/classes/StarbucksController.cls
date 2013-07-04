/**
*/


global with sharing class StarbucksController {

	public List <Store__c>  storeList { get;set;}
	public list <employe__c> employees {get;set;}
	
	//public  Store__c storeList {get;private set;}
	public Store__c store ;
	public List <StoreWrapper> stores {get;set;}
	public String storeMsg {get;set;}
	public StarbucksController () {
		
		stores = new List<StoreWrapper>();
		List <Store__c> records = [ SELECT Id,StoreName__c, StoreType__c, emailAdress__c FROM Store__c LIMIT 2];
		storeList= [ SELECT Id,StoreName__c, StoreType__c,emailAdress__c FROM Store__c LIMIT 2];
		employees = [Select e.new__c, e.description__c, e.Store__c, e.Name, e.Id From employe__c e  LIMIT 10];
		 for (Store__c record : records) {
		 	
		 	System.debug('id'+record.id );
		 	stores.add ( new StoreWrapper(record));
		 }
	}
	
	public Pagereference printMsg() {
		
		 for (StoreWrapper wrapper : stores) {
		 	if (wrapper.selected) {
			System.debug(wrapper.data.Id);
		 	}
		 }
		 
		return null;
	}

	public Pagereference refreshStore() {	 
	
		return null;
	}
	
		public Pagereference edit() {	 
	
		return null;
	}
	
	public Pagereference save() {		
		
		//for (StoreWrapper store : stores) {
		 	update storeList;
		 //	}
		 	return null;
		 }	 	
		
	public Pagereference saveSingle() {		
		
		store = [ SELECT Id,StoreName__c, StoreType__c, emailAdress__c FROM Store__c LIMIT 1];
		 	update store;
		 
		 	return Apexpages.currentPage();
		 }	 	
		
class StoreWrapper {
	public Store__c data {get;  set;}
	public Boolean selected {get;set;}
	public StoreWrapper (Store__c store) {
		this.data=store;
		
		this.selected = false;
		
	}
}
@RemoteAction
    global static String getStoreJson(Id id) //Need to define as a remote action as we will be calling this through javascript
      {
        Store__c lStore = [SELECT Id, Name, StoreName__c FROM Store__c where Id=:id];
        String JSONString = JSON.serialize(lStore);//This is how we can serailize our response into JSON format
        return '{\"Records\":' +JSONString+', \"error\": \"null\", \"status\":\"SUCCESS\", \"count\":\"' + 1 + '\" }';
    }
}