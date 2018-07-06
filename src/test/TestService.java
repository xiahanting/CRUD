import com.hxzy.pojo.Employee;
import com.hxzy.service.DepartmentService;
import com.hxzy.service.EmployeeService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestService
{
    @Autowired
    private EmployeeService service;
    @Autowired
    private DepartmentService departmentService;



  //测试插入功能，并插入多条数据
    @Test
    public void  insert()
   {

       for(int i = 0;i<100; i++)
       {

           Employee employee = new Employee();
           String empName = UUID.randomUUID().toString().substring(0,5);
           employee.setEmpname(empName);
           if(i%2==0)
           {
               System.out.println(i+"---------");
               employee.setGender("男");
               employee.setDid(1);
           }else
           {
               employee.setGender("女");
               employee.setDid(2);
           }
           employee.setEmail(empName+"@163.com");

           service.addemp(employee);


       }



   }

   @Test
    public void test1(){
       Employee list = service.getEmp(10000);
       System.out.println(list);
       System.out.println(departmentService.getdeptAll());


   }

}
