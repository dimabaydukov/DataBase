package com.example.company.model;

import java.sql.*;


public class DataBaseHandler extends Config {
    Connection connection = null;

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
}
