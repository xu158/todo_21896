package com.etc.dao;

import com.etc.entity.TodoItem;
import com.etc.entity.TodoItemExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TodoItemMapper {
    int countByExample(TodoItemExample example);

    int deleteByExample(TodoItemExample example);

    int deleteByPrimaryKey(Integer todoItemId);

    int insert(TodoItem record);

    int insertSelective(TodoItem record);

    List<TodoItem> selectByExample(TodoItemExample example);

    TodoItem selectByPrimaryKey(Integer todoItemId);

    int updateByExampleSelective(@Param("record") TodoItem record, @Param("example") TodoItemExample example);

    int updateByExample(@Param("record") TodoItem record, @Param("example") TodoItemExample example);

    int updateByPrimaryKeySelective(TodoItem record);

    int updateByPrimaryKey(TodoItem record);
}