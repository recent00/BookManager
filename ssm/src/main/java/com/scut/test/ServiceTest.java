package com.scut.test;

import com.scut.dao.ReaderMapper;
import com.scut.pojo.Admin;
import com.scut.pojo.Reader;
import com.scut.pojo.ReaderExample;
import com.scut.service.AdminService;
import com.scut.service.ReaderService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Spring单元测试
 * ContextConfiguration:指定Spring配置文件的位置
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:application.xml"})
public class ServiceTest {

    @Autowired
    AdminService adminService;

    @Autowired
    ReaderService readerService;


    @Test
    public void testAdminService(){
        boolean login = adminService.login(new Admin(null, "lys", "1232556"));
        System.out.println(login==true?"登录成功":"登录失败");
    }

    @Test
    public void testReaderService(){
/*        boolean login = readerService.login(new Reader(10001, null, 0, null, "abcdefg"));
        System.out.println(login==true?"登录成功":"登录失败");*/

/*        boolean checkPhone = readerService.checkPhone(new Reader(10001, "张三", 1, "12325678900", "abcdefg"));
        System.out.println(checkPhone==true?"手机号未被注册过":"手机号已被注册过");*/

        readerService.register(new Reader(null,"李梅",0,"12345678909","654321"));
    }
}
