trigger RoomTrigger on Room__c (after insert) {
    List<ID> rIDList = new List<ID>();

    For(Room__c r: Trigger.new ){
        rIDList.add(r.id);    
    }
    currencyConversion.getconversionrate(rIDList);
}