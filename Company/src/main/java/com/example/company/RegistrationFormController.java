package com.example.company;

import com.example.company.model.DataBaseHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RegistrationFormController {
    public TextField loginNewUser;
    public TextField passwordNewUser;
    @FXML
    public ChoiceBox<String> choiceRole;
    public Button registrationButton;
    public Button backButton;
    public Label labelError;

    public void onRegistrationClick() throws SQLException, ClassNotFoundException {
        String login = loginNewUser.getText().trim();
        String pass = passwordNewUser.getText().trim();
        String role = choiceRole.getSelectionModel().getSelectedItem();;

        labelError.setText("");
        if (role != null && !role.equals("")) {
            if (choiceRole.getValue().equals("Тех специалист"))
                role = "tech_spec";
            else
                role = "manager";

            if (!login.equals("") && !login.equals("Введите логин!!!") &&
                    !pass.equals("") && !pass.equals("Введите пароль!!!")){
                DataBaseHandler dataBaseHandler = new DataBaseHandler();
                boolean flag = dataBaseHandler.registering(login, pass, role);
                if (flag){
                    //переход на новую страницу
                }
                else
                    labelError.setText("Такой логин уже существует!");
            }
            else if (login.equals(""))
                loginNewUser.setText("Введите логин!!!");
            else
                passwordNewUser.setText("Введите пароль!!!");
        }
        else
            labelError.setText("Необходимо выбрать роль!!!");
    }

    public void onBackClick(){
        try {
            FXMLLoader fxmlLoader = new FXMLLoader();
            fxmlLoader.setLocation(getClass().getResource("hello-view.fxml"));
            Scene scene = new Scene(fxmlLoader.load());
            Stage stage = new Stage();
            stage.setTitle("Hello!");
            stage.setScene(scene);
            stage.show();

            Stage stageThis = (Stage) backButton.getScene().getWindow();
            stageThis.close();
        } catch (IOException e) {
            Logger logger = Logger.getLogger(getClass().getName());
            logger.log(Level.SEVERE, "Failed to create new Window.", e);
        }
    }
}
