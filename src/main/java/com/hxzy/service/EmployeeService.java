package com.hxzy.service;

import com.hxzy.pojo.Employee;
import java.util.List;

public interface EmployeeService
{
    //所有员工信息
    List<Employee> getEmpAll();


    //删除员工
    int delemp(int id);


    //增加员工
    int addemp(Employee employee);

    //通过id,得到员工信息

    Employee getEmp(int id);

    //更改员工

    int updateEmp(Employee employee);




}
