trigger DublettenCheck on Contact (before insert, before update) {
	
	
	Map<String,Contact> contactMap = new Map<String,Contact>();
	
	List<Contact> contacts = [SELECT Id, Email, LastName, FirstName from Contact  ];
	for(Contact c : contacts) {
		contactMap.put(c.email,c);
		}

   if (Trigger.isInsert)
   {
      for (Contact c : Trigger.new){
     System.debug('Insert Contact put '+c.email);
         if(contactMap.get(c.email)!=null){
             c.addError('Contact already exists');
         }   
      }
   }
   else if (Trigger.isUpdate)
   {
       for (Contact c : Trigger.new)
       {
          Contact oldC = Trigger.oldMap.get(c.id);
          if ( c.Email != oldC.Email || c.FirstName !=oldC.FirstName || c.LastName!=oldC.LastName )
          {
            if(contactMap.get(c.email)!=null){
             c.addError('Contact already exists');
         }   
        }
       }
   }
}
/*	
	List <Contact> contactList = new List<Contact>();
	Map<String,Contact> contactmap = new Map<String,Contact>();
	
	
	for (Contact contact : Trigger.new) {
		
        if ((contact.Id != null) && (Trigger.isInsert ||(contact.Email !=Trigger.oldMap.get(contact.Id).Email))){
		System.debug('Contact Id  not null');
			  if (contactmap.containsKey(contact.Email)) {
                contact.LastName.addError('Contact already exists.');
            } else {
                contactmap.put(contact.Email, contact);
            }
       }
    }
	
	System.debug('');
	    for (Contact contact  : [SELECT  id,FirstName,LastName,Email
	     FROM Contact     WHERE  Email IN:contactmap.KeySet() ] ) //and LastName IN:contactmap.KeySet()   and FirstName IN :contactmap.KeySet()]) {
       		{
       	Contact newContact = contactmap.get(contact.Email);
        newContact.Email.addError('Contact already exists.');
    }
}
	/*
	for(Contact c : Trigger.new) {
		contactList.add(c);
	}
	for(Contact c : contacts) {
		contactmap.put(c.Id,c.email);
	}
	
	if ( Trigger.isInsert) {
			
		 for (Contact c : Trigger.new){
      
    		 Contact[] contacts= [select id from Contact where FirstName = :c.FirstName and LastName = :c.LastName and Email = :c.Email];
      
      if (contacts.size() > 0) {
          c.LastName.addError('Contact already exists');
      }    
   }
		
	} else if (Trigger.isUpdate) {
			for (Contact c : Trigger.new){
      
    		 Contact[] contacts= [select id from Contact where FirstName = :c.FirstName and LastName = :c.LastName and Email = :c.Email];
      
      if (contacts.size() > 0) {
          c.LastName.addError('Contact already exists');
      }    
   }
}

}

/*
trigger leadDuplicatePreventer on Lead
                               (before insert, before update)&nbsp;{

    Map<String, Lead> leadMap =&nbsp;new Map<String, Lead>();
    for (Lead lead : System.Trigger.new)&nbsp;{
		
        // Make sure we don't treat an email address that&nbsp; 
    
        // isn't changing during an update as a duplicate.&nbsp; 
    
        if ((lead.Email !=&nbsp;null) &&
                (System.Trigger.isInsert ||
                (lead.Email != 
                    System.Trigger.oldMap.get(lead.Id).Email)))&nbsp;{
		
            // Make sure another new lead isn't also a duplicate&nbsp; 
    
            if (leadMap.containsKey(lead.Email))&nbsp;{
                lead.Email.addError('Another new lead has the '
                                    +&nbsp;'same email address.');
            }&nbsp;else&nbsp;{
                leadMap.put(lead.Email, lead);
            }
       }
    }
	
    // Using a single database query, find all the leads in&nbsp; 
    
    // the database that have the same email address as any&nbsp; 
    
    // of the leads being inserted or updated.&nbsp; 
    
    for (Lead lead : [SELECT Email FROM Lead
                      WHERE Email IN :leadMap.KeySet()])&nbsp;{
        Lead newLead = leadMap.get(lead.Email);
        newLead.Email.addError('A lead with this email '
                               +&nbsp;'address already exists.');
    }
}
*/