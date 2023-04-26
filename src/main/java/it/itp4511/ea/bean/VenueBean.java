package it.itp4511.ea.bean;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;

public class VenueBean implements Serializable {

    private String id;
    private String location;
    private String name;
    private String description;
    private int max;
    private double fee;
    private String image;
    private boolean enable = true;

    public VenueBean() {
    }

    public VenueBean(String id, String location, String name, String description, int max, double fee, String image, boolean enable) {
        this.id = id;
        this.location = location;
        this.name = name;
        this.description = description;
        this.max = max;
        this.fee = fee;
        this.image = image;
        this.enable = enable;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getMax() {
        return max;
    }

    public void setMax(int max) {
        this.max = max;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public boolean isEnable() {
        return enable;
    }

    public void setEnable(boolean enable) {
        this.enable = enable;
    }

    public static VenueBean getBean(ResultSet result) throws SQLException {
        VenueBean venue = new VenueBean();
        venue.setId(result.getString("ID"));
        venue.setName(result.getString("name"));
        venue.setLocation(result.getString("location"));
        venue.setDescription(result.getString("description"));
        venue.setMax(result.getInt("max"));
        venue.setFee(result.getDouble("fee"));
        venue.setImage(result.getString("image"));
        venue.setEnable(result.getBoolean("enable"));
        return venue;
    }
}
