package com.example.company;

import com.example.company.model.DataBaseHandler;
import com.example.company.model.TaskModel;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

import java.net.URL;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class TaskListFormController implements Initializable {
    public TableView<TaskModel> listTasks = new TableView<>();
    public Button editBtn;
    public Button deleteBtn;
    public Label nameLabel;
    public Label descriptionLabel;
    public Label dateCreateLabel;
    public Label dateDeadlineLabel;
    public Label priorityLabel;
    public Label employeeLabel;
    public Label contractLabel;
    public Label statusLabel;
    public Label dateEndLabel;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        ObservableList<TaskModel> tasks = FXCollections.observableArrayList();
        try {
            tasks.setAll(DataBaseHandler.selectAllTasks());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        listTasks.setItems(tasks);

        TableColumn<TaskModel, Integer> idColumn = new TableColumn<TaskModel, Integer>("ID");
        idColumn.setCellValueFactory(new PropertyValueFactory<TaskModel, Integer>("id"));
        listTasks.getColumns().add(idColumn);

        TableColumn<TaskModel, String> nameColumn = new TableColumn<TaskModel, String>("Название");
        nameColumn.setCellValueFactory(new PropertyValueFactory<TaskModel, String>("name"));
        listTasks.getColumns().add(nameColumn);

        /*TableColumn<TaskModel, Date> deadlineColumn = new TableColumn<TaskModel, Date>("Дедлайн");
        deadlineColumn.setCellValueFactory(new PropertyValueFactory<TaskModel, Date>("deadline"));
        listTasks.getColumns().add(deadlineColumn);

        TableColumn<TaskModel, String> priorityColumn = new TableColumn<TaskModel, String>("Приоритет");
        priorityColumn.setCellValueFactory(new PropertyValueFactory<TaskModel, String>("priority"));
        listTasks.getColumns().add(priorityColumn);

        TableColumn<TaskModel, Boolean> statusColumn = new TableColumn<TaskModel, Boolean>("Статус");
        statusColumn.setCellValueFactory(new PropertyValueFactory<TaskModel, Boolean>("status"));
        listTasks.getColumns().add(statusColumn);

        TableColumn<TaskModel, String> empColumn = new TableColumn<TaskModel, String>("Сотрудник");
        empColumn.setCellValueFactory(new PropertyValueFactory<TaskModel, String>("empName"));
        listTasks.getColumns().add(empColumn);*/

        listTasks.getSelectionModel().selectedItemProperty().addListener(
                (observable, oldValue, newValue) -> showTaskDetails(newValue)
        );
    }

    private void showTaskDetails(TaskModel task){
        if (task != null){
            nameLabel.setText(task.getName());
            descriptionLabel.setText(task.getDescription());
            dateCreateLabel.setText(task.getDateCreate().toString());
            dateDeadlineLabel.setText(task.getDeadline().toString());
            priorityLabel.setText(task.getPriority());
            if (task.getDateEnd() != null)
                dateEndLabel.setText(task.getDateEnd().toString());
            else
                dateEndLabel.setText(null);
            contractLabel.setText(String.valueOf(task.getContractId()));
            if (task.getEmpName() != null)
                employeeLabel.setText(task.getEmpName());
            else
                employeeLabel.setText(null);
            String st;
            if (!task.isStatus()){
                st = "В процессе";
            }
            else {
                st = "Завершено";
            }
            statusLabel.setText(st);
        }
        else{
            nameLabel.setText(null);
            descriptionLabel.setText(null);
            dateCreateLabel.setText(null);
            dateDeadlineLabel.setText(null);
            priorityLabel.setText(null);
            dateEndLabel.setText(null);
            contractLabel.setText(null);
            employeeLabel.setText(null);
            statusLabel.setText(null);
        }
    }
}
