package com.example.company;

import com.example.company.model.ClientModel;
import com.example.company.model.ContractModel;
import com.example.company.model.DataBaseHandler;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;
import java.security.cert.TrustAnchor;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class ClientListFormController implements Initializable {
    public Label nameClient;
    public Label phoneNumberClient;
    public Label emailClient;
    public Label addressClient;
    public Button deleteBtn;
    public Button editBtn;
    public TableView<ClientModel> listClients;
    public TextField searchTF;
    public Button searchBtn;
    public Button allClientsBtn;
    ObservableList<ClientModel> clients = FXCollections.observableArrayList();

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        try {
            clients.setAll(DataBaseHandler.selectAllClients());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        listClients.setItems(clients);

        TableColumn<ClientModel, Integer> idColumn = new TableColumn<>("ID");
        idColumn.setCellValueFactory(new PropertyValueFactory<ClientModel, Integer>("id"));
        listClients.getColumns().add(idColumn);

        TableColumn<ClientModel, String> nameColumn = new TableColumn<>("Имя");
        nameColumn.setCellValueFactory(new PropertyValueFactory<ClientModel, String>("name"));
        listClients.getColumns().add(nameColumn);

        showClientDetails(null);

        listClients.getSelectionModel().selectedItemProperty().addListener(
                (observable, oldValue, newValue) -> showClientDetails(newValue)
        );
    }

    private void showClientDetails(ClientModel client) {
        if (client != null){
            nameClient.setText(client.getName());
            phoneNumberClient.setText(client.getPhoneNumber());
            emailClient.setText(client.getEmail());
            addressClient.setText(client.getAddress());
        }
        else {
            nameClient.setText(null);
            phoneNumberClient.setText(null);
            emailClient.setText(null);
            addressClient.setText(null);
        }
    }

    public void deleteOnClick() throws SQLException {
        ClientModel selectedItem = listClients.getSelectionModel().getSelectedItem();
        if (selectedItem != null){
            listClients.getItems().remove(selectedItem);
            DataBaseHandler.deleteClient(selectedItem);
        }
    }

    public void editOnClick(){
        ClientModel selectedItem = listClients.getSelectionModel().getSelectedItem();
        if (selectedItem != null){
            FXMLLoader fxmlLoader = new FXMLLoader();
            fxmlLoader.setLocation(getClass().getResource("client_form.fxml"));
            Scene scene = null;
            try {
                scene = new Scene(fxmlLoader.load());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            Stage stage = new Stage();
            stage.setTitle("Client");
            stage.setScene(scene);
            ClientFormController clientFormController = fxmlLoader.getController();
            clientFormController.setClientModel(selectedItem);
            clientFormController.setClientInForm(selectedItem);
            stage.show();
        }
    }

    public void searchClients(){
        String query = searchTF.getText().toString().trim();
        clients.clear();
        try {
            clients.setAll(DataBaseHandler.selectSearchClients(query));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void allClients(){
        clients.clear();
        try {
            clients.setAll(DataBaseHandler.selectAllClients());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
