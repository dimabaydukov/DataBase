package com.example.company;

import com.example.company.model.DataBaseHandler;
import com.example.company.model.EmployeeModel;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.sql.SQLException;

public class UpdateEmployeeFormController {

    public TextField loginUser;
    public TextField nameUser;
    public ChoiceBox<String> choiceRole;
    public TextField phoneUser;
    public TextField emailUser;
    public Button updateButton;
    public Label labelError;
    private EmployeeModel model = null;

    public void setModel(EmployeeModel model) {
        this.model = model;
    }

    public void setEmployeeDetails(EmployeeModel employeeModel){
        loginUser.setEditable(false);
        loginUser.setText(employeeModel.getLogin());
        nameUser.setText(employeeModel.getName());
        phoneUser.setText(employeeModel.getPhone());
        emailUser.setText(employeeModel.getEmail());
        if (employeeModel.getTitle().equals("manager"))
            choiceRole.setValue("Менеджер");
        else if (employeeModel.getTitle().equals("doctor"))
            choiceRole.setValue("Доктор");
    }

    public void updateOnClick(){
        String name = nameUser.getText().trim();
        String phone = phoneUser.getText().trim();
        String email = emailUser.getText().trim();
        String title = null;
        if (choiceRole.getValue().equals("Менеджер"))
            title = "manager";
        else if (choiceRole.getValue().equals("Доктор"))
            title = "doctor";

        if (!name.isEmpty() && !title.isEmpty() && !phone.isEmpty() && !email.isEmpty()
            && name.length() <= 30 && phone.length() <= 11 && email.length() <= 30){
            model.setName(name);
            model.setPhone(phone);
            model.setTitle(title);
            model.setEmail(email);

            try {
                DataBaseHandler.updateEmployee(model);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            Stage stageThis = (Stage) labelError.getScene().getWindow();
            stageThis.close();
        }
        else
            labelError.setText("Введены некорретные данные");
    }
}
