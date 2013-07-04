trigger Counter on Account (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {


if (Trigger.isBefore) {

     if (Trigger.isInsert) {
        for(Account a: Trigger.new){
        if (a.counter__c ==null ) {
            a.counter__c =0;
        } else {
            a.counter__c=a.counter__c+1;
        }
        }
        
    } else if (Trigger.isUpdate) {
            for(Account a: Trigger.new){
        if (a.counter__c ==null ) {
            a.counter__c =0;
        } else {
            a.counter__c=a.counter__c+1;
        }
        }
    } else if (Trigger.isDelete) {
            for(Account a: Trigger.new){
        if (a.counter__c ==null ) {
            a.counter__c =0;
        } else {
            a.counter__c=a.counter__c+1;
        }
        }
    
    }else if (Trigger.isUnDelete) {
            for(Account a: Trigger.new){
        if (a.counter__c ==null ) {
            a.counter__c =0;
        } else {
            a.counter__c=a.counter__c+1;
        }
        }
    }

    
} else if (Trigger.isAfter)
    {
     
}
}