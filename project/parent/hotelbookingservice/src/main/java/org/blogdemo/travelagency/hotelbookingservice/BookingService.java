package org.blogdemo.travelagency.hotelbookingservice;

import java.util.Calendar;

public class BookingService {

	public Booking createBooking(String id){
		Calendar cal = Calendar.getInstance();
		
		Booking booking = new Booking();
		booking.setBookingid(id);
		booking.setRecieveDate(cal.getTime());
		
		return booking;
	}
	
	public CancelBooking createCancelBooking(String id){
		Calendar cal = Calendar.getInstance();
		
		CancelBooking cancelbooking = new CancelBooking();
		cancelbooking.setBookingid(id);
		cancelbooking.setRecieveDate(cal.getTime());
		
		return cancelbooking;
	}
}
