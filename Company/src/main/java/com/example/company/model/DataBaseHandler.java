package com.example.company.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class DataBaseHandler extends Config {
    public static Connection connection = null;

    private void getDbConnection() throws ClassNotFoundException, SQLException{
        String connectStr = "jdbc:postgresql://localhost:5432/Company";
        Class.forName("org.postgresql.Driver");
        connection = DriverManager.getConnection(connectStr, dbUser, dbPassword);
    }

    public Connection getDbConnection(String login, String password) throws ClassNotFoundException {
        String connectStr = "jdbc:postgresql://localhost:5432/Company";
        Class.forName("org.postgresql.Driver");
        try {
            connection = DriverManager.getConnection(connectStr, login, password);
        } catch (SQLException e) {
            return null;
        }
        return connection;
    }

    public boolean registering(String login, String password, String role,
                               String phone, String email) throws SQLException, ClassNotFoundException {
        getDbConnection();

        Statement statement = null;
        statement = connection.createStatement();


        String queryUser = "CREATE ROLE " + login + " WITH\n" +
                "LOGIN\n" +
                "NOSUPERUSER\n" +
                "INHERIT\n" +
                "NOCREATEDB\n" +
                "NOCREATEROLE\n" +
                "NOREPLICATION\n" +
                "PASSWORD \'" + password + "\';\n" +
                "GRANT " + role + " TO " + login;

        String queryEmployee = "INSERT INTO public.\"Employee\" (name_employee, phone_number_employee, email_employee, title) " +
                "VALUES (?, ?, ?, ?)";
        PreparedStatement preparedStatement = connection.prepareStatement(queryEmployee);
        preparedStatement.setString(1, login);
        preparedStatement.setString(2, phone);
        preparedStatement.setString(3, email);
        preparedStatement.setString(4, role);

        try {
            statement.executeUpdate(queryUser);
            //проверить успешно ли выполнился запрос
            preparedStatement.executeUpdate();
            statement.close();
            preparedStatement.close();
            connection.close();
            return true;
        } catch (SQLException e) {

            return false;
        }
    }

    public String checkRole(String login) throws SQLException {
        String query = "SELECT title FROM public.\"Employee\" WHERE name_employee = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, login);
        ResultSet resultSet = preparedStatement.executeQuery();
        while(resultSet.next()){
            String role = resultSet.getString("title");
            preparedStatement.close();
            return role;
        }
        preparedStatement.close();
        return null;
    }

    public void addDetail(String name, String serialNumber) throws SQLException {
        String queryAddDetail = "INSERT INTO public.\"Detail\" (name_detail, serial_number) " +
                "VALUES (?, ?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(queryAddDetail);
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, serialNumber);
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public void addClient(String name, String phoneNumber, String email, String addressCl, String type) throws SQLException {
        String queryAddClient = "INSERT INTO public.\"Client\" (name_client, phone_number_client, email_client, " +
                "address, client_type) " +
                "VALUES (?, ?, ?, ?, ?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(queryAddClient);
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, phoneNumber);
        preparedStatement.setString(3, email);
        preparedStatement.setString(4, addressCl);
        preparedStatement.setString(5, type);
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static List<Integer> selectClients() throws SQLException {
        String query = "SELECT id_client FROM public.\"Client\"";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<Integer> listIdClients = new ArrayList<>();
        while(resultSet.next()){
            int id = resultSet.getInt("id_client");
            listIdClients.add(id);
        }
        statement.close();
        return listIdClients;
    }

    public void addContract(String description, Date date, int idClient) throws SQLException {
        String queryAddContract = "INSERT INTO public.\"Contract\" (description_conract, date_conract, id_client) " +
                "VALUES (?, ?, ?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(queryAddContract);
        preparedStatement.setString(1, description);
        preparedStatement.setDate(2, date);
        preparedStatement.setInt(3, idClient);
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }
}
