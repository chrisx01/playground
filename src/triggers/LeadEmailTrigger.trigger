trigger LeadEmailTrigger on Lead (after insert, after update) {

private Emailer ec;
 
 for(Lead obj: Trigger.New) {
     ec = new Emailer();
     // do something
     
     ec.emailMethod(obj); 
 }

}