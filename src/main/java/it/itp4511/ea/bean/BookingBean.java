package it.itp4511.ea.bean;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

public class BookingBean implements Serializable {
    private String id;
    private int status;
    private String user;
    private String venue;
    private UserBean userBean;
    private VenueBean venueBean;
    private Date book_date;
    private String guest;
    private Date check_in = null;
    private Date check_out = null;

    public BookingBean() {
    }

    public static BookingBean getBean(ResultSet result) throws SQLException {
        BookingBean booking = new BookingBean();
        booking.setId(result.getString("ID"));
        booking.setStatus(result.getInt("status"));
        booking.setUser(result.getString("user"));
        booking.setVenue(result.getString("venue"));
        booking.setBook_date(result.getDate("book_date"));
        booking.setGuest(result.getString("guest"));

        LocalDateTime check_in = result.getObject("check_in", LocalDateTime.class);
        if(check_in != null) booking.setCheck_in(Date.from(check_in.atZone(ZoneId.systemDefault()).toInstant()));
        LocalDateTime check_out = result.getObject("check_out", LocalDateTime.class);
        if(check_out != null) booking.setCheck_out(Date.from(check_out.atZone(ZoneId.systemDefault()).toInstant()));

        UserBean userBean = UserBean.getBean(result);
        booking.setUserBean(userBean);
        return booking;
    }

    public static BookingBean getBeanWithOutUser(ResultSet result) throws SQLException {
        BookingBean booking = new BookingBean();
        booking.setId(result.getString("ID"));
        booking.setStatus(result.getInt("status"));
        booking.setUser(result.getString("user"));
        booking.setVenue(result.getString("venue"));
        booking.setBook_date(result.getDate("book_date"));
        booking.setGuest(result.getString("guest"));

        LocalDateTime check_in = result.getObject("check_in", LocalDateTime.class);
        if(check_in != null) booking.setCheck_in(Date.from(check_in.atZone(ZoneId.systemDefault()).toInstant()));
        LocalDateTime check_out = result.getObject("check_out", LocalDateTime.class);
        if(check_out != null) booking.setCheck_out(Date.from(check_out.atZone(ZoneId.systemDefault()).toInstant()));

        return booking;
    }

    public VenueBean getVenueBean() {
        return venueBean;
    }

    public void setVenueBean(VenueBean venueBean) {
        this.venueBean = venueBean;
    }

    public UserBean getUserBean() {
        return userBean;
    }

    public void setUserBean(UserBean userBean) {
        this.userBean = userBean;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public Date getBook_date() {
        return book_date;
    }

    public void setBook_date(Date book_date) {
        this.book_date = book_date;
    }

    public String getGuest() {
        return guest;
    }

    public void setGuest(String guest) {
        this.guest = guest;
    }

    public Date getCheck_in() {
        return check_in;
    }

    public void setCheck_in(Date check_in) {
        this.check_in = check_in;
    }

    public Date getCheck_out() {
        return check_out;
    }

    public void setCheck_out(Date check_out) {
        this.check_out = check_out;
    }

    @Override
    public String toString() {
        return "BookingBean{" +
                "id='" + id + '\'' +
                ", status=" + status +
                ", user='" + user + '\'' +
                ", venue='" + venue + '\'' +
                ", userBean=" + userBean +
                ", venueBean=" + venueBean +
                ", book_date=" + book_date +
                ", guest='" + guest + '\'' +
                ", check_in=" + check_in +
                ", check_out=" + check_out +
                '}';
    }
}
