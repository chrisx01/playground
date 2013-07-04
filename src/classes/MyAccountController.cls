public with sharing class MyAccountController {
	
	private Apexpages.Standardcontroller controller;

public MyAccountController(Apexpages.Standardcontroller controller) {
	this.controller = controller;

}
public PageReference savenew(){
        controller.save();

         Schema.DescribeSObjectResult describeResult = controller.getRecord().getSObjectType().getDescribe();
    PageReference pr = new PageReference('/' + describeResult.getKeyPrefix() + '/e');
    pr.setRedirect(true);
    return pr;
     }
}