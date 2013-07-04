public with sharing class DeviceSelector {

    public boolean iPhone     {get;set;}
    public boolean iPad     {get;set;}
    public boolean Android     {get;set;}
    public boolean isMobile    {get;set;}
    
    public DeviceSelector() {
         String userAgent = System.currentPageReference().getHeaders().get('User-Agent');
  String device = System.currentPageReference().getParameters().get('device');
         isMobile = (device == 'mobile');
         iPhone = (userAgent.contains('iPhone') );//|| device == 'mobile');
         iPad = (userAgent.contains('iPad') );//|| (userAgent.contains('AppleWebKit') && device !='mobile'));
    }
    
    public pageReference redirect(){
    	 pageReference mobred ;
    	if (iPad) {
       	 mobred =  new pageReference('/apex/tablet');
    	} else if (iPhone) {
          mobred = new pageReference('/apex/iphone');
    	} else {
          mobred = new pageReference('/apex/desktop');
    	}
         mobred.setredirect(true);
      return mobred;    
    }
}