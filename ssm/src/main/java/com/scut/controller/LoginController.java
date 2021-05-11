package com.scut.controller;

import com.scut.pojo.Msg;
import com.scut.service.AdminService;
import com.scut.service.ReaderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LoginController {

    @Autowired
    AdminService adminService;
    @Autowired
    ReaderService readerService;

    @RequestMapping(value = "/loginCheck",method = RequestMethod.POST)
    @ResponseBody
    public Msg loginCheck(Integer id,String password,HttpServletRequest request){
        System.out.println("loginCheck");
        boolean isAdmin = adminService.hasMatchAdmin(id,password);
        boolean isReader = readerService.hasMatchReader(id,password);
        if(isAdmin){
            String adminName = adminService.getAdminNameById(id);
            request.getSession().setAttribute("adminName",adminName);
            System.out.println(adminName);
            return Msg.success().add("adminName",adminName);
        }else if(isReader){
            String readerName = readerService.getReaderNameById(id);
            request.getSession().setAttribute("readerName",readerName);
            System.out.println(readerName);
            return Msg.success().add("readerName",readerName);
        }else {
            return Msg.fail().add("msg","用户名或者密码错误");
        }
    }
}
