global class StoreIterable implements Iterator<Store__c>, Iterable<Store__c> {

	List<Store__c> stores {get;set;}
	Integer i;
	
	public StoreIterable() {
		stores = [Select StoreName__c From Store__c ORDER BY StoreName__c];
		i=0;
	}
	
	global Boolean hasNext() {
		if ( i >= stores.size() ) {
			return false;
		} else {
			return true;
		}
	}
	global Store__c next() {
		i++;
		return stores[i-1];
	}
	
	global Iterator<Store__c> Iterator() {
		return this;
	}
}