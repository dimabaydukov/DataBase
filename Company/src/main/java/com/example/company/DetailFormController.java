package com.example.company;

import com.example.company.model.DataBaseHandler;
import com.example.company.model.DetailModel;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.sql.SQLException;

public class DetailFormController {
    public TextField nameDetail;
    public TextField serialNumberDetail;
    public Button saveButtonDetail;
    public Button backButton;
    public Label labelError;
    DetailModel detailModel = null;

    public void setDetailModel(DetailModel detailModel){
        this.detailModel = detailModel;
    }

    public void saveBtnOnClick() throws SQLException {
        labelError.setText("");
        String name = nameDetail.getText().trim();
        String serialNumber = serialNumberDetail.getText().trim();

        if (!name.equals("") && serialNumber.equals("") && name.length() <= 20 && serialNumber.length() <= 50) {
            if (detailModel == null)
                DataBaseHandler.addDetail(name, serialNumber);
            else {
                detailModel.setName(name);
                detailModel.setSerialNumber(serialNumber);
                DataBaseHandler.updateDetail(detailModel);
            }

            Stage stageThis = (Stage) saveButtonDetail.getScene().getWindow();
            stageThis.close();
        }
        else if (name.equals(null) && serialNumber.equals(null))
            labelError.setText("Введены не все данные!!");
        else if (name.length() > 20)
            labelError.setText("Название не должно превышать 20 символов!");
        else if (serialNumber.length() > 50)
            labelError.setText("Серийный номер не должен превышать 50 символов!");
    }

    public void setDetailInForm(DetailModel detail){
        nameDetail.setText(detail.getName());
        serialNumberDetail.setText(detail.getSerialNumber());
    }

    public void onBackClick(){
        Stage stageThis = (Stage) backButton.getScene().getWindow();
        stageThis.close();
    }
}
