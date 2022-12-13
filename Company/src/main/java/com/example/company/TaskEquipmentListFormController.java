package com.example.company;

import com.example.company.model.DataBaseHandler;
import com.example.company.model.EquipmentModel;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class TaskEquipmentListFormController implements Initializable {
    public TableView<EquipmentModel> listEquipments;
    public Label nameLabel;
    public Label vendorCodeLabel;
    public Button deleteBtn;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        ObservableList<EquipmentModel> equipments = FXCollections.observableArrayList();
        try {
            equipments.addAll(DataBaseHandler.selectAllEquipmentsFromTask(TaskListFormController.getIdSelectedTask()));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        listEquipments.setItems(equipments);

        TableColumn<EquipmentModel, Integer> idColumn = new TableColumn<>("ID");
        idColumn.setCellValueFactory(new PropertyValueFactory<EquipmentModel, Integer>("id"));
        listEquipments.getColumns().add(idColumn);

        TableColumn<EquipmentModel, String> nameColumn = new TableColumn<>("Имя");
        nameColumn.setCellValueFactory(new PropertyValueFactory<EquipmentModel, String>("name"));
        listEquipments.getColumns().add(nameColumn);

        showEquipmentDetails(null);

        listEquipments.getSelectionModel().selectedItemProperty().addListener(
                (observable, oldValue, newValue) -> showEquipmentDetails(newValue)
        );
    }

    private void showEquipmentDetails(EquipmentModel equipmentModel) {
        if (equipmentModel != null) {
            nameLabel.setText(equipmentModel.getName());
            vendorCodeLabel.setText(String.valueOf(equipmentModel.getVendorCode()));
        }
        else {
            nameLabel.setText(null);
            vendorCodeLabel.setText(null);
        }
    }

    public void deleteOnClick() throws SQLException {
        EquipmentModel selectedItem = listEquipments.getSelectionModel().getSelectedItem();
        if (selectedItem != null){
            listEquipments.getItems().remove(selectedItem);
            DataBaseHandler.deleteEquipmentFromTask(TaskListFormController.getIdSelectedTask(), selectedItem.getId());
        }
    }

    public void setUnVisible(){
        deleteBtn.setVisible(false);
    }
}
