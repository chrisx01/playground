global  with sharing class HttpMockTester implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response. 
        // Set response values, and  
        // return response. 
        
        System.assertEquals('http://api.salesforce.com/foo/bar', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response 
    
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"foo":"bar"}');
        res.setStatusCode(200);
        return res;
    
    }
}