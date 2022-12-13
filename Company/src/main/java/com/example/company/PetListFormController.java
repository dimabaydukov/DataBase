package com.example.company;

import com.example.company.model.DataBaseHandler;
import com.example.company.model.PetModel;
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

public class PetListFormController implements Initializable {
    public TableView<PetModel> listPets;
    public Button editBtn;
    public Button deleteBtn;
    public Label kindLabel;
    public Label sexLabel;
    public Label ageLabel;
    public Label nameLabel;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        ObservableList<PetModel> pets = FXCollections.observableArrayList();
        try {
            pets.setAll(DataBaseHandler.selectAllPets());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        listPets.setItems(pets);

        TableColumn<PetModel, Integer> idColumn = new TableColumn<>("ID");
        idColumn.setCellValueFactory(new PropertyValueFactory<PetModel, Integer>("id"));
        listPets.getColumns().add(idColumn);

        showPetDetails(null);

        listPets.getSelectionModel().selectedItemProperty().addListener(
                (observable, oldValue, newValue) -> showPetDetails(newValue)
        );
    }

    private void showPetDetails(PetModel pet) {
        if (pet != null){
            nameLabel.setText(pet.getName());
            kindLabel.setText(pet.getKind());
            sexLabel.setText(String.valueOf(pet.getSex()));
            ageLabel.setText(String.valueOf(pet.getAge()));
        }
        else {
            nameLabel.setText(null);
            kindLabel.setText(null);
            sexLabel.setText(null);
            ageLabel.setText(null);
        }
    }

    public void deleteOnClick() throws SQLException {
        PetModel selectedItem = listPets.getSelectionModel().getSelectedItem();
        if (selectedItem != null){
            listPets.getItems().remove(selectedItem);
            DataBaseHandler.deletePet(selectedItem);
        }
    }

    public void editOnClick(){
        PetModel selectedItem = listPets.getSelectionModel().getSelectedItem();
        if (selectedItem != null){
            FXMLLoader fxmlLoader = new FXMLLoader();
            fxmlLoader.setLocation(getClass().getResource("pet_form.fxml"));
            Scene scene = null;
            try {
                scene = new Scene(fxmlLoader.load());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            Stage stage = new Stage();
            stage.setTitle("Pet");
            stage.setScene(scene);
            PetFormController petFormController = fxmlLoader.getController();
            petFormController.setPetModel(selectedItem);
            petFormController.setPetInForm(selectedItem);
            stage.show();
        }
    }
}
