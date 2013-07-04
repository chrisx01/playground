trigger logTracker on Store__c (after insert) {


Store__c store = trigger.new[0];
LogStat__c log =  new LogStat__c();
if (log.access__c == null) {
	log.access__c=0.0;
}
log.access__c++;
//update log;
}// else nothing