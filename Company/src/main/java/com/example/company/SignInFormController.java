package com.example.company;

import com.example.company.model.DataBaseHandler;
import javafx.event.ActionEvent;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SignInFormController {
    public TextField loginUser;
    public TextField passwordUser;
    public Button signInButton;
    public Button backButton;
    public Label labelError;

    public void onSignInClick() throws SQLException, ClassNotFoundException {
        String login = loginUser.getText().trim();
        String pass = passwordUser.getText().trim();

        if (!login.equals("") && !login.equals("Введите логин!!!") &&
                !pass.equals("") && !pass.equals("Введите пароль!!!")){
            DataBaseHandler dataBaseHandler = new DataBaseHandler();
            Connection connection = dataBaseHandler.getDbConnection(login, pass);
            if (connection == null)
                labelError.setText("Данные введены неверно");
            else {
                loginUser.setText("Yes");
                // переход на новую страницу
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
}
