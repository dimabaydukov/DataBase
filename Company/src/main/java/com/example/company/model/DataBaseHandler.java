package com.example.company.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

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

    public boolean registering(String login, String password, String role) throws SQLException, ClassNotFoundException {
        getDbConnection();

        Statement statement = null;
        statement = connection.createStatement();


        String query = "CREATE ROLE " + login + " WITH\n" +
                "LOGIN\n" +
                "NOSUPERUSER\n" +
                "INHERIT\n" +
                "NOCREATEDB\n" +
                "NOCREATEROLE\n" +
                "NOREPLICATION\n" +
                "PASSWORD \'" + password + "\';\n" +
                "GRANT " + role + " TO " + login;
        try {
            statement.executeUpdate(query);
            //проверить успешно ли выполнился запрос
            statement.close();
            connection.close();
            return true;
        } catch (SQLException e) {
            return false;
        }
    }
}
