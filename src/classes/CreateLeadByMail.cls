global class CreateLeadByMail implements Messaging.InboundEmailHandler {
 
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
    Messaging.InboundEnvelope envelope) {
 
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
 
 	String leadStr = email.plainTextBody;
	  
	 Matcher matcher = Pattern.compile('(?<=^|>)[^><]+?(?=<|$)').matcher(leadStr.trim());
   Lead newLead = new Lead();
  // 
   if (matcher.find()) {
   	 newLead.FirstName = matcher.group();
   	 matcher.find();
     newLead.LastName = matcher.group();
   	 matcher.find();
  //TODO check email format
     newLead.Email = matcher.group();
   	 matcher.find();
   	 newLead.Company =matcher.group();
    }
   
    
    insert newLead;
 
    System.debug('====> Created lead '+lead.Id);
  
    
  
 	Messaging.SingleEmailMessage outbound = new Messaging.SingleEmailMessage();
 	outbound.setTargetObjectId(UserInfo.getUserId());
	outbound.setSaveAsActivity(false);
		
	outbound.setPlainTextBody('lead: '+lead.Id+'\n '+leadStr+'\nCreated');
	
	Messaging.sendEmail(new Messaging.SingleEmailMessage[] { outbound });
    return result;
 
  }
 
}