/**
 
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class Test_RelationShip {

    static testMethod void runTest() {
    	
    	List<Account> accList = new List<Account>{new Account (Name='testacc1',starbuckID__c='sb_001200'),
    											new Account (Name='testacc2',starbuckID__c='sb_001234'),
    											new Account (Name='testacc3',starbuckID__c='sb_001212') };
    	insert accList;
    	
    	List<Store__c> storeList =  new List<Store__c> {new Store__c (Name='001',A_Account__c=accList[0].Id,B_Account__c=accList[1].Id),
    											new Store__c (Name='002',A_Account__c=accList[1].Id,B_Account__c=accList[2].Id),
    											new Store__c (Name='003',A_Account__c=accList[0].Id,B_Account__c=accList[2].Id,ST_ExternalID__c='sb_id01213') } ;
    	
    	Test.startTest();
    	
    	insert storeList;
    										
        // TO DO: implement unit test
    }
}