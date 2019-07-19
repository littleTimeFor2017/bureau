package com.lixc.bureau.service;


import com.lixc.bureau.entity.User;

import java.util.List;

public interface IUserService {
    //TODO 需要给用户名增加一个唯一约束
    User getUserByName(User user);

    int getUserById(int user_id);

    List<User> getAllUsers(User user);

    int addUsers(User user);
}
