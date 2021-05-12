package com.scut.controller;

import com.scut.pojo.Msg;
import com.scut.pojo.Reader;
import com.scut.service.AdminService;
import com.scut.service.ReaderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;

@Controller
public class LoginController {

    @Autowired
    AdminService adminService;
    @Autowired
    ReaderService readerService;

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request){
        request.getSession().invalidate();
        return "redirect:/pages/login/login.jsp";
    }

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

    @RequestMapping(value = "/register",method = RequestMethod.POST)
    @ResponseBody
    public Msg register(@Valid Reader reader, BindingResult result){
        if(result.hasErrors()){
            HashMap<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println(fieldError.getField() + ":" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else {
            Integer readerId = readerService.register(reader);
            if(readerId == null) return Msg.fail().add("info","手机号已被注册过，注册失败");
            else return Msg.success().add("readerId",readerId);
        }
    }
}
