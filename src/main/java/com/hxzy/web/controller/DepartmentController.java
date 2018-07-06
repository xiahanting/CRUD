package com.hxzy.web.controller;

import com.hxzy.pojo.Department;
import com.hxzy.service.DepartmentService;
import jdk.nashorn.internal.runtime.JSONListAdapter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController
{
    @Autowired
    private DepartmentService service;


   //查询部门列表
    @ResponseBody
    @RequestMapping("/deptList")
    public  List getdeptAll()
    {
        return service.getdeptAll();
    }
}
