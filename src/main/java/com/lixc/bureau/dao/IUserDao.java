package com.lixc.bureau.dao;

import com.lixc.bureau.entity.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IUserDao {
    User getUserByName(User user);

    int getUserById(int user_id);

    User getUser(int user_id);

    List<User> getAllUsers(User user);

    int addUsers(User user);
}
