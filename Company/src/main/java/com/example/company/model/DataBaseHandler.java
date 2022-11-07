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

    public static List<Integer> selectIdClients() throws SQLException {
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

    public static List<Integer> selectIdContracts() throws SQLException {
        String query = "SELECT id_contract FROM public.\"Contract\"";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<Integer> listIdContracts = new ArrayList<>();
        while(resultSet.next()){
            int id = resultSet.getInt("id_contract");
            listIdContracts.add(id);
        }
        statement.close();
        return listIdContracts;
    }

    public static List<String> selectEmployeeNames() throws SQLException {
        String query = "SELECT name_employee FROM public.\"Employee\"";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<String> listEmployeeNames = new ArrayList<>();
        while(resultSet.next()){
            String name = resultSet.getString("name_employee");
            listEmployeeNames.add(name);
        }
        statement.close();
        return listEmployeeNames;
    }

    public static List<TaskModel> selectAllTasks() throws SQLException {
        String query = "SELECT * FROM public.\"Task\"";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<TaskModel> list = new ArrayList<>();
        while(resultSet.next()){
            TaskModel task = new TaskModel();
            task.setId(resultSet.getInt("id_task"));
            task.setName(resultSet.getString("name_task"));
            task.setDescription(resultSet.getString("description_task"));
            task.setDateCreate(resultSet.getDate("date_create"));
            task.setDeadline(resultSet.getDate("date_deadline"));
            task.setPriority(resultSet.getString("priority"));
            task.setStatus(resultSet.getBoolean("status"));
            task.setDateEnd(resultSet.getDate("date_end"));
            task.setContractId(resultSet.getInt("contract_id"));
            task.setEmpName(resultSet.getString("emp_name"));
            list.add(task);
        }
        statement.close();
        return list;
    }

    public static List<ContractModel> selectAllContracts() throws SQLException {
        String query = "SELECT * FROM public.\"Contract\"";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<ContractModel> list = new ArrayList<>();
        while(resultSet.next()){
            ContractModel contract = new ContractModel();
            contract.setId(resultSet.getInt("id_contract"));
            contract.setDescription(resultSet.getString("description_contract"));
            contract.setDateCreate(resultSet.getDate("date_contract"));
            contract.setClientId(resultSet.getInt("id_client"));
            list.add(contract);
        }
        statement.close();
        return list;
    }

    public static List<ClientModel> selectAllClients() throws SQLException {
        String query = "SELECT * FROM public.\"Client\"";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<ClientModel> list = new ArrayList<>();
        while(resultSet.next()){
            ClientModel client = new ClientModel();
            client.setId(resultSet.getInt("id_client"));
            client.setName(resultSet.getString("name_client"));
            client.setPhoneNumber(resultSet.getString("phone_number_client"));
            client.setEmail(resultSet.getString("email_client"));
            client.setAddress(resultSet.getString("address"));
            client.setType(resultSet.getString("client_type"));
            list.add(client);
        }
        statement.close();
        return list;
    }

    public static List<DetailModel> selectAllDetails() throws SQLException {
        String query = "SELECT * FROM public.\"Client\"";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<DetailModel> list = new ArrayList<>();
        while(resultSet.next()){
            DetailModel detail = new DetailModel();
            detail.setId(resultSet.getInt("id_detail"));
            detail.setName(resultSet.getString("name_detail"));
            detail.setSerialNumber(resultSet.getString("serial_number"));
            list.add(detail);
        }
        statement.close();
        return list;
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

        changeTypeClient(idClient);
    }

    private void changeTypeClient(int id) throws SQLException {
        String query = "UPDATE public.\"Client\" SET client_type = \'Текущий\' WHERE id_client = ?";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, id);
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public void addTask(String name, String description, Date dateCreate, Date deadline, String priority, boolean status,
                        int idContract, String employeeName) throws SQLException {
        String queryAddTask = "INSERT INTO public.\"Task\" (name_task, description_task, date_create, date_deadline, " +
                "priority, status, contract_id, emp_name) " +
                "VALUES (?,?,?,?,?,?,?,?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(queryAddTask);
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, description);
        preparedStatement.setDate(3, dateCreate);
        preparedStatement.setDate(4, deadline);
        preparedStatement.setString(5, priority);
        preparedStatement.setBoolean(6, status);
        preparedStatement.setInt(7, idContract);
        preparedStatement.setString(8, employeeName);
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }
}
