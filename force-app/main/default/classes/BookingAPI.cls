@RestResource(urlmapping = '/booking')
global with sharing class BookingAPI {
    
    @HttpGet
    global static String  getRecords(){
        RestRequest req = RestContext.request;
        Map<String, String > params = req.params;
        Hotel__c hotel = [ Select id, Name, Location__c, Club_Rooms__c,Plunge_Pool_Rooms__c, Plunge_Pool_Suites__c, Suites__c, Deluxe_Rooms__c From Hotel__c where Name = :params.get('Name') LIMIT 1];
        List<Booking__c> deluxeBookings = [ Select Name, Check_In__c, Check_Out__c, Total_Cost__c, Customer_Name__c, Hotel_Name__c, Room_Type__c from Booking__c where Room_Type__c = 'Deluxe Room' AND Hotel_Name__c = :params.get('Name') ];
        List<Booking__c> clubBookings =   [ Select Name, Check_In__c, Check_Out__c, Total_Cost__c, Customer_Name__c, Hotel_Name__c, Room_Type__c from Booking__c where Room_Type__c = 'Club Room' AND Hotel_Name__c = :params.get('Name') ];
        List<Booking__c> suiteBookings =  [ Select Name, Check_In__c, Check_Out__c, Total_Cost__c, Customer_Name__c, Hotel_Name__c, Room_Type__c from Booking__c where Room_Type__c = 'Suite' AND Hotel_Name__c = :params.get('Name') ];
        List<Booking__c> pprBookings =    [ Select Name, Check_In__c, Check_Out__c, Total_Cost__c, Customer_Name__c, Hotel_Name__c, Room_Type__c from Booking__c where Room_Type__c = 'Plunge Pool Lounge' AND Hotel_Name__c = :params.get('Name') ];
        List<Booking__c> ppsBookings =    [ Select Name, Check_In__c, Check_Out__c, Total_Cost__c, Customer_Name__c, Hotel_Name__c, Room_Type__c from Booking__c where Room_Type__c = 'Plunge Pool Suite' AND Hotel_Name__c = :params.get('Name') ];
        Map<String, Object> finalResponse = new Map<String,Object>();
        Map<String, Object> hotelResponse = new Map<String,Object>();
        List<Map<String, Object>> drRes = new List<Map<String,Object>>();
        List<Map<String, Object>> sRes = new List<Map<String,Object>>();
        List<Map<String, Object>> crRes = new List<Map<String,Object>>();
        List<Map<String, Object>> pprRes = new List<Map<String,Object>>();
        List<Map<String, Object>> ppsRes = new List<Map<String,Object>>();
        hotelResponse.put('Branck', hotel.Location__c);
        for(Booking__c booking: deluxeBookings)
        {
            Map<String, Object> bookingMap = new Map<String, Object> ();
            bookingMap.put('Booking Number', booking.Name);
            bookingMap.put('Person Name', booking.Customer_Name__c);
            bookingMap.put('Date of Check In', booking.Check_In__c.date());
            bookingMap.put('Date of Check Out', booking.Check_Out__c.date());
            bookingMap.put('Date of Check In', booking.Check_In__c.getTime());
            bookingMap.put('Date of Check Out', booking.Check_Out__c.getTime());
            drRes.add(bookingMap);
        }
        for(Booking__c booking: clubBookings)
        {
            Map<String, Object> bookingMap = new Map<String, Object> ();
            bookingMap.put('Booking Number', booking.Name);
            bookingMap.put('Person Name', booking.Customer_Name__c);
            bookingMap.put('Date of Check In', booking.Check_In__c.date());
            bookingMap.put('Date of Check Out', booking.Check_Out__c.date());
            bookingMap.put('Date of Check In', booking.Check_In__c.getTime());
            bookingMap.put('Date of Check Out', booking.Check_Out__c.getTime());
            crRes.add(bookingMap);
        }
        for(Booking__c booking: suiteBookings)
        {
            Map<String, Object> bookingMap = new Map<String, Object> ();
            bookingMap.put('Booking Number', booking.Name);
            bookingMap.put('Person Name', booking.Customer_Name__c);
            bookingMap.put('Date of Check In', booking.Check_In__c.date());
            bookingMap.put('Date of Check Out', booking.Check_Out__c.date());
            bookingMap.put('Date of Check In', booking.Check_In__c.getTime());
            bookingMap.put('Date of Check Out', booking.Check_Out__c.getTime());
            sRes.add(bookingMap);
        }
        for(Booking__c booking: pprBookings)
        {
            Map<String, Object> bookingMap = new Map<String, Object> ();
            bookingMap.put('Booking Number', booking.Name);
            bookingMap.put('Person Name', booking.Customer_Name__c);
            bookingMap.put('Date of Check In', booking.Check_In__c.date());
            bookingMap.put('Date of Check Out', booking.Check_Out__c.date());
            bookingMap.put('Date of Check In', booking.Check_In__c.getTime());
            bookingMap.put('Date of Check Out', booking.Check_Out__c.getTime());
            pprRes.add(bookingMap);
        }
        for(Booking__c booking: ppsBookings)
        {
            Map<String, Object> bookingMap = new Map<String, Object> ();
            bookingMap.put('Booking Number', booking.Name);
            bookingMap.put('Person Name', booking.Customer_Name__c);
            bookingMap.put('Date of Check In', booking.Check_In__c.date());
            bookingMap.put('Date of Check Out', booking.Check_Out__c.date());
            bookingMap.put('Date of Check In', booking.Check_In__c.getTime());
            bookingMap.put('Date of Check Out', booking.Check_Out__c.getTime());
            ppsRes.add(bookingMap);
        }
        Map<String, Object> droomResponse = new Map<String,Object>();
        Map<String, Object> croomResponse = new Map<String,Object>();
        Map<String, Object> sroomResponse = new Map<String,Object>();
        Map<String, Object> prResponse = new Map<String,Object>();
        Map<String, Object> psResponse = new Map<String,Object>();
        droomResponse.put('Hotel Room Count', hotel.Deluxe_Rooms__c);
        droomResponse.put('Bookings', drRes); 
        croomResponse.put('Hotel Room Count', hotel.Club_Rooms__c);
        croomResponse.put('Bookings', crRes); 
        sroomResponse.put('Hotel Room Count', hotel.Suites__c);
        sroomResponse.put('Bookings', sRes); 
        prResponse.put('Hotel Room Count', hotel.Plunge_Pool_Suites__c);
        prResponse.put('Bookings', ppsRes); 
        psResponse.put('Hotel Room Count', hotel.Plunge_Pool_Rooms__c);
        psResponse.put('Bookings', pprRes); 
        hotelResponse.put('Deluxe Room', droomResponse);
        hotelResponse.put('Club Room', croomResponse);
        hotelResponse.put('Suite', sroomResponse);
        hotelResponse.put('Plunge Pool Room', prResponse);
        hotelResponse.put('Plunge Pool Suite', psResponse);
        finalResponse.put( hotel.Name, hotelResponse );
        
        return finalResponse.toString();
    }

    @HttpPost
    global static void createRecord(){
        RestRequest req = RestContext.request;
        System.debug(req.requestBody.toString());
        Map<String, Object> resmap = (Map<String, Object>)JSON.deserializeUntyped(req.requestBody.toString());        
        List<Object> bookingsList = (List<Object>) resmap.get('Bookings');
        System.debug(bookingsList);
        for( Object o : bookingsList ){
            Object v1 = o;
            Map<String,String> Booking = (Map<String,String>) v1;
            String hotelName = booking.get('Hotel Branch Name');
            String branch = booking.get('Branch');
            String roomType = booking.get('Room Type');
            DateTime checkIN = Datetime.parse(booking.get('Date of CheckIn') + ' ;' + booking.get('Hour of CheckIn') ); 
            DateTime checkOut = Datetime.parse(booking.get('Date of Checkout') + ' ;' + booking.get('Hour of Checkout'));
            String Customer = booking.get('Person Name');
            Hotel__c hotel = [ SELECT Name, id , Location__c From Hotel__c WHERE Name Like :hotelName AND Location__c = :branch ];
            
                
        }
    }

}
