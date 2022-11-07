package com.example.company;

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

public class TaskFormController implements Initializable {
    public TextField nameTask;
    public DatePicker dateDeadlineTask;
    public ComboBox<Integer> priorityTask;
    public ComboBox<Integer> contractTask;
    public ComboBox<String> employeeTask;
    public DatePicker dateEndTask;
    public Label dateCreateTask;
    public Label statusTask;
    public Button saveButtonTask;
    public Button backButton;
    public TextArea descriptionTask;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        ObservableList<Integer> priorityList = FXCollections.observableArrayList(1,2,3);
        priorityTask.getItems().setAll(priorityList);

        ObservableList<Integer> contractList = FXCollections.observableArrayList();
        contractTask.getItems().setAll(contractList);
        try {
            contractList.setAll(DataBaseHandler.selectIdContracts());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        contractTask.setItems(contractList);

        ObservableList<String> employeeList = FXCollections.observableArrayList();
        employeeTask.getItems().setAll(employeeList);
        try {
            employeeList.setAll(DataBaseHandler.selectEmployeeNames());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        employeeTask.setItems(employeeList);
    }

    public void saveBtnOnClick() throws SQLException {
        String name = nameTask.getText().trim();
        String description = descriptionTask.getText().trim();
        Date dateCreate = Date.valueOf(LocalDate.now());
        Date deadline = Date.valueOf(dateDeadlineTask.getValue());
        String priority = priorityTask.getValue().toString();
        boolean status = false;
        int idContract = contractTask.getValue();
        String employeeName = employeeTask.getValue();

        DataBaseHandler dataBaseHandler = new DataBaseHandler();
        dataBaseHandler.addTask(name, description, dateCreate, deadline, priority, status, idContract, employeeName);

        Stage stageThis = (Stage) saveButtonTask.getScene().getWindow();
        stageThis.close();
    }
}
