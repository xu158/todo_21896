package com.etc.service;

import com.etc.dao.UserMapper;
import com.etc.entity.User;
import com.etc.entity.UserExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 查询用户信息
     * @param username 用户名
     * @param password 用户密码
     * @return 用户信息
     */
    public List<User> login(String username, String password){
        UserExample userExample  = new UserExample();
        userExample.createCriteria().andUserNameEqualTo(username).andPasswordEqualTo(password);
        List<User> users = userMapper.selectByExample(userExample);
        return users;
    }

    /**
     * 根据userID获取该用户信息
     * @param request HttpServletRequest对象，用来获取用户的userId
     * @return 返回该用户信息
     */
    public User getUserByUserId(HttpServletRequest request){
        int id = ((User) request.getSession().getAttribute("user")).getUserId();
        User user = userMapper.selectByPrimaryKey(id);
        return user;
    }

    /**
     * 更新用户密码
     * @param user 用户信息（包含userID，newPassword）
     * @return 是否更新成功
     */
    public String updatePassword(User user){
        int row = userMapper.updateByPrimaryKeySelective(user);
        String message;
        if(row > 0){
            message="更新密码成功";
        }else{
            message="更新密码失败";
        }
        return message;
    }
    /**
     * 修改用户信息
     * @param user 修改后的用户信息
     * @return 是否修改成功
     */
    public String updateUserMessage(User user){
        user.setLastUpdateDate(new Date());
        int row = userMapper.updateByPrimaryKeySelective(user);
        String message;
        if(row > 0){
            message="修改成功";
        }else{
            message="修改失败";
        }
        return message;
    }

    /**
     * 添加一个用户信息
     * @param user 用户信息
     * @return 返回是否添加成功
     */
    public String addUser(User user){
        int row = userMapper.insertSelective(user);
        String message;
        if(row > 0){
            message="注册成功";
        }else{
            message="注册失败";
        }
        return message;
    }
}
