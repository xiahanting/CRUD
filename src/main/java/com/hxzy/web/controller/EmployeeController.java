package com.hxzy.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hxzy.pojo.Employee;
import com.hxzy.pojo.Msg;
import com.hxzy.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;

@Controller
public class EmployeeController
{
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private Msg msg;


    //分页查询员工信息
    @ResponseBody
    @RequestMapping("/empList/{pageNum}")
    public Msg getAllEmp(@PathVariable int pageNum)
    {

        msg.setCode(100);
        msg.setMessage("请求成功");

        //开启分页功能
        PageHelper.startPage(pageNum, 5);
        List<Employee> employees = employeeService.getEmpAll();
        PageInfo<Employee> pageInfo = new PageInfo<>(employees);
        msg.setPageInfo(pageInfo);
        return msg;


    }

    //新增员工
    @ResponseBody
    @RequestMapping("/addEmp")
    public Msg addEmp(Employee employee)
    {
        employeeService.addemp(employee);
        msg.setMessage("新增员工成功");
        return msg;

    }

    //删除员工
    @ResponseBody
    @RequestMapping("/delEmp")
    public Msg delEmp(int empid)
    {
        employeeService.delemp(empid);
        msg.setMessage("删除员工成功");
        return msg;

    }


    //进入修改界面
    @ResponseBody
    @PostMapping("/updateUI/{empid}")
    public Employee updateUI(@PathVariable int empid)
    {
        return employeeService.getEmp(empid);
    }

    //批量删除
    @ResponseBody
    @PostMapping("/delSelEmp")
    public Msg delSelEmp(int[] empid)
    {
        for (int i:empid)
        {
            employeeService.delemp(i);
        }
        msg.setMessage("批量删除成功");

         return msg;
    }

    //更新员工信息
    @ResponseBody
    @PostMapping("/updateEmp")
    public Msg updateEmp(Employee employee)
    {
        employeeService.updateEmp(employee);
        msg.setMessage("更新员工成功");

        return msg;
    }
}
