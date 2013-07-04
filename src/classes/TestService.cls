@RestResource(urlMapping='/Starbucks/*')
	
global with sharing class TestService {




    @HttpGet
    global static Store__c doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String id = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Store__c result = [SELECT Name, Id,Store__c.StoreType__c  FROM Store__c WHERE Id = :id];
        return result;
    }
   /*   
  public static xmldom geocode( string addr ) { 
    HttpRequest req = new HttpRequest();   
    string url = GoogleGeoCode.serviceUrl + '&output=xml&q=' + EncodingUtil.urlEncode(addr,'UTF-8');
    system.debug ( 'url is ' +url );
    req.setEndpoint( url );
    req.setMethod('GET');
      
    xmldom dom = null;
    try {
        Http http = new Http();
        HttpResponse response = http.send(req);    
        if (response.getStatusCode() != 200 ) {
            dumpResponse ( response);
        } else {
            dom = new xmldom( response.getBody() );
        } 
    } catch( System.Exception e) {
        System.debug('ERROR: '+ e);
    }  
    
    if ( googleGeoCode.debug > 0 && dom != null ) { 
        dom.dumpAll(); 
    } 
    return dom;
    }
    */
 
}