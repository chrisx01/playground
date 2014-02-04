global  class StoreImageController {


public StoreImageController(ApexPages.StandardController stdController) {
  //    <% Response.AddHeader("Access-Control-Allow-Origin","*") %>
  
    }

 @RemoteAction
    global static String saveImageUrl(String url) //Need to define as a remote action as we will be calling this through javascript
    {	
    	chx__Image__c  newImg = new chx__Image__c();
    	newImg.chx__UrlStr__c = url;
    	insert newImg;
        String JSONString = JSON.serialize(newImg);//This is how we can serailize our response into JSON format
        return '{\"Records\":' +JSONString+', \"error\": \"null\", \"status\":\"SUCCESS\", \"count\":\"1\" }';
    }
}