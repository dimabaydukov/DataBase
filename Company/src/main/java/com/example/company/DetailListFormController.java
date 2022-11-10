package com.example.company;

import com.example.company.model.ClientModel;
import com.example.company.model.DataBaseHandler;
import com.example.company.model.DetailModel;
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
import java.sql.SQLException;
import java.util.ResourceBundle;

public class DetailListFormController implements Initializable {
    public TableView<DetailModel> listDetails;
    public Label nameLabel;
    public Label serialNumberLabel;
    public Button editBtn;
    public Button deleteBtn;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        ObservableList<DetailModel> details = FXCollections.observableArrayList();
        try {
            details.addAll(DataBaseHandler.selectAllDetails());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        listDetails.setItems(details);

        TableColumn<DetailModel, Integer> idColumn = new TableColumn<>("ID");
        idColumn.setCellValueFactory(new PropertyValueFactory<DetailModel, Integer>("id"));
        listDetails.getColumns().add(idColumn);

        TableColumn<DetailModel, String> nameColumn = new TableColumn<>("Имя");
        nameColumn.setCellValueFactory(new PropertyValueFactory<DetailModel, String>("name"));
        listDetails.getColumns().add(nameColumn);

        showDetailDetails(null);

        listDetails.getSelectionModel().selectedItemProperty().addListener(
                (observable, oldValue, newValue) -> showDetailDetails(newValue)
        );
    }

    private void showDetailDetails(DetailModel detail) {
        if (detail != null) {
            nameLabel.setText(detail.getName());
            serialNumberLabel.setText(detail.getSerialNumber());
        }
        else {
            nameLabel.setText(null);
            serialNumberLabel.setText(null);
        }
    }

    public void deleteOnClick() throws SQLException {
        DetailModel selectedItem = listDetails.getSelectionModel().getSelectedItem();
        if (selectedItem != null){
            listDetails.getItems().remove(selectedItem);
            DataBaseHandler.deleteDetail(selectedItem);
        }
    }

    public void editOnClick(){
        DetailModel selectedItem = listDetails.getSelectionModel().getSelectedItem();
        if (selectedItem != null){
            FXMLLoader fxmlLoader = new FXMLLoader();
            fxmlLoader.setLocation(getClass().getResource("detail_form.fxml"));
            Scene scene = null;
            try {
                scene = new Scene(fxmlLoader.load());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            Stage stage = new Stage();
            stage.setTitle("Detail");
            stage.setScene(scene);
            DetailFormController detailFormController = fxmlLoader.getController();
            detailFormController.setDetailModel(selectedItem);
            detailFormController.setDetailInForm(selectedItem);
            stage.show();
        }
    }

    public void setUnVisible(){
        deleteBtn.setVisible(false);
    }
}
