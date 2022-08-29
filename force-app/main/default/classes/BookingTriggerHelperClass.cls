public with sharing class BookingTriggerHelperClass {

    public static void checkAvailability(List<Booking__c> newBookings){
        
        Room__c[] RoomsInBookings = [ SELECT id FROM Room__c WHERE id IN ( SELECT Room__c FROM Booking__c Where ID in :newBookings ) ];

        Booking__c[] ActiveBookingForSameRoom = [ SELECT ID, Check_In__c, Check_Out__c, Room__r.id FROM Booking__c WHERE
                                                    active__c = true AND
                                                    Room__c IN :RoomsInBookings ];

        Map<ID, List<Booking__c> > RoomMap = new Map<ID, List<Booking__c>>(); 

        for(Booking__c booking: ActiveBookingForSameRoom ){
            if(RoomMap.containsKey(booking.Room__c)){
                RoomMap.get(booking.Room__c).add(booking);
            }
            else{
                List<Booking__c> bookingList = new List<Booking__c>();
                bookingList.add(booking);
                RoomMap.put(booking.Room__c, bookingList);
            }
        }                                            

        for( Booking__c bookings : newBookings ){
            if(RoomMap.containsKey(bookings.Room__c)){
                
                for( Booking__c existingBookings: RoomMap.get(bookings.Room__c) ){

                    if( bookings.Check_In__c <= existingBookings.Check_In__c && bookings.Check_Out__c >= existingBookings.Check_In__c - 45/1440 ){
                        bookings.addError('Room Not Available');
                    }
                    else if( bookings.Check_In__c >= existingBookings.Check_In__c && bookings.Check_In__c <= existingBookings.Check_Out__c - 45/1440 ){
                        bookings.addError('Room Not Available');
                    }
                    else if( bookings.Check_In__c <= existingBookings.Check_In__c && bookings.Check_Out__c >= existingBookings.Check_Out__c + 45/1440 ){
                        bookings.addError('Room Not Available');
                    }

                }


            }
        }

    }
}
