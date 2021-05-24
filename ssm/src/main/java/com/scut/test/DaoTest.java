package com.scut.test;


import com.scut.dao.AdminMapper;
import com.scut.dao.LendListMapper;
import com.scut.pojo.Admin;
import com.scut.pojo.AdminExample;
import com.scut.pojo.LendList;
import com.scut.utils.Status;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.List;

/**
 * Spring单元测试
 * ContextConfiguration:指定Spring配置文件的位置
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:application.xml"})
public class DaoTest {

    @Autowired
    AdminMapper adminMapper;

    @Autowired
    LendListMapper lendListMapper;


    @Test
    public void testSearch(){
        Admin admin = adminMapper.selectByPrimaryKey(1);
        System.out.println(admin);
    }

    @Test
    public void testInsert(){
        int i = adminMapper.insert(new Admin(null, "lys", "654321"));
        System.out.println(i);
    }

    @Test
    public void testUpdate(){
        int i = adminMapper.updateByPrimaryKey(new Admin(2, "lys", "123456"));
        System.out.println(i);
    }

    @Test
    public void testLendList(){
/*        List<LendList> lendLists = lendListMapper.selectByExampleWithBookAndReader(null);
        for (LendList lendList : lendLists) {
            System.out.println(lendList);
        }*/
        List<LendList> lists = lendListMapper.selectByReaderIdWithBookAndReader(10007);
        for (LendList list : lists) {
            System.out.println(list);
        }
    }

    @Test
    public void testAdmin(){
        AdminExample example = new AdminExample();
        AdminExample.Criteria criteria = example.createCriteria();
        criteria.andAdminNameEqualTo("admin1");
        criteria.andAdminPwdEqualTo("123456");
        long count = adminMapper.countByExample(example);
        System.out.println(count==0);
    }

    @Test
    public void testLendSelect(){
/*        List<LendList> lendLists = lendListMapper.selectWithStatusLog();
        for (LendList lendList : lendLists) {
            System.out.println(lendList);
        }*/

/*        List<LendList> lendLists = lendListMapper.selectWithStatusAudit();
        */
        List<LendList> lendLists = lendListMapper.selectWithStatusLogByReaderId(10007);
        for (LendList lendList : lendLists) {
            System.out.println(lendList);
        }
/*        Integer status = lendListMapper.selectStatusByBookIdAndReaderId(10, 10002);
        System.out.println(status);*/
    }

    @Test
    public void testLendInsert(){
        lendListMapper.insert(new LendList(6,10007,new Date(),new Date(), Status.FINAL_LEND));
    }

    @Test
    public void testLendUpdate(){
        /*lendListMapper.updateStatusByPrimaryKey(7,0);*/
        lendListMapper.updateReturnByPrimaryKey(11, 0, new Date());
    }
}
