package com.example.company;

import com.example.company.model.DataBaseHandler;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SignInFormController {
    public TextField loginUser;
    public PasswordField passwordUser;
    public Button signInButton;
    public Button backButton;
    public Label labelError;
    public static String currentUser = null;

    public void onSignInClick() throws SQLException, ClassNotFoundException {
        String login = loginUser.getText().trim();
        String pass = passwordUser.getText().trim();

        labelError.setText("");

        if (!login.equals("") && !login.equals("Введите логин!!!") &&
                !pass.equals("") && !pass.equals("Введите пароль!!!")){
            DataBaseHandler dataBaseHandler = new DataBaseHandler();
            DataBaseHandler.connection = dataBaseHandler.getDbConnection(login, pass);
            if (DataBaseHandler.connection == null)
                labelError.setText("Данные введены неверно");
            else {
                String role = DataBaseHandler.checkRole(login);
                if (role != null){
                    if (role.equals("manager")) {
                        currentUser = login;
                        goToManagerStartForm();
                    }
                    if (role.equals("tech_spec")) {
                        currentUser = login;
                        goToTechSpecStartForm();
                    }
                }
            }
        }
        else if (login.equals(""))
            loginUser.setText("Введите логин!!!");
        else
            passwordUser.setText("Введите пароль!!!");
    }

    public void onBackClick() {
        try{
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

    private void goToManagerStartForm(){
        try{
            FXMLLoader fxmlLoader = new FXMLLoader();
            fxmlLoader.setLocation(getClass().getResource("manager_start_form.fxml"));
            Scene scene = new Scene(fxmlLoader.load());
            Stage stage = new Stage();
            stage.setTitle("Menu");
            stage.setScene(scene);
            stage.show();

            Stage stageThis = (Stage) backButton.getScene().getWindow();
            stageThis.close();
        } catch (IOException e) {
            Logger logger = Logger.getLogger(getClass().getName());
            logger.log(Level.SEVERE, "Failed to create new Window.", e);
        }
    }

    private void goToTechSpecStartForm(){
        try{
            FXMLLoader fxmlLoader = new FXMLLoader();
            fxmlLoader.setLocation(getClass().getResource("tech_spec_start_form.fxml"));
            Scene scene = new Scene(fxmlLoader.load());
            Stage stage = new Stage();
            stage.setTitle("Menu");
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
