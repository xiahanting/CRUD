package com.hxzy.service.impl;

import com.hxzy.mapper.EmployeeMapper;
import com.hxzy.pojo.Employee;
import com.hxzy.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmployeeServiceImpl implements EmployeeService
{

   @Autowired
   private EmployeeMapper mapper;



    @Override
    public List<Employee> getEmpAll()
    {
        return mapper.getEmpAll();
    }


   //删除
    @Override
    public int delemp(int id)
    {
        return mapper.deleteByPrimaryKey(id);
    }




   //插入功能
    @Override
    public int addemp(Employee employee)
    {

        return mapper.insert(employee);
    }


  //通过id,查询员工信息
    @Override
    public Employee getEmp(int id)
    {
        return mapper.selectByPrimaryKey(id);
    }


    //修改员工信息
    @Override
    public int updateEmp(Employee employee)
    {
        return mapper.updateByPrimaryKey(employee);
    }
}
