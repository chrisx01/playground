public with sharing class MyObjectExtentsion {
    private string objectID = '';
    public string URLForPage{get;set;}
    
        //Constructor
    public MyObjectExtentsion(ApexPages.StandardController stdController) {
           URLForPage = ApexPages.currentPage().getHeaders().get('Host');
           objectID =  stdController.getId();      
        }
    
    //action="{!incrementRefreshCounter}" Put this in the Visualforce Page
        public void incrementRefreshCounter(){
           myObject__c myObject;
           myObject = [Select ID, RefreshCount__c, Call_Status__c
                    From myObject__c
                    Where ID = :objectID];
           if (myObject.Call_Status__c == 'In Progress' || myObject.Call_Status__c == 'Timed Out'){
            myObject.RefreshCount__c += 1;
            if (myObject.RefreshCount__c > 5){
                myObject.Call_Status__c = 'Timed Out';
            }
            update myObject;
           }       
       }   
}