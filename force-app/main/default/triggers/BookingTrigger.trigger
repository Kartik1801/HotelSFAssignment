trigger BookingTrigger on Booking__c (before insert, before update) {
    BookingTriggerHelperClass.checkAvailability(Trigger.new);
}