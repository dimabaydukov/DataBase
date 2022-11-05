package com.example.company;

import com.example.company.model.DataBaseHandler;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;

import java.sql.SQLException;

public class ClientFormController {
    public TextField nameClient;
    public TextField phoneNumberClient;
    public TextField emailClient;
    public TextField addressClient;
    public Button backButton;
    public Button saveButtonClient;

    public void saveBtnOnClick(){
        String name = nameClient.getText().trim();
        String phoneNumber = phoneNumberClient.getText().trim();
        String email = emailClient.getText().trim();
        String addressCl = addressClient.getText().trim();
        String type = "Потенциальный";

        DataBaseHandler dataBaseHandler = new DataBaseHandler();
        try {
            dataBaseHandler.addClient(name, phoneNumber, email, addressCl, type);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
