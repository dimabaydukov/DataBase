package com.example.company;

import com.example.company.model.DataBaseHandler;
import com.example.company.model.DetailModel;
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

public class NewDetailForTaskController implements Initializable {
    public ComboBox<Integer> idDetails;
    ObservableList<Integer> detailsIdList = FXCollections.observableArrayList();
    public Label nameLabel;
    public Label serialNumberLabel;
    public Button addButton;
    private int idTask;

    public void setIdTask(int idTask) {
        this.idTask = idTask;
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        idDetails.getItems().setAll(detailsIdList);
        try {
            detailsIdList.setAll(DataBaseHandler.selectAllDetailsId());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        idDetails.setItems(detailsIdList);

        nameLabel.setText(null);
        serialNumberLabel.setText(null);

        idDetails.setOnAction(event -> detailInformation(idDetails.getValue()));
    }

    private void detailInformation(int id){
        try {
            DetailModel detailModel = DataBaseHandler.selectDetail(id);
            assert detailModel != null;
            nameLabel.setText(detailModel.getName());
            serialNumberLabel.setText(detailModel.getSerialNumber());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void saveDetailInTask() throws SQLException {
        int idDetail = idDetails.getValue();
        DataBaseHandler.addTaskDetail(idTask, idDetail);
        Stage stageThis = (Stage) nameLabel.getScene().getWindow();
        stageThis.close();
    }
}
