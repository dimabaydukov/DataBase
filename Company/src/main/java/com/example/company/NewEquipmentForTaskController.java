package com.example.company;

import com.example.company.model.DataBaseHandler;
import com.example.company.model.EquipmentModel;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.stage.Stage;

import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class NewEquipmentForTaskController implements Initializable {
    public ComboBox<Integer> idEquipments;
    ObservableList<Integer> equipmentsIdList = FXCollections.observableArrayList();
    public Label nameLabel;
    public Label vendorCodeLabel;
    public Button addButton;
    private int idTask;

    public void setIdTask(int idTask) {
        this.idTask = idTask;
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        idEquipments.getItems().setAll(equipmentsIdList);
        try {
            equipmentsIdList.setAll(DataBaseHandler.selectAllEquipmentsId());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        idEquipments.setItems(equipmentsIdList);

        nameLabel.setText(null);
        vendorCodeLabel.setText(null);

        idEquipments.setOnAction(event -> detailInformation(idEquipments.getSelectionModel().getSelectedItem()));
    }

    private void detailInformation(int id){
        try {
            EquipmentModel equipmentModel = DataBaseHandler.selectEquipment(id);
            if (equipmentModel != null) {
                nameLabel.setText(equipmentModel.getName());
                vendorCodeLabel.setText(String.valueOf(equipmentModel.getVendorCode()));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void saveEquipmentInTask() throws SQLException {
        int idEquipment = idEquipments.getValue();
        DataBaseHandler.addTaskEquipment(idTask, idEquipment);
        Stage stageThis = (Stage) nameLabel.getScene().getWindow();
        stageThis.close();
    }
}
