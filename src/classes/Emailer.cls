/**
*/
public with sharing class Emailer {

 private final Contact con;

  	public Emailer() {
  		//this.con=(Contact) controller.getRecord();
  	}

 public void  emailMethod(Lead leadObj) {
	
	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	mail.setTargetObjectId(UserInfo.getUserId());
	//mail.setTemplateId('00XE0000000MJCB');
	mail.setSaveAsActivity(false);
	
	
	mail.setPlainTextBody('lead: '+leadObj.Id );
	Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
 }
 
}