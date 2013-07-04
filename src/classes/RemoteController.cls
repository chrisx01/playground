global with sharing class RemoteController {
	
	public String storeName { get; set; }
    public static Store__c store { get; set; }

    @RemoteAction
    global static Store__c  getStore (String storeName) {
         store = [SELECT Id, Name, StoreName__c 
                   FROM Store__c WHERE Name = :storeName];
          if ( store.StoreName__c =='') {
          	store.StoreName__c = 'default';
          }
        return store;
    }
    
    @RemoteAction
    global static String getStoreJson(Id id) //Need to define as a remote action as we will be calling this through javascript
      {
        Store__c lStore = [SELECT Id, Name, StoreName__c FROM Store__c where Id=:id];
        String JSONString = JSON.serialize(lStore);//This is how we can serailize our response into JSON format
        return '{\"Records\":' +JSONString+', \"error\": \"null\", \"status\":\"SUCCESS\", \"count\":\"' + 1 + '\" }';
    }
}