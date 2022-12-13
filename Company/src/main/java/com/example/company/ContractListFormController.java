package com.example.company;

import com.example.company.model.ContractModel;
import com.example.company.model.DataBaseHandler;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class ContractListFormController implements Initializable {

    public TableView<ContractModel> listContracts;
    public Button editBtn;
    public Button deleteBtn;
    public Label descriptionLabel;
    public Label dateCreateLabel;
    public Label idClientLabel;
    public Label clientNameLabel;
    public Label petNameLabel;
    public Label kindOfAnimalLabel;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        ObservableList<ContractModel> contracts = FXCollections.observableArrayList();
        try {
            contracts.setAll(DataBaseHandler.selectAllContracts());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        listContracts.setItems(contracts);

        TableColumn<ContractModel, Integer> idColumn = new TableColumn<>("ID");
        idColumn.setCellValueFactory(new PropertyValueFactory<ContractModel, Integer>("id"));
        listContracts.getColumns().add(idColumn);

        showContractDetails(null);

        listContracts.getSelectionModel().selectedItemProperty().addListener(
                (observable, oldValue, newValue) -> showContractDetails(newValue)
        );
    }

    private void showContractDetails(ContractModel contract) {
        if (contract != null){
            descriptionLabel.setText(contract.getDescription());
            dateCreateLabel.setText(contract.getDateCreate().toString());
            idClientLabel.setText(String.valueOf(contract.getClientId()));
            String name = null;
            String petName = null;
            String kindOfAnimal = null;
            try {
                name = DataBaseHandler.selectClientsNameFromContract(contract.getClientId());
                petName = DataBaseHandler.selectPetsNameFromContract(contract.getPetId());
                kindOfAnimal = DataBaseHandler.selectKindOfAnimalFromContract(contract.getPetId());
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            clientNameLabel.setText(name);
            petNameLabel.setText(petName);
            kindOfAnimalLabel.setText(kindOfAnimal);
        }
        else {
            descriptionLabel.setText(null);
            dateCreateLabel.setText(null);
            idClientLabel.setText(null);
            clientNameLabel.setText(null);
            petNameLabel.setText(null);
            kindOfAnimalLabel.setText(null);
        }
    }

    public void deleteOnClick() throws SQLException {
        ContractModel selectedItem = listContracts.getSelectionModel().getSelectedItem();
        if (selectedItem != null){
            listContracts.getItems().remove(selectedItem);
            DataBaseHandler.deleteContract(selectedItem);
        }
    }

    public void editOnClick(){
        ContractModel selectedItem = listContracts.getSelectionModel().getSelectedItem();
        if (selectedItem != null){
            FXMLLoader fxmlLoader = new FXMLLoader();
            fxmlLoader.setLocation(getClass().getResource("contract_form.fxml"));
            Scene scene = null;
            try {
                scene = new Scene(fxmlLoader.load());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            Stage stage = new Stage();
            stage.setTitle("Contract");
            stage.setScene(scene);
            ContractFormController contractFormController = fxmlLoader.getController();
            contractFormController.setContractModel(selectedItem);
            contractFormController.setContractInForm(selectedItem);
            stage.show();
        }
    }
}
