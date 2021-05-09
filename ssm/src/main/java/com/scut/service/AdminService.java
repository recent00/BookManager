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
     * 管理员登录
     * @param admin
     * @return 返回false表示登录失败，否则登录成功
     */
    public boolean login(Admin admin){
        AdminExample example = new AdminExample();
        AdminExample.Criteria criteria = example.createCriteria();
        criteria.andAdminNameEqualTo(admin.getAdminName());
        criteria.andAdminPwdEqualTo(admin.getAdminPwd());
        long count = adminMapper.countByExample(example);
        return !(count==0);
    }
}
