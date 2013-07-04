global class StarbucksIterableBatch  implements Database.Batchable<Store__c> {
 
	global Iterable<Store__c>  start (Database.Batchablecontext context) {
		System.debug('start');
		return new StoreIterable();
		
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