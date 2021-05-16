package com.scut.service;

import com.scut.dao.AdminMapper;
import com.scut.pojo.Admin;
import com.scut.pojo.AdminExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
    @Autowired
    AdminMapper adminMapper;


    /**
     * 判断是否有匹配的管理员
     * @param admin_id
     * @param password
     * @return 返回false表示登录失败，否则登录成功
     */
    public boolean hasMatchAdmin(int admin_id,String password){
        AdminExample example = new AdminExample();
        AdminExample.Criteria criteria = example.createCriteria();
        criteria.andAdminIdEqualTo(admin_id);
        criteria.andAdminPwdEqualTo(password);
        long count = adminMapper.countByExample(example);
        return !(count==0);
    }

    /**
     * 通过id查询管理员姓名
     * @param id
     * @return
     */
    public Admin getAdminById(int id){
        Admin admin = adminMapper.selectByPrimaryKey(id);
        return admin;
    }

    /**
     * 修改密码
     * @param adminName
     * @param newPwd
     * @return
     */
    public boolean updatePwd(String adminName,String newPwd){
        AdminExample example = new AdminExample();
        AdminExample.Criteria criteria = example.createCriteria();
        criteria.andAdminNameEqualTo(adminName);
        int i = adminMapper.updateByExampleSelective(new Admin(null, adminName, newPwd), example);
        return i > 0;
    }


}
