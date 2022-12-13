package com.example.company.model;

public class EquipmentModel {
    private int id;
    private String name;
    private int vendorCode;
    private String type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getVendorCode() {
        return vendorCode;
    }

    public void setVendorCode(int serialNumber) {
        this.vendorCode = serialNumber;
    }
}
