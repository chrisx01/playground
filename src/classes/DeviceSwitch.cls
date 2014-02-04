public with sharing class DeviceSwitch {
public boolean isIPhone {get;set;}
public boolean isIPad {get;set;}

 
    public DeviceSwitch() {
         String userAgent = 

                System.currentPageReference().getHeaders().get('User-Agent');
         isIPhone = userAgent.contains('iPhone');
         isIPad = userAgent.contains('iPad');
    }
 
 
    public PageReference detectDevice(){
        if (isIPhone) {
            return Page.phonePage.setRedirect(true);
        }
        else if (isIPad) {
            return Page.tabletPage.setRedirect(true);
        }
        else
            return null;    
    }
}