package com.example.company;

import com.example.company.model.DataBaseHandler;
import com.example.company.model.PetModel;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.net.URL;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.ResourceBundle;

public class PetFormController implements Initializable {
    public Button saveButtonPet;
    public Button backButton;
    public Label labelError;
    public TextField namePet;
    public TextField kindOfAnimal;
    public TextField agePet;
    public ComboBox<Character> sexPet;
    private PetModel petModel = null;

    public void setPetModel(PetModel petModel) {
        this.petModel = petModel;
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        ObservableList<Character> items = FXCollections.observableArrayList();
        items.setAll(Arrays.asList('Д','М'));
        sexPet.getItems().setAll(items);
        sexPet.setItems(items);
    }

    public void onClickSaveBtn() throws SQLException {
        String name = namePet.getText().trim();
        String kind = kindOfAnimal.getText().trim();
        String age = agePet.getText().trim();
        char sex = sexPet.getValue();

        for (int i = 0; i < age.length(); i++) {
            if (Character.isLetter(age.charAt(i))){
                labelError.setText("Данные введены некорректно!");
                break;
            }
        }

        if (name.equals("") || kind.equals("") || Integer.parseInt(age) < 0 || Integer.parseInt(age) > 99
                || age.equals("") || sexPet.getValue()==null){
            labelError.setText("Данные введены некорректно!");
        }
        else if (kind.length() > 20 || name.length() > 20){
            labelError.setText("Данные введены некорректно!");
        }
        else {
            if (petModel == null)
                DataBaseHandler.addPet(name, kind, age, sex);
            else{
                petModel.setName(name);
                petModel.setKind(kind);
                petModel.setAge(age);
                petModel.setSex(sex);
                DataBaseHandler.updatePet(petModel);
                onBackClick();
            }
        }
    }

    public void setPetInForm(PetModel pet){
        namePet.setText(pet.getName());
        kindOfAnimal.setText(pet.getKind());
        agePet.setText(String.valueOf(pet.getAge()));
        sexPet.setValue(pet.getSex());
    }

    public void onBackClick(){
        Stage stageThis = (Stage) backButton.getScene().getWindow();
        stageThis.close();
    }
}
