package com.example.company;

import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.stage.Stage;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ManagerStartFormController {
    public Button addNewTaskBtn;
    public Button allTasksBtn;
    public Button addNewContractBtn;
    public Button addNewClientBtn;
    public Button allClientsBtn;
    public Button addNewDetailBtn;
    public Button allDetailsBtn;


    public void addNewTaskForm(){
        try{
            FXMLLoader fxmlLoader = new FXMLLoader();
            fxmlLoader.setLocation(getClass().getResource("task_form.fxml"));
            Scene scene = new Scene(fxmlLoader.load());
            Stage stage = new Stage();
            stage.setTitle("Task");
            stage.setScene(scene);
            stage.show();

            Stage stageThis = (Stage) addNewTaskBtn.getScene().getWindow();
            stageThis.close();
        } catch (IOException e) {
            Logger logger = Logger.getLogger(getClass().getName());
            logger.log(Level.SEVERE, "Failed to create new Window.", e);
        }
    }
}
