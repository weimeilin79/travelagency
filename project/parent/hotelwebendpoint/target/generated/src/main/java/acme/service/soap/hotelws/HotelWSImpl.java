
/**
 * Please modify this class to meet your needs
 * This class is not complete
 */

package acme.service.soap.hotelws;

import java.util.logging.Logger;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;

/**
 * This class was generated by Apache CXF 2.7.0.redhat-610379
 * 2015-04-30T18:46:23.350+08:00
 * Generated source version: 2.7.0.redhat-610379
 * 
 */

@javax.jws.WebService(
                      serviceName = "HotelWS",
                      portName = "HotelWSImplPort",
                      targetNamespace = "http://soap.service.acme/HotelWS/",
                      wsdlLocation = "file:/Users/christina/Desktop/jboss-fuse-travelagency/project/parent/hotelwebendpoint/src/main/resources/wsdl/HotelWS.wsdl",
                      endpointInterface = "acme.service.soap.hotelws.HotelWS")
                      
public class HotelWSImpl implements HotelWS {

    private static final Logger LOG = Logger.getLogger(HotelWSImpl.class.getName());

    /* (non-Javadoc)
     * @see acme.service.soap.hotelws.HotelWS#bookHotel(java.lang.String  in )*
     */
    public java.lang.String bookHotel(java.lang.String in) { 
        LOG.info("Executing operation bookHotel");
        System.out.println(in);
        try {
            java.lang.String _return = "";
            return _return;
        } catch (java.lang.Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex);
        }
    }

    /* (non-Javadoc)
     * @see acme.service.soap.hotelws.HotelWS#cancelBooking(java.lang.String  in )*
     */
    public int cancelBooking(java.lang.String in) { 
        LOG.info("Executing operation cancelBooking");
        System.out.println(in);
        try {
            int _return = 0;
            return _return;
        } catch (java.lang.Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex);
        }
    }

    /* (non-Javadoc)
     * @see acme.service.soap.hotelws.HotelWS#getAvailableHotel(acme.service.soap.hotelws.HotelRequest  in )*
     */
    public acme.service.soap.hotelws.Resort getAvailableHotel(acme.service.soap.hotelws.HotelRequest in) { 
        LOG.info("Executing operation getAvailableHotel");
        System.out.println(in);
        try {
            acme.service.soap.hotelws.Resort _return = null;
            return _return;
        } catch (java.lang.Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex);
        }
    }

}