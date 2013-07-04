global with sharing class GeoLoaction {
	
@RemoteAction
global static String[] getCoordinates(String[] addressParts)
{ 
  String[] Coordinates; 
  String address = '';
  boolean needComma = false;
  for(Integer i = 0; i< addressParts.size();i++){
     // if(needComma) {
        address = address + ',';
      address = address + EncodingUtil.urlEncode(addressParts[i],'UTF-8');
      //needComma = true;
    //}
  }
  if(address.length() == 0)
  {
    system.debug(Logginglevel.ERROR,
      'GeoUtilities getCoordinates no address provided. Return null');    
    return null; 
  }
   
  String url = 'http://maps.google.com/maps/geo?';
  url += 'q=' + address; 
  url += '&output=csv'; 
  
  system.debug(Logginglevel.ERROR,'GeoUtilities getCoordinates url: ' + url);    
  
  Http h = new Http(); 
  HttpRequest req = new HttpRequest();
  
  req.setHeader('Content-type', 'application/x-www-form-urlencoded'); 
  req.setHeader('Content-length', '0'); 
  req.setEndpoint(url); 
  req.setMethod('POST');
  String responseBody;
  if (!Test.isRunningTest()){ 
  // Methods defined as TestMethod do not support Web service callouts
    HttpResponse res = h.send(req); 
    responseBody = res.getBody();
  }
  else {
    // dummy data
    responseBody = '200,4,48.5,-123.67';
  } 
  String[] responseParts = responseBody.split(',',0); 
  // the response has four parts: 
  // status code, quality code, latitude and longitude
  Coordinates = new String[2];
  Coordinates[0] = responseParts[2];
  Coordinates[1] = responseParts[3];
    
  return Coordinates; 
}
}