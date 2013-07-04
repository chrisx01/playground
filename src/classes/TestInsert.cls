/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestInsert {

    static testMethod void insertContacts(){
    // Perform our data preparation.
    List<Contact> contacts = new List<Contact>{};
        
    for(Integer i = 0; i < 50; i++){
        Contact con = new Contact(FirstName = 'Cest Account ' + i,LastName ='CestAc'+i, Email='t'+i+'Cts@as.de');
        contacts.add(con);
    }

   
    test.startTest();
		
    // Insert the Account contacts that cause the trigger to execute.
    insert contacts; 
		
    // Stop the test, this changes limit context back to test from trigger.
    test.stopTest();
		
    Integer counts = [Select count() from Contact ];
	System.Debug('count'+counts);
   System.assertEquals(counts,50);
}

}