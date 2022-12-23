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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegistrationFormController {
    public TextField loginNewUser;
    public TextField passwordNewUser;
    @FXML
    public ChoiceBox<String> choiceRole;
    public Button registrationButton;
    public Button backButton;
    public Label labelError;
    public TextField nameNewUser;
    public TextField phoneNewUser;
    public TextField emailNewUser;

    public void onRegistrationClick() throws SQLException, ClassNotFoundException {
        String login = loginNewUser.getText().trim();
        String pass = passwordNewUser.getText().trim();
        String role = choiceRole.getSelectionModel().getSelectedItem();
        String phone = phoneNewUser.getText().trim();
        String email = emailNewUser.getText().trim();
        String name = nameNewUser.getText().trim();

        labelError.setText("");
        if (role != null && !role.equals("")) {
            if (choiceRole.getValue().equals("Доктор"))
                role = "doctor";
            else
                role = "manager";

            if (!login.equals("") && !pass.equals("")){
                if (phone.equals("") || email.equals("") || name.equals(""))
                    labelError.setText("Введены не все данные!");
                else {
                    if (name.length() <= 30 && phone.length() <= 11
                            && email.length() <= 30 && login.length() <= 10
                            && pass.length() >= 8 && validPass(pass)) {
                        DataBaseHandler dataBaseHandler = new DataBaseHandler();
                        boolean flag = dataBaseHandler.registering(name, pass, role, phone, email, login);
                        if (flag) {
                            goToSignInForm();
                        } else
                            labelError.setText("Такой логин уже существует!");
                    }
                    else if (nameNewUser.getText().length() > 30)
                        labelError.setText("ФИО должно быть меньше 30 символов!");
                    else if (phoneNewUser.getText().length() > 11)
                        labelError.setText("Номер телефона не должен превышать 11 символов!");
                    else if (emailNewUser.getText().length() > 30)
                        labelError.setText("Эл. почта должна быть меньше 30 символов!");
                    else if (loginNewUser.getText().length() > 10)
                        labelError.setText("Логин должен содержать до 10 символов!");
                    else
                        labelError.setText("Пароль должен быть >= 8 символов, содержать заглавные и строчные буквы латиницы и цифры");
                }
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

    private void goToSignInForm(){
        try {
            FXMLLoader fxmlLoader = new FXMLLoader();
            fxmlLoader.setLocation(getClass().getResource("sign_in_form.fxml"));
            Scene scene = new Scene(fxmlLoader.load());
            Stage stage = new Stage();
            stage.setTitle("Sign in");
            stage.setScene(scene);
            stage.show();

            Stage stageThis = (Stage) backButton.getScene().getWindow();
            stageThis.close();
        } catch (IOException e) {
            Logger logger = Logger.getLogger(getClass().getName());
            logger.log(Level.SEVERE, "Failed to create new Window.", e);
        }
    }

    private boolean validPass(String pass){
        String regex = "^(?=.*[0-9])"
                + "(?=.*[a-z])(?=.*[A-Z])"
                + "(?=\\S+$).{8,20}$";
        Pattern p = Pattern.compile(regex);
        Matcher m = p.matcher(pass);
        return m.matches();
    }
}
