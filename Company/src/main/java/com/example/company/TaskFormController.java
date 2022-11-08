package com.example.company;

import com.example.company.model.DataBaseHandler;
import com.example.company.model.TaskModel;
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
    ObservableList<Integer> priorityList = FXCollections.observableArrayList(1,2,3);
    ObservableList<Integer> contractList = FXCollections.observableArrayList();
    ObservableList<String> employeeList = FXCollections.observableArrayList();
    TaskModel taskModel = null;

    public void setTaskModel(TaskModel taskModel) {
        this.taskModel = taskModel;
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        priorityTask.getItems().setAll(priorityList);

        contractTask.getItems().setAll(contractList);
        try {
            contractList.setAll(DataBaseHandler.selectIdContracts());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        contractTask.setItems(contractList);

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

        if (taskModel == null)
            DataBaseHandler.addTask(name, description, dateCreate, deadline, priority, status, idContract, employeeName);
        else {
            taskModel.setName(name);
            taskModel.setDescription(description);
            taskModel.setDeadline(deadline);
            taskModel.setPriority(priority);
            taskModel.setContractId(idContract);
            taskModel.setEmpName(employeeName);
            if (dateEndTask.getValue() != null && !dateEndTask.getValue().toString().equals("")){
                taskModel.setStatus(true);
                taskModel.setDateEnd(Date.valueOf(dateEndTask.getValue()));
            }
            DataBaseHandler.updateTask(taskModel);
        }

        Stage stageThis = (Stage) saveButtonTask.getScene().getWindow();
        stageThis.close();
    }

    public void setTaskInForm(TaskModel task){
        nameTask.setText(task.getName());
        descriptionTask.setText(task.getDescription());
        priorityTask.setValue(Integer.valueOf(task.getPriority()));
        if (task.getEmpName() != null)
            employeeTask.setValue(task.getEmpName());
        contractTask.setValue(task.getContractId());
        dateCreateTask.setText(task.getDateCreate().toString());
        dateDeadlineTask.setValue(task.getDeadline().toLocalDate());
        if (task.getDateEnd() != null)
            dateEndTask.setValue(task.getDateEnd().toLocalDate());
        String status;
        if (!task.isStatus())
            status = "В процессе";
        else
            status = "Выполнено";
        statusTask.setText(status);
    }
}
