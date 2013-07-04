/**
 * [DESCRIPTION]
 *
 */
global class StarbucksBatch implements Database.Batchable<SObject> {
 
	global Database.Querylocator start (Database.Batchablecontext context) {
		System.debug('start');
		return Database.getQueryLocator([ select StoreName__c, StoreType__c from Store__c 
		ORDER BY StoreName__c]);
		
	}
	
	global void execute (Database.Batchablecontext context, List<SObject> scope) {
	
	System.debug('execute');
		
		for (SObject rec : scope ) {
			Store__c store = (Store__c)rec;
			System.debug('Store'+ store.StoreName__c);
		}
	}
	
	global void finish (Database.Batchablecontext context) {
		System.debug('finish');
	}
}