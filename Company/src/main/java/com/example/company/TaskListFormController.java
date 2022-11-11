package com.example.company;

import com.example.company.model.DataBaseHandler;
import com.example.company.model.TaskModel;
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
import java.util.logging.Level;
import java.util.logging.Logger;

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
    public static boolean techSpec = false;
    public Label managerLabel;

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

        showTaskDetails(null);

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
            managerLabel.setText(task.getManager());
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
            managerLabel.setText(null);
        }
    }

    public void deleteOnClick() throws SQLException {
        TaskModel selectedItem = listTasks.getSelectionModel().getSelectedItem();
        if (selectedItem != null){
            listTasks.getItems().remove(selectedItem);
            DataBaseHandler.deleteTask(selectedItem);
        }
    }

    public void editOnClick(){
        try{
            TaskModel selectedItem = listTasks.getSelectionModel().getSelectedItem();
            if (selectedItem != null) {
                FXMLLoader fxmlLoader = new FXMLLoader();
                fxmlLoader.setLocation(getClass().getResource("task_form.fxml"));
                Scene scene = new Scene(fxmlLoader.load());
                Stage stage = new Stage();
                stage.setTitle("Task");
                stage.setScene(scene);
                TaskFormController taskFormController = fxmlLoader.getController();
                taskFormController.setTaskModel(selectedItem);
                taskFormController.setTaskInForm(selectedItem);
                if (techSpec){
                    taskFormController.setUnAvailable();
                }
                stage.show();
            }
        } catch (IOException e) {
            Logger logger = Logger.getLogger(getClass().getName());
            logger.log(Level.SEVERE, "Failed to create new Window.", e);
        }
    }

    public void setUnVisible(){
        deleteBtn.setVisible(false);
    }
}
