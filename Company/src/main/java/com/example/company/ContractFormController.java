package com.example.company;


import com.example.company.model.DataBaseHandler;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.DatePicker;
import javafx.scene.control.TextField;

import java.net.URL;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class ContractFormController implements Initializable {
    public TextField descriptionContract;
    public DatePicker dateContract;
    public ComboBox<Integer> clientIdContract;
    public Button backButton;
    public Button saveButtonContract;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        ObservableList<Integer> items = FXCollections.observableArrayList();
        clientIdContract.getItems().setAll(items);
        try {
            items.setAll(DataBaseHandler.selectIdClients());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        clientIdContract.setItems(items);
    }

    public void saveBtnOnClick() throws SQLException {
        String description = descriptionContract.getText().trim();
        Date date = Date.valueOf(dateContract.getValue());
        int idClient = clientIdContract.getValue();

        DataBaseHandler dataBaseHandler = new DataBaseHandler();
        dataBaseHandler.addContract(description, date, idClient);
    }
}
