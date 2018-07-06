package com.hxzy.service.impl;

import com.hxzy.mapper.DepartmentMapper;
import com.hxzy.pojo.Department;
import com.hxzy.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class DepartmentServiceImpl implements DepartmentService
{

    @Autowired
    private DepartmentMapper mapper;

  //查询所有列表
    @Override
    public List<Department> getdeptAll()
    {

        return mapper.selectByExample(null);
    }
}
