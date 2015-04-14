package org.blogdemo.travelagency.persistenceData;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class BookingService {

	public Booking createBooking(String id){
		Calendar cal = Calendar.getInstance();
		
		Booking booking = new Booking();
		booking.setBookingid(id);
		booking.setRecieveDate(cal.getTime());
		
		return booking;
	}
	
	public Map<String, Object> setBookingIdParam(String id){
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("bookingid", id);
		
		return param;
	}
	
	public CancelBooking createCancelBooking(String id){
		Calendar cal = Calendar.getInstance();
		
		CancelBooking cancelbooking = new CancelBooking();
		cancelbooking.setBookingid(id);
		cancelbooking.setRecieveDate(cal.getTime());
		
		return cancelbooking;
	}
}
