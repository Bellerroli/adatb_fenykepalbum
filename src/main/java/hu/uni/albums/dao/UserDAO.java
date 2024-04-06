package hu.uni.albums.dao;

import hu.uni.albums.config.JDBCConnection;
import hu.uni.albums.model.UserModel;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO{
    private JDBCConnection jdbcConnection;

    public UserDAO() {
        jdbcConnection = new JDBCConnection();
    }

    public UserModel getFirstUser(){
        ResultSet rs = null;
        try{
            rs = jdbcConnection.getStatement().executeQuery("SELECT * FROM FELHASZNALOK");
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return mapResultToUserModel(rs).get(1);
    }

    public List<UserModel> getUsers(){
        ResultSet rs = null;
        try{
            rs = jdbcConnection.getStatement().executeQuery("SELECT * FROM FELHASZNALOK");
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return mapResultToUserModel(rs);
    }

    private List<UserModel> mapResultToUserModel(ResultSet resultSet) {
        List<UserModel> returnList = new ArrayList<>();
        try{
            while(resultSet.next()){
                returnList.add(new UserModel(resultSet.getString(1), resultSet.getString(3), resultSet.getString(4),
                        resultSet.getString(2), resultSet.getInt(5)));
            }
        }catch(Exception ex){
            System.err.println(ex.getMessage());
        }
        return returnList;
    }
}
