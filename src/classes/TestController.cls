public with sharing class TestController {

public List <Lead>  leadList{get;set;}
public Map<ID, Lead> leadMap {get;set;}
public Set<String> myString {get;set;}

public Pagereference doSomeThing( ) {
   
   
   leadList = new List<Lead>();
   leadList= [Select id,LastName, company FROM  Lead];
   System.debug('leads:');
   Id lastId;
   for ( Lead l : leadList) {
   		System.debug('lead:' +l.LastName + l.Company);
   		 lastId= l.Id;
   	}
    
   	myString  = new Set<String>{'a1', 'b1', 'c1'};
   
   	leadMap =new map<ID, Lead>(leadList);
   	if ( leadMap.containsKey(lastId)){
   	System.debug('lead found :'+lastId);
   }
  return null;
   }
}