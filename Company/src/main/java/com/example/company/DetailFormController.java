package com.example.company;

import com.example.company.model.DataBaseHandler;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;

import java.sql.SQLException;

public class DetailFormController {
    public TextField nameDetail;
    public TextField serialNumberDetail;
    public Button saveButtonDetail;
    public Button backButton;

    public void saveBtnOnClick(){
        String name = nameDetail.getText().trim();
        String serialNumber = serialNumberDetail.getText().trim();

        DataBaseHandler dataBaseHandler = new DataBaseHandler();
        try {
            dataBaseHandler.addDetail(name, serialNumber);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
