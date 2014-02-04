trigger Store_Reverence on Store__c (after delete, after insert, after undelete, 
after update, before insert) {




List<Id> accId = new List<Id>();
List<Store__c> orgList = new List<Store__c>();
List<Store__c> revList = new List<Store__c>();


for (Store__c store : trigger.new) {
    accId.add(store.A_Account__c);
    accId.add(store.B_Account__c);
    
}

Map<Id,Account> starbucksIds =new Map<Id,Account> ([select id ,starbuckID__c from Account where  id in :accId]);
system.debug('starbucksIds:'+starbucksIds.size());
if ( trigger.isInsert && trigger.isBefore) {

    for (Store__c store : trigger.new) {
    store.ST_ExternalID__c= getExtId(store);
        
    }

} else {
Integer i=0;
for (Store__c store : trigger.new) {
    system.debug('store:'+store);
    system.debug(starbucksIds.get(store.A_Account__c).starbuckID__c +'  #####' + starbucksIds.get(store.B_Account__c).starbuckID__c);
    system.debug('+++++++ '+ starbucksIds.get(store.A_Account__c));
    system.debug('+++++++ '+ starbucksIds.get(store.B_Account__c));
    Store__c sto = new Store__c();
    
    sto.Name = store.Name;
    String extId = getExtId(store)+'_'+i++;
    if (store.ST_ExternalID__c == null ) {sto.ST_ExternalID__c =  extId;}
    //system.debug(getExtId(store) +'  +++++++  exid:'+sto.ST_ExternalID__c);
    sto.A_Account__c =store.A_Account__c;
    sto.B_Account__c =store.B_Account__c;
    system.debug('=====store:'+sto);
    revList.add(sto);
}
//todo is RunningFlag
if (ProcessControl.inProgress == false) {
    ProcessControl.inProgress =true;
    system.debug('----> upsert ...');
upsert revlist;

}
ProcessControl.inProgress =false;
}

private String getExtId(Store__c store) {
    String extId; 
    if (store.ST_ExternalID__c == null) {
        system.debug('+++++++  exid is null');
        
        extId = starbucksIds.get(store.A_Account__c).starbuckID__c +'_' + starbucksIds.get(store.B_Account__c).starbuckID__c;
         
    } else {
        extId = store.ST_ExternalID__c;
    }
    //extId=store.ST_ExternalID__c;
    return extId;
}
}