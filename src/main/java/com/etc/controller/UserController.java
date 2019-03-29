package com.etc.controller;

import com.etc.entity.User;
import com.etc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/login")
    public String login(String username,String password,HttpServletRequest request){
        List<User> users = userService.login(username,password);
        if(users.size() != 1) {
            request.setAttribute("msg", "用户名或者密码错误！！！");
            return "../../login";
        }else {
            request.getSession().setAttribute("user", users.get(0));
            return "redirect:selectalltodoitem.html";
        }
    }
    @RequestMapping("/getuserinfo")
    public String login(HttpServletRequest request,Model  model){
        User user = userService.getUserByUserId(request);
        String message=(String) request.getSession().getAttribute("msg");
        if(message != null){
            model.addAttribute("msg",message);
            request.getSession().removeAttribute("msg");
        }
        model.addAttribute("user", user);
        return "userinfo";

    }
    @RequestMapping("/updateusermessage")
    public String updateUserMessage(User user,HttpServletRequest request){
        String message = userService.updateUserMessage(user);
        request.getSession().setAttribute("msg",message);
        return "redirect:getuserinfo.html";

    }

    @RequestMapping("/updatepassword")
    public String updatePassword(User user, HttpServletRequest request){
        String message = userService.updatePassword(user);
        request.getSession().setAttribute("msg",message);
        return "redirect:getuserinfo.html";

    }
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.setAttribute("msg", "您已安全退出系统");
        request.getSession().invalidate(); //清除session
        return "../../login";
    }
    @RequestMapping("/adduser")
    public String addUser(User user, Model model) {
        String message = userService.updateUserMessage(user);
        model.addAttribute("msg", message);
        return "../../login";
    }

}
