package com.lixc.bureau.service.impl;

import com.lixc.bureau.dao.IUserDao;
import com.lixc.bureau.entity.User;
import com.lixc.bureau.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private IUserDao userDao;

    @Override
    public User getUserByName(User user) {
        return userDao.getUserByName(user);
    }

    @Override
    public int getUserById(int user_id) {
        return userDao.getUserById(user_id);
    }

    @Override
    public List<User> getAllUsers(User user) {
        return userDao.getAllUsers(user);
    }

    @Override
    public int addUsers(User user) {
        return userDao.addUsers(user);
    }
}
