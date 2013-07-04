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
private class myTest {

   /* static testMethod void myUnitTest() {
     // String to be scanned to find the pattern.
      String line = '<lastname>Howard</lastname><fristname>Schultz</fristname><email>info@starbucks.de</email><company>starbucks</company>';
     
   		  Matcher m = Pattern.compile('(?<=^|>)[^><]+?(?=<|$)').matcher(line);
      if (m.find()) {
         System.debug('Found value: ' + m.group() );
         m.find();
         System.debug('Found value: ' + m.group() );
           m.find();
        System.debug('Found value: ' + m.group() );
          m.find();
        System.debug('Found value: ' + m.group() );
      } else {
         System.debug('NO MATCH');
      }
   
    }*/
    static testMethod void SetMapListTest() {
    	
    	
   List <Lead> leadList = new List<Lead>();
   leadList= [Select id,LastName, company FROM  Lead];
   System.debug('leads:');
   Id lastId;
   for ( Lead l : leadList) {
   	System.debug('lead:' +l.LastName + l.Company);
   	 lastId= l.Id;
   }
    
   Set<String> My_String = new Set<String>{'a1', 'b1', 'c1'};
   
   Map<ID, Lead> leadMap =new map<ID, Lead>(leadList);
   if ( leadMap.containsKey(lastId)){
   	System.debug('lead found :'+lastId);
   }
    }
    
    
}