package com.example.company;

import com.example.company.model.DataBaseHandler;
import com.example.company.model.EquipmentModel;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class EquipmentListFormController implements Initializable {
    public TableView<EquipmentModel> listDetails;
    public Label nameLabel;
    public Label vendorCodeLabel;
    public Button editBtn;
    public Button deleteBtn;
    public Label typeLabel;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        ObservableList<EquipmentModel> equipments = FXCollections.observableArrayList();
        try {
            equipments.addAll(DataBaseHandler.selectAllEquipments());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        listDetails.setItems(equipments);

        TableColumn<EquipmentModel, Integer> idColumn = new TableColumn<>("ID");
        idColumn.setCellValueFactory(new PropertyValueFactory<EquipmentModel, Integer>("id"));
        listDetails.getColumns().add(idColumn);

        TableColumn<EquipmentModel, String> nameColumn = new TableColumn<>("Имя");
        nameColumn.setCellValueFactory(new PropertyValueFactory<EquipmentModel, String>("name"));
        listDetails.getColumns().add(nameColumn);

        showEquipmentDetails(null);

        listDetails.getSelectionModel().selectedItemProperty().addListener(
                (observable, oldValue, newValue) -> showEquipmentDetails(newValue)
        );
    }

    private void showEquipmentDetails(EquipmentModel detail) {
        if (detail != null) {
            nameLabel.setText(detail.getName());
            vendorCodeLabel.setText(String.valueOf(detail.getVendorCode()));
            typeLabel.setText(detail.getType());
        }
        else {
            nameLabel.setText(null);
            vendorCodeLabel.setText(null);
            typeLabel.setText(null);
        }
    }

    public void deleteOnClick() throws SQLException {
        EquipmentModel selectedItem = listDetails.getSelectionModel().getSelectedItem();
        if (selectedItem != null){
            listDetails.getItems().remove(selectedItem);
            DataBaseHandler.deleteEquipment(selectedItem);
        }
    }

    public void editOnClick(){
        EquipmentModel selectedItem = listDetails.getSelectionModel().getSelectedItem();
        if (selectedItem != null){
            FXMLLoader fxmlLoader = new FXMLLoader();
            fxmlLoader.setLocation(getClass().getResource("equipment_form.fxml"));
            Scene scene = null;
            try {
                scene = new Scene(fxmlLoader.load());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            Stage stage = new Stage();
            stage.setTitle("Equipment");
            stage.setScene(scene);
            EquipmentFormController equipmentFormController = fxmlLoader.getController();
            equipmentFormController.setDetailModel(selectedItem);
            equipmentFormController.setDetailInForm(selectedItem);
            stage.show();
        }
    }

    public void setUnVisible(){
        deleteBtn.setVisible(false);
    }
}
