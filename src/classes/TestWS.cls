global with sharing class TestWS {

/**
Webserice Interface to Start the Batchjob
*/


   

	webservice static string sayHello(String h) {
    h = 'Hello World!: ' +h;
    return h;
    }
}