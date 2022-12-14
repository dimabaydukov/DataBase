package com.example.company;

import com.example.company.model.DataBaseHandler;
import com.example.company.model.EmployeeModel;
import com.example.company.model.TaskModel;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class EmployeeListFormController implements Initializable {
    public TableView<EmployeeModel> employeeList;
    public Button deleteEmployee;
    public Button updateEmployee;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        ObservableList<EmployeeModel> employees = FXCollections.observableArrayList();
        try {
            employees.setAll(DataBaseHandler.selectAllEmployee());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        employeeList.setItems(employees);

        TableColumn<EmployeeModel, Integer> idColumn = new TableColumn<EmployeeModel, Integer>("ID");
        idColumn.setCellValueFactory(new PropertyValueFactory<EmployeeModel, Integer>("id"));
        employeeList.getColumns().add(idColumn);

        TableColumn<EmployeeModel, String> nameColumn = new TableColumn<EmployeeModel, String>("ФИО");
        nameColumn.setCellValueFactory(new PropertyValueFactory<EmployeeModel, String>("name"));
        employeeList.getColumns().add(nameColumn);

        TableColumn<EmployeeModel, String> phoneColumn = new TableColumn<EmployeeModel, String>("Номер телефона");
        phoneColumn.setCellValueFactory(new PropertyValueFactory<EmployeeModel, String>("phone"));
        employeeList.getColumns().add(phoneColumn);

        TableColumn<EmployeeModel, String> emailColumn = new TableColumn<EmployeeModel, String>("Эл. почта");
        emailColumn.setCellValueFactory(new PropertyValueFactory<EmployeeModel, String>("email"));
        employeeList.getColumns().add(emailColumn);

        TableColumn<EmployeeModel, String> titleColumn = new TableColumn<EmployeeModel, String>("Вакансия");
        titleColumn.setCellValueFactory(new PropertyValueFactory<EmployeeModel, String>("title"));
        employeeList.getColumns().add(titleColumn);

        TableColumn<EmployeeModel, String> loginColumn = new TableColumn<EmployeeModel, String>("Логин");
        loginColumn.setCellValueFactory(new PropertyValueFactory<EmployeeModel, String>("login"));
        employeeList.getColumns().add(loginColumn);
    }

    public void deleteOnClick(){
        EmployeeModel employee = employeeList.getSelectionModel().getSelectedItem();
        if (employee != null){
            try {
                DataBaseHandler.deleteEmployee(employee);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void updateOnClick(){
        EmployeeModel selectedItem = employeeList.getSelectionModel().getSelectedItem();
        if (selectedItem != null){
            FXMLLoader fxmlLoader = new FXMLLoader();
            fxmlLoader.setLocation(getClass().getResource("update_employee_form.fxml"));
            Scene scene = null;
            try {
                scene = new Scene(fxmlLoader.load());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            Stage stage = new Stage();
            stage.setTitle("Employee");
            stage.setScene(scene);
            UpdateEmployeeFormController updateEmployeeFormController = fxmlLoader.getController();
            updateEmployeeFormController.setModel(selectedItem);
            updateEmployeeFormController.setEmployeeDetails(selectedItem);
            stage.show();
        }
    }
}
