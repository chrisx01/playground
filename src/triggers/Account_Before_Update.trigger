trigger Account_Before_Update on Account (before update) {


List<String> accountNames = new List<String>{};

List<testCustomSet__c> testCSs = [ select Id,name From testCustomSet__c];

Map<Id,RecordType> rtMap =  new Map<Id,RecordType>([ Select r.SobjectType, r.Name, r.IsActive, r.Id, r.DeveloperName From RecordType r  Where  r.SobjectType='Account' and r.IsActive =true]);

Set<String> csName = new Set<String>();

for(testCustomSet__c cs: testCSs){ 
csName.add(cs.Name);
}


for(Account a: Trigger.new){ 
	
	String rtName ='';
	RecordType rt = (RecordType)rtMap.get(a.RecordTypeId);
	rtName=rt.Name;
	
	if  ( (rtMap.containsKey(a.RecordTypeId)) || (csName.contains(rtName) ) ) {
		//todo nothing
	}
}
}