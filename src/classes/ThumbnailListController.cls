public with sharing class ThumbnailListController {



public ThumbnailListConfig config {get; set;}
// Parameter object to pass between JavaScript and Visualforce controllers.
public virtual class ThumbnailListConfig {
public Boolean debug { get; set; }
// The elemId is generated in VF and sent to client.
public String elemId {get; set;}
public String sObjectType {get; set;}
public String imageUrlField {get; set;}
public String labelField {get; set;}
public String subLabelField {get; set;}
public String sortByField {get; set;}
public String filter { get; set; }
public String filterClause {get; set;}
public String listItemStyleClass { get; set; }
public String listDividerStyleClass { get; set; }
public String nextPage { get; set; }
public String serverCtlrName = 'ThumbnailListController';
public String jsCtlrName {get; set;}
}
// constructor
public ThumbnailListController() {
this.config = new ThumbnailListConfig();
}
private final static String THUMBNAIL_LIST_JS = 'ThumbnailListJS';
public String getThumbnailListJS() {
return config.debug ? THUMBNAIL_LIST_JS : (THUMBNAIL_LIST_JS
+ 'Min');
}
@RemoteAction
public static List<Sobject> getRecordsForConfig(ThumbnailListConfig
config) {
System.debug('--- config: ' + config);
Set<String> fieldsToQuerySet = new Set<String>();
fieldsToQuerySet.add(config.imageUrlField);
fieldsToQuerySet.add(config.labelField);
fieldsToQuerySet.add(config.subLabelField);
fieldsToQuerySet.add(config.sortByField);
List<Sobject> recordList = ThumbnailListController.getRecords(config.sObjectType,fieldsToQuerySet,UserInfo.getUserId());
return recordList;
}
public static List<Sobject> getRecords(
String sObjectType,
Set<String> fieldsToQuerySet,
Id userId) {
List<Sobject> recordList = new List<Sobject>();
String queryString = ' ';
// Build the Select clause.
queryString += 'SELECT ';
for (String field : fieldsToQuerySet)
queryString += (field + ',');
queryString = queryString.subString(0, queryString.length()-1);
// Build the From clause.
queryString += ' FROM ' + sObjectType;
// Build the Where clause.
queryString += ' WHERE ';
queryString += ' LastModifiedById = \'' + userId + '\'';
recordList = Database.query(queryString);
return recordList;
}
public virtual String getConfigAsJson() {
String configStr = JSON.serialize(this.config);
System.debug(configStr);
return configStr;

}
}