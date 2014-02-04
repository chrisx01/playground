/**
*/
public with sharing class EmailController {

    private  Account account {set;get;}

    
    public EmailController() {
    account = [SELECT Name, 
                  (SELECT Contact.Name, Contact.Email FROM Account.Contacts) 
                   FROM Account 
                   limit 1];
    
    }

    public Pagereference sendMail() {
        
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 

        // Reference the attachment page and pass in the account ID
        PageReference pdf =  Page.attachPDF;
        pdf.getParameters().put('id',(String)account.id); 
        pdf.setRedirect(true);

        // Take the PDF content
        Blob b = pdf.getContent();

        // Create the email attachment
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName('attachment.pdf');
        efa.setBody(b);
        
        list<String> toAddresse  = new list<String> ();
        
        toAddresse.add ('chx01@gmx.de'); 
        email.setSubject( 'subject' );
        email.setToAddresses( toAddresse );
        email.setPlainTextBody( 'b' );

        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});

        // Sends the email
        Messaging.SendEmailResult [] r = 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
        
        
        return null;
    }
    
@isTest
private static void   runtest() {

    Account ac = new Account (name='test');
    insert ac;
    EmailController ec = new EmailController();
    ec.sendMail();
    }   
}