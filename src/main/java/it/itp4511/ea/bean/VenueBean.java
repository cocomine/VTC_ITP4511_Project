package it.itp4511.ea.bean;

import java.io.Serializable;

public class VenueBean implements Serializable {
    private String location;
    private String name;
    private String description;
    private int max;
    private double fee;
    private String image;

    public VenueBean() {
    }

    public VenueBean(String location, String name, String description, int max, double fee, String image) {
        this.location = location;
        this.name = name;
        this.description = description;
        this.max = max;
        this.fee = fee;
        this.image = image;
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
}
