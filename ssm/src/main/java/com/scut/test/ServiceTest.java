package com.scut.test;

import com.scut.dao.ReaderMapper;
import com.scut.pojo.Admin;
import com.scut.pojo.BookInfo;
import com.scut.pojo.Reader;
import com.scut.pojo.ReaderExample;
import com.scut.service.AdminService;
import com.scut.service.BookInfoService;
import com.scut.service.LendService;
import com.scut.service.ReaderService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

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

    @Autowired
    BookInfoService bookInfoService;

    @Autowired
    LendService lendService;
    @Test
    public void testAdminService(){
/*        boolean login = adminService.login(new Admin(null, "lys", "1232556"));
        System.out.println(login==true?"登录成功":"登录失败");*/
/*        boolean login = adminService.hasMatchAdmin(1001, "123456");
        System.out.println(login==true?"登录成功":"登录失败");*/
        boolean updatePwd = adminService.updatePwd("lys", "654321");
        if (updatePwd) System.out.println("修改成功");
        else System.out.println("修改失败");
    }

    @Test
    public void testReaderService(){
/*        boolean login = readerService.hasMatchReader(10000,"654321");
        System.out.println(login==true?"登录成功":"登录失败");*/

/*        boolean checkPhone = readerService.checkPhone(new Reader(10001, "张三", 1, "12325678900", "abcdefg"));
        System.out.println(checkPhone==true?"手机号未被注册过":"手机号已被注册过");*/

        Reader reader = new Reader(null,"李白",1,"12345678888","654321");
        System.out.println(readerService.register(reader));
    }

    @Test
    public void testBookInfoService(){
        List<BookInfo> books = bookInfoService.getBooksByBookName("8");
        if(books.size()==0)
            System.out.println("您查询的记录不存在");
        for (BookInfo book : books) {
            System.out.println(book);
        }
    }

    @Test
    public void testLendService(){
        boolean b = lendService.isLend(5, 10002);
        if(b) System.out.println("图书已经借过，借阅失败");
        else System.out.println("借阅成功");
    }

    @Test
    public void testBookUpdate(){
        //bookInfoService.updateNumber(6);
    }
}
