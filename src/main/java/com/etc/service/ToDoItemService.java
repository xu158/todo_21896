package com.etc.service;

import com.etc.dao.TodoItemMapper;
import com.etc.entity.TodoItem;
import com.etc.entity.TodoItemExample;
import com.etc.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Service
public class ToDoItemService {

    @Autowired
    private TodoItemMapper todoItemMapper;

    /**
     * 添加一个代办事项信息
     * @param todoItem 代办事项信息
     * @param request HttpServletRequest对象，用来获取用户的userId
     * @return 是否添加成功信息
     */
    public String  addToDoItem(TodoItem todoItem, HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        todoItem.setUserId(user.getUserId());
        int row = todoItemMapper.insertSelective(todoItem);
        String message;
        if(row > 0){
            message="添加成功";
        }else{
            message="添加失败";
        }
        return message;
    }

    /**
     * 通过代办事项的ID号删除该代办事项
     * @param id 要删除代办事项的ID
     * @return 删除是否成功信息
     */
    public String deleteToDoItem(int id){
        TodoItemExample todoItemExample = new TodoItemExample();
        todoItemExample.createCriteria().andTodoItemIdEqualTo(id);
        int  row = todoItemMapper.deleteByExample(todoItemExample);
        String message;
        if(row > 0){
            message="删除成功";
        }else{
            message="删除成功";
        }
        return message;
    }

    /**
     * 修改代办事项信息
     * @param todoItem 代办事项包含信息为
     * @param request HttpServletRequest对象，用来获取用户的userId
     * @return 修改是否成功信息
     */
    public String modifyDoItem(TodoItem todoItem, HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        todoItem.setLastUpdateDate(new Date());
        int row = todoItemMapper.updateByPrimaryKeySelective(todoItem);
        String message;
        if(row > 0){
            message="修改成功";
        }else{
            message="修改失败";
        }
        return message;
    }

    /**
     * 查询一个代办事项的具体信息
     * @param id 代办事项的todoItemId
     * @return 该代办事项的所有信息
     */
    public TodoItem selectToDoItemById(int id){
        TodoItem todoItem = todoItemMapper.selectByPrimaryKey(id);
        return todoItem;
    }

    /**
     * 返回用户的所有代办信息
     * @param request HttpServletRequest对象，用来获取用户的userId
     * @return 按照创建时间的顺序（晚创建的在前面）返回该用户的所有代办事项
     */
    public List<TodoItem> selectAllToDoItem(HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        TodoItemExample todoItemExample = new TodoItemExample();
        todoItemExample.createCriteria().andUserIdEqualTo(user.getUserId());
        List<TodoItem> todoItems = todoItemMapper.selectByExample(todoItemExample);
        return todoItems;
    }

}

