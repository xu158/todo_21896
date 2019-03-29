package com.etc.controller;

import com.etc.entity.TodoItem;
import com.etc.service.ToDoItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class ToDoItemController {

    @Autowired
    private ToDoItemService toDoItemService;

    @RequestMapping("addtodoitem")
    public String addToDoItem(TodoItem todoItem, HttpServletRequest request){
        String message = toDoItemService.addToDoItem(todoItem,request);
        request.getSession().setAttribute("msg",message);
        return "redirect:selectalltodoitem.html";
    }

    @RequestMapping("/deletetodoitem")
    public String deleteToDoItem(int id,HttpServletRequest request){
        String message = toDoItemService.deleteToDoItem(id);
        request.getSession().setAttribute("msg",message);
        return "redirect:selectalltodoitem.html";
    }

    @RequestMapping("/modifyToDoItem")
    public String modifyToDoItem(TodoItem todoItem ,HttpServletRequest request){
        String message = toDoItemService.modifyDoItem(todoItem,request);
        request.getSession().setAttribute("msg",message);
        return "redirect:selectalltodoitem.html";
    }
    @RequestMapping("/selecttodoitembyid")
    public String selectToDoItemById(int id,Model model){
        TodoItem toDoItem = toDoItemService.selectToDoItemById(id);
        model.addAttribute("toDoItem",toDoItem);
        return "todoitem";
    }

    @RequestMapping("/selectalltodoitem")
    public String selectAllToDoItem(Model model,HttpServletRequest request){
        List<TodoItem> toDoItemList = toDoItemService.selectAllToDoItem(request);
        String message=(String) request.getSession().getAttribute("msg");
        if(message != null){
            model.addAttribute("msg",message);
            request.getSession().removeAttribute("msg");
        }
        model.addAttribute("toDoItemList",toDoItemList);
        return "todoitem";
    }
}
