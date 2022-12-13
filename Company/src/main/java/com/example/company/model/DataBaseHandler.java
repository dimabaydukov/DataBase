package com.example.company.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class DataBaseHandler extends Config {
    public static Connection connection = null;

    private void getDbConnection() throws ClassNotFoundException, SQLException{
        String connectStr = "jdbc:postgresql://localhost:5432/VetClinic";
        Class.forName("org.postgresql.Driver");
        connection = DriverManager.getConnection(connectStr, dbUser, dbPassword);
    }

    public Connection getDbConnection(String login, String password) throws ClassNotFoundException {
        String connectStr = "jdbc:postgresql://localhost:5432/VetClinic";
        Class.forName("org.postgresql.Driver");
        try {
            connection = DriverManager.getConnection(connectStr, login, password);
        } catch (SQLException e) {
            return null;
        }
        return connection;
    }

    public boolean registering(String name, String password, String role,
                               String phone, String email, String login) throws SQLException, ClassNotFoundException {
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

        String queryEmployee = "INSERT INTO public.\"Employee\" (name_employee, phone_number_employee, email_employee, " +
                "title, login_employee) " +
                "VALUES (?, ?, ?, ?, ?)";
        PreparedStatement preparedStatement = connection.prepareStatement(queryEmployee);
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, phone);
        preparedStatement.setString(3, email);
        preparedStatement.setString(4, role);
        preparedStatement.setString(5, login);

        try {
            statement.executeUpdate(queryUser);
            preparedStatement.executeUpdate();
            statement.close();
            preparedStatement.close();
            connection.close();
            return true;
        } catch (SQLException e) {
            return false;
        }
    }

    public static String checkRole(String login) throws SQLException {
        String query = "SELECT check_role(?)";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, login);
        ResultSet resultSet = preparedStatement.executeQuery();
        while(resultSet.next()){
            String role = resultSet.getString("check_role");
            preparedStatement.close();
            return role;
        }
        preparedStatement.close();
        return null;
    }

    public static void addEquipment(String name, int vendorCode, String type) throws SQLException {
        String queryAddDetail = "CALL insert_equipment (?, ?, ?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(queryAddDetail);
        preparedStatement.setString(1, name);
        preparedStatement.setInt(2, vendorCode);
        preparedStatement.setString(3, type);
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void updateEquipment(EquipmentModel equipmentModel) throws SQLException {
        String queryAddContract = "CALL update_equipment (?, ?, ?, ?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(queryAddContract);
        preparedStatement.setString(1, equipmentModel.getName());
        preparedStatement.setInt(2, equipmentModel.getVendorCode());
        preparedStatement.setString(3, equipmentModel.getType());
        preparedStatement.setInt(4, equipmentModel.getId());
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void addClient(String name, String phoneNumber, String email, String addressCl) throws SQLException {
        String queryAddClient = "CALL insert_client(?, ?, ?, ?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(queryAddClient);
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, phoneNumber);
        preparedStatement.setString(3, email);
        preparedStatement.setString(4, addressCl);
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void updateClient(ClientModel clientModel) throws SQLException {
        String queryAddContract = "CALL update_client (?, ?, ?, ?, ?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(queryAddContract);
        preparedStatement.setString(1, clientModel.getName());
        preparedStatement.setString(2, clientModel.getPhoneNumber());
        preparedStatement.setString(3, clientModel.getEmail());
        preparedStatement.setString(4, clientModel.getAddress());
        preparedStatement.setInt(5, clientModel.getId());
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void addPet(String name, String kind, String age, char sex) throws SQLException {
        String queryAddPet = "CALL insert_pet (?, ?, ?, ?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(queryAddPet);
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, kind);
        preparedStatement.setString(3, age);
        preparedStatement.setString(4, String.valueOf(sex));
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void updatePet(PetModel petModel) throws SQLException {
        String queryAddContract = "CALL update_pet (?, ?, ?, ?, ?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(queryAddContract);
        preparedStatement.setString(1, petModel.getName());
        preparedStatement.setString(2, petModel.getKind());
        preparedStatement.setString(3, petModel.getAge());
        preparedStatement.setString(4, String.valueOf(petModel.getSex()));
        preparedStatement.setInt(5, petModel.getId());
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static List<Integer> selectIdClients() throws SQLException {
        String query = "SELECT select_id_clients()";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<Integer> listIdClients = new ArrayList<>();
        while(resultSet.next()){
            int id = resultSet.getInt("select_id_clients");
            listIdClients.add(id);
        }
        statement.close();
        return listIdClients;
    }

    public static List<Integer> selectIdPets() throws SQLException {
        String query = "SELECT select_id_pets()";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<Integer> listIdPets = new ArrayList<>();
        while(resultSet.next()){
            int id = resultSet.getInt("select_id_pets");
            listIdPets.add(id);
        }
        statement.close();
        return listIdPets;
    }

    public static List<Integer> selectIdContracts() throws SQLException {
        String query = "SELECT select_id_contracts()";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<Integer> listIdContracts = new ArrayList<>();
        while(resultSet.next()){
            int id = resultSet.getInt("select_id_contracts");
            listIdContracts.add(id);
        }
        statement.close();
        return listIdContracts;
    }

    public static List<String> selectEmployeeLogins() throws SQLException {
        String query = "SELECT select_emp_logins()";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<String> listEmployeeNames = new ArrayList<>();
        while(resultSet.next()){
            String name = resultSet.getString("select_emp_logins");
            listEmployeeNames.add(name);
        }
        statement.close();
        return listEmployeeNames;
    }

    public static List<TaskModel> selectAllTasks() throws SQLException {
        String query = "SELECT * FROM select_all_tasks()";
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
            task.setManager(resultSet.getString("manager_name"));
            list.add(task);
        }
        statement.close();
        return list;
    }

    public static List<ContractModel> selectAllContracts() throws SQLException {
        String query = "SELECT * FROM select_all_contracts()";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<ContractModel> list = new ArrayList<>();
        while(resultSet.next()){
            ContractModel contract = new ContractModel();
            contract.setId(resultSet.getInt("id_contract"));
            contract.setDescription(resultSet.getString("description_contract"));
            contract.setDateCreate(resultSet.getDate("date_contract"));
            contract.setClientId(resultSet.getInt("id_client"));
            contract.setPetId(resultSet.getInt("id_pet"));
            list.add(contract);
        }
        statement.close();
        return list;
    }

    public static List<PetModel> selectAllPets() throws SQLException {
        String query = "SELECT * FROM select_all_pets()";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<PetModel> list = new ArrayList<>();
        while(resultSet.next()){
            PetModel pet = new PetModel();
            pet.setId(resultSet.getInt("id_pet"));
            pet.setKind(resultSet.getString("kind_of_animal"));
            pet.setSex(resultSet.getString("sex").charAt(0));
            pet.setAge(resultSet.getString("age"));
            pet.setName(resultSet.getString("animal_name"));
            list.add(pet);
        }
        statement.close();
        return list;
    }

    public static String selectClientsNameFromContract(int id) throws SQLException {
        String query = "SELECT * FROM select_clients_name_from_contract(?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        String name = null;
        while(resultSet.next()){
            name = resultSet.getString("name_client");
        }
        preparedStatement.close();
        return name;
    }

    public static String selectPetsNameFromContract(int id) throws SQLException {
        String query = "SELECT * FROM select_pets_name_from_contract(?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        String name = null;
        while(resultSet.next()){
            name = resultSet.getString("animal_name");
        }
        preparedStatement.close();
        return name;
    }

    public static String selectKindOfAnimalFromContract(int id) throws SQLException {
        String query = "SELECT select_kind_of_animal_from_contract(?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        String kind = null;
        while(resultSet.next()){
            kind = resultSet.getString("select_kind_of_animal_from_contract");
        }
        preparedStatement.close();
        return kind;
    }

    public static List<ClientModel> selectAllClients() throws SQLException {
        String query = "SELECT * FROM select_all_clients()";
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
            list.add(client);
        }
        statement.close();
        return list;
    }

    //TODO: search
    public static List<ClientModel> selectSearchClients(String search) throws SQLException {
        String query = "SELECT * FROM \"Client\" WHERE name_client LIKE \'%"+ search +"%\' " +
                "OR address LIKE \'%"+ search +"%\'\n" +
                "OR email_client LIKE \'%"+ search +"%\' " +
                "OR phone_number_client LIKE \'%"+ search +"%\'";
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
            list.add(client);
        }
        statement.close();
        return list;
    }

    public static List<EquipmentModel> selectAllEquipments() throws SQLException {
        String query = "SELECT * FROM select_all_equipments()";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<EquipmentModel> list = new ArrayList<>();
        while(resultSet.next()){
            EquipmentModel equipmentModel = new EquipmentModel();
            equipmentModel.setId(resultSet.getInt("id_equipment"));
            equipmentModel.setName(resultSet.getString("name_equipment"));
            equipmentModel.setVendorCode(resultSet.getInt("vendor_code"));
            equipmentModel.setType(resultSet.getString("type_equipment"));
            list.add(equipmentModel);
        }
        statement.close();
        return list;
    }

    public static List<Integer> selectAllEquipmentsId() throws SQLException {
        String query = "SELECT select_all_equipments_id()";
        Statement statement = DataBaseHandler.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        List<Integer> list = new ArrayList<>();
        while(resultSet.next()){
            list.add(resultSet.getInt("select_all_equipments_id"));
        }
        statement.close();
        return list;
    }

    public static EquipmentModel selectEquipment(int id) throws SQLException {
        String query = "SELECT * FROM select_equipment(?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        while(resultSet.next()){
            EquipmentModel equipmentModel = new EquipmentModel();
            equipmentModel.setId(resultSet.getInt("id_equipment"));
            equipmentModel.setName(resultSet.getString("name_equipment"));
            equipmentModel.setVendorCode(resultSet.getInt("vendor_code"));
            equipmentModel.setType(resultSet.getString("type_equipment"));
            preparedStatement.close();
            return equipmentModel;
        }
        return null;
    }

    public static void addTaskEquipment(int idTask, int idEquipment) throws SQLException {
        String query = "CALL insert_TaskEquipment (?, ?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, idTask);
        preparedStatement.setInt(2, idEquipment);
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static List<EquipmentModel> selectAllEquipmentsFromTask(int idTask) throws SQLException {
        String query = "SELECT * FROM select_all_equipments_from_task(?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, idTask);
        ResultSet resultSet = preparedStatement.executeQuery();
        List<Integer> listIdEquipment = new ArrayList<>();
        List<EquipmentModel> listEquipments = new ArrayList<>();
        while(resultSet.next()){
            listIdEquipment.add(resultSet.getInt("Equipment_id_equipment"));
        }
        preparedStatement.close();

        for (int id: listIdEquipment) {
            listEquipments.add(selectEquipment(id));
        }

        return listEquipments;
    }

    public static void addContract(String description, Date date, int idClient, int idPet) throws SQLException {
        String queryAddContract = "CALL insert_contract (?, ?, ?, ?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(queryAddContract);
        preparedStatement.setString(1, description);
        preparedStatement.setDate(2, date);
        preparedStatement.setInt(3, idClient);
        preparedStatement.setInt(4, idPet);
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void updateContract(ContractModel contractModel) throws SQLException {
        String queryAddContract = "CALL update_contract (?, ?, ?, ?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(queryAddContract);
        preparedStatement.setString(1, contractModel.getDescription());
        preparedStatement.setInt(2, contractModel.getClientId());
        preparedStatement.setInt(3, contractModel.getPetId());
        preparedStatement.setInt(4, contractModel.getId());
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void addTask(String name, String description, Date dateCreate, Date deadline, String priority,
                               boolean status, int idContract, String employeeName, String managerName, Date dateEnd)
            throws SQLException {
        String queryAddTask = "CALL insert_task (?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(queryAddTask);
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, description);
        preparedStatement.setDate(3, dateCreate);
        preparedStatement.setDate(4, deadline);
        preparedStatement.setString(5, priority);
        preparedStatement.setBoolean(6, status);
        preparedStatement.setInt(7, idContract);
        preparedStatement.setString(8, employeeName);
        preparedStatement.setString(9, managerName);
        preparedStatement.setDate(10, dateEnd);
        preparedStatement.executeUpdate();
        preparedStatement.close();

        int idTask = selectCurrentTaskId(name, description, dateCreate, deadline, priority,
                status, idContract, employeeName, managerName);
        int idEmp = selectCurrentEmployeeId(employeeName);
        int idManager = DataBaseHandler.selectCurrentEmployeeId(managerName);
        addEmployeeTask(idEmp, idTask, "И");
        addEmployeeTask(idManager, idTask, "A");
    }

    public static void updateTask(TaskModel task) throws SQLException {
        String query = "CALL update_task (?,?,?,?,?,?,?,?,?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setString(1, task.getName());
        preparedStatement.setString(2, task.getDescription());
        preparedStatement.setDate(3, task.getDeadline());
        preparedStatement.setString(4, task.getPriority());
        preparedStatement.setBoolean(5, task.isStatus());
        preparedStatement.setInt(6, task.getContractId());
        preparedStatement.setString(7, task.getEmpName());
        preparedStatement.setDate(8, task.getDateEnd());
        preparedStatement.setInt(9, task.getId());
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void deleteTask(TaskModel task) throws SQLException {
        String query = "CALL delete_task (?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, task.getId());
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void deleteContract(ContractModel contract) throws SQLException {
        String query = "CALL delete_contract (?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, contract.getId());
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void deleteClient(ClientModel client) throws SQLException {
        String query = "CALL delete_client(?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, client.getId());
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void deletePet(PetModel pet) throws SQLException {
        String query = "CALL delete_pet(?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, pet.getId());
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void deleteEquipment(EquipmentModel equipmentModel) throws SQLException {
        String query = "CALL delete_equipment(?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, equipmentModel.getId());
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void deleteEquipmentFromTask(int idTask, int idEquipment) throws SQLException {
        String query = "CALL delete_EquipmentFromTask (?, ?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, idTask);
        preparedStatement.setInt(2, idEquipment);
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static int selectCurrentEmployeeId(String login) throws SQLException {
        String query = "SELECT select_current_employee_id(?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setString(1, login);
        ResultSet resultSet = preparedStatement.executeQuery();
        int id = -1;
        while(resultSet.next()){
            id = resultSet.getInt("select_current_employee_id");
        }
        preparedStatement.close();
        return id;
    }

    public static int selectCurrentTaskId(String name, String description, Date dateCreate, Date deadline, String priority,
                               boolean status, int idContract, String employeeName, String managerName)
            throws SQLException {
        String queryAddTask = "SELECT select_current_task_id(?,?,?,?,?,?,?,?,?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(queryAddTask);
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, description);
        preparedStatement.setDate(3, dateCreate);
        preparedStatement.setDate(4, deadline);
        preparedStatement.setString(5, priority);
        preparedStatement.setBoolean(6, status);
        preparedStatement.setInt(7, idContract);
        preparedStatement.setString(8, employeeName);
        preparedStatement.setString(9, managerName);
        ResultSet resultSet = preparedStatement.executeQuery();
        int id = -1;
        while(resultSet.next()){
            id = resultSet.getInt("select_current_task_id");
        }
        preparedStatement.close();
        return id;
    }

    public static void addEmployeeTask(int idEmp, int idTask, String pos) throws SQLException {
        String query = "CALL insert_employeetask(?, ?, ?)";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, idEmp);
        preparedStatement.setInt(2, idTask);
        preparedStatement.setString(3, pos);
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void updateEmployeeTask(int idEmp, int idTask, int newIdEmp) throws SQLException {
        String query = "UPDATE public.\"Employee_Task\" SET \"Employee_id_employee\" = ?" +
                "WHERE \"Employee_id_employee\" = ? AND \"Task_id_task\" = ? AND position = \'И\'";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, newIdEmp);
        preparedStatement.setInt(2, idEmp);
        preparedStatement.setInt(3, idTask);
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static void deleteEmployeeTask(int idEmp, int idTask) throws SQLException {
        String query = "DELETE FROM public.\"Employee_Task\" WHERE \"Employee_id_employee\" = ?" +
                "AND \"Task_id_task\" = ?";
        PreparedStatement preparedStatement = DataBaseHandler.connection.prepareStatement(query);
        preparedStatement.setInt(1, idEmp);
        preparedStatement.setInt(2, idTask);
        preparedStatement.executeUpdate();
        preparedStatement.close();
    }

    public static boolean createReportTask() throws SQLException {
        String query = "CALL create_report_task()";
        Statement statement = DataBaseHandler.connection.createStatement();
        if (statement.execute(query)){
            statement.close();
            return true;
        }
        statement.close();
        return false;
    }

    public static boolean createReportEmployee() throws SQLException {
        String query = "CALL create_report_employee()";
        Statement statement = DataBaseHandler.connection.createStatement();
        if (statement.execute(query)){
            statement.close();
            return true;
        }
        statement.close();
        return false;
    }
}
