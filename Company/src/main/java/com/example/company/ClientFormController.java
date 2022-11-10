package com.example.company;

import com.example.company.model.ClientModel;
import com.example.company.model.DataBaseHandler;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.sql.SQLException;

public class ClientFormController {
    public TextField nameClient;
    public TextField phoneNumberClient;
    public TextField emailClient;
    public TextField addressClient;
    public Button backButton;
    public Button saveButtonClient;
    public Label labelError;
    ClientModel clientModel = null;
    public void setClientModel(ClientModel clientModel){
        this.clientModel = clientModel;
    }

    public void saveBtnOnClick() throws SQLException {
        labelError.setText("");
        String name = nameClient.getText().trim();
        String phoneNumber = phoneNumberClient.getText().trim();
        String email = emailClient.getText().trim();
        String addressCl = addressClient.getText().trim();
        String type = "Потенциальный";

        if (phoneNumber.length() <= 11 && email.length() <= 30 && addressCl.length() <= 50 && name.length() <= 30
        && !phoneNumber.equals(null) && !nameClient.equals(null)) {
            if (clientModel == null)
                DataBaseHandler.addClient(name, phoneNumber, email, addressCl, type);
            else {
                clientModel.setAddress(addressCl);
                clientModel.setName(name);
                clientModel.setEmail(email);
                clientModel.setPhoneNumber(phoneNumber);
                DataBaseHandler.updateClient(clientModel);
            }

            Stage stageThis = (Stage) saveButtonClient.getScene().getWindow();
            stageThis.close();
        }
        else if (phoneNumber.equals("") || nameClient.equals(""))
            labelError.setText("Номер телефона и Имя клиента обязательны для заполнения!!!");
        else if (phoneNumber.length() > 11)
            labelError.setText("Номер телефона не должен превышать 11 символов!");
        else if (email.length() > 30)
            labelError.setText("Эл. почта не должена превышать 30 символов!");
        else if (addressCl.length() > 50)
            labelError.setText("Адрес не должен превышать 50 символов!");
        else if (name.length() > 30)
            labelError.setText("Имя клиента не должно превышать 30 символов!");
    }

    public void setClientInForm(ClientModel client){
        nameClient.setText(client.getName());
        phoneNumberClient.setText(client.getPhoneNumber());
        emailClient.setText(client.getEmail());
        addressClient.setText(client.getAddress());
    }
}
