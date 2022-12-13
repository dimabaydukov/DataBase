package com.example.company;

import com.example.company.model.DataBaseHandler;
import com.example.company.model.EquipmentModel;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.sql.SQLException;

public class EquipmentFormController {
    public TextField nameEquipment;
    public TextField vendorCodeEquipment;
    public Button saveButtonDetail;
    public Button backButton;
    public Label labelError;
    public TextField typeEquipment;
    EquipmentModel equipmentModel = null;

    public void setDetailModel(EquipmentModel equipmentModel){
        this.equipmentModel = equipmentModel;
    }

    public void saveBtnOnClick() throws SQLException {
        labelError.setText("");
        String name = nameEquipment.getText().trim();
        int vendorCode = Integer.parseInt(vendorCodeEquipment.getText().trim());
        String type = typeEquipment.getText().trim();

        if (!name.equals("")  && name.length() <= 20 && type.length() <= 20) {
            if (equipmentModel == null)
                DataBaseHandler.addEquipment(name, vendorCode, type);
            else {
                equipmentModel.setName(name);
                equipmentModel.setVendorCode(vendorCode);
                equipmentModel.setType(type);
                DataBaseHandler.updateEquipment(equipmentModel);
            }

            Stage stageThis = (Stage) saveButtonDetail.getScene().getWindow();
            stageThis.close();
        }
        else if (name.equals(""))
            labelError.setText("Введены не все данные!!");
        else if (name.length() > 20)
            labelError.setText("Название не должно превышать 20 символов!");
    }

    public void setDetailInForm(EquipmentModel detail){
        nameEquipment.setText(detail.getName());
        vendorCodeEquipment.setText(String.valueOf(detail.getVendorCode()));
        typeEquipment.setText(detail.getType());
    }

    public void onBackClick(){
        Stage stageThis = (Stage) backButton.getScene().getWindow();
        stageThis.close();
    }
}
