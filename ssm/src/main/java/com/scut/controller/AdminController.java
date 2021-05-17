package com.scut.controller;

import com.scut.pojo.Admin;
import com.scut.pojo.Msg;
import com.scut.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class AdminController {

    @Autowired
    AdminService adminService;

    @RequestMapping(value = "/changePwd",method = RequestMethod.POST)
    @ResponseBody
    public Msg changePwd(HttpServletRequest request, String oldPwd, String newPwd){
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        Integer adminId = admin.getAdminId();
        Admin adminById = adminService.getAdminById(adminId);
        if(adminById.getAdminPwd().equals(oldPwd)){
            adminService.updatePwd(admin.getAdminName(),newPwd);
            return Msg.success().add("msg","密码修改成功");
        }else {
            return Msg.fail().add("msg","旧密码错误");
        }
    }
}
