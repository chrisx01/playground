trigger location_insert_geo on location__c (before insert) {

System.debug('#######  location_insert_geo as: ' +UserInfo.getUserName() );

GeoLoaction geoLookUp = new GeoLoaction();
for (location__c st : trigger.new) {
	
	List<String> params = new List<String>();
	params.add(st.country__c);
	params.add(st.city__c);
	params.add(st.zip__c);
	params.add(st.street__c);
	
	
	String[] corrds = geoLookUp.getCoordinates(params);
	
	st.geoLocation__Latitude__s = Decimal.valueOf(corrds[0]);
	st.geoLocation__Longitude__s =Decimal.valueOf(corrds[1]);
	
}
}