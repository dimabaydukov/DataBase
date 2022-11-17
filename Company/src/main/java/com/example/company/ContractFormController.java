package com.example.company;


import com.example.company.model.ContractModel;
import com.example.company.model.DataBaseHandler;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.stage.Stage;

import java.net.URL;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ResourceBundle;

public class ContractFormController implements Initializable {
    public TextField descriptionContract;
    public Label dateContract;
    public ComboBox<Integer> clientIdContract;
    public Button backButton;
    public Button saveButtonContract;
    private ContractModel contractModel = null;

    public void setContractModel(ContractModel contractModel){
        this.contractModel = contractModel;
    }

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
        Date date = Date.valueOf(LocalDate.now());
        int idClient = clientIdContract.getValue();

        if (contractModel == null)
            DataBaseHandler.addContract(description, date, idClient);
        else {
            contractModel.setDescription(description);
            contractModel.setClientId(idClient);
            DataBaseHandler.updateContract(contractModel);
        }

        Stage stageThis = (Stage) saveButtonContract.getScene().getWindow();
        stageThis.close();
    }

    public void setContractInForm(ContractModel contract){
        descriptionContract.setText(contract.getDescription());
        dateContract.setText(contract.getDateCreate().toString());
        clientIdContract.setValue(contract.getClientId());
    }

    public void onBackClick(){
        Stage stageThis = (Stage) backButton.getScene().getWindow();
        stageThis.close();
    }
}
