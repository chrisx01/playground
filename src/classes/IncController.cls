public  class IncController {

    String name;
    Boolean showGreeting = false;
    
    public PageReference save() {
        showGreeting = true;
        Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'save.'));
        return null;
    }
    public PageReference initPage() {
    	Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Welcome.'));
    	return null;
    }
    
    public void setNameField(String nameField) {
        name = nameField;
    }
    
    public String getNameField() {
        return name;
    }
    
    public Boolean getShowGreeting() {
        return showGreeting;
    }
}