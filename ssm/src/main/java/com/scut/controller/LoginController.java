package com.scut.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.scut.pojo.Admin;
import com.scut.pojo.BookInfo;
import com.scut.pojo.Msg;
import com.scut.pojo.Reader;
import com.scut.service.AdminService;
import com.scut.service.BookInfoService;
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
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;

import static com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY;

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
    public Msg loginCheck(Integer id, String password, String code, HttpServletRequest request){
        System.out.println("loginCheck");
        //获取Session中的验证码
        String token = (String) request.getSession().getAttribute(KAPTCHA_SESSION_KEY);
        //删除Session中的验证码
        request.getSession().removeAttribute(KAPTCHA_SESSION_KEY);
        if(token != null && token.equalsIgnoreCase(code)){
            boolean isAdmin = adminService.hasMatchAdmin(id,password);
            boolean isReader = readerService.hasMatchReader(id,password);
            if(isAdmin){
                Admin admin = adminService.getAdminById(id);
                request.getSession().setAttribute("admin",admin);
                return Msg.success().add("admin",admin);
            }else if(isReader){
                Reader reader = readerService.getReaderById(id);
                request.getSession().setAttribute("reader",reader);
                return Msg.success().add("reader",reader);
            }else {
                return Msg.fail().add("msg","用户名或者密码错误");
            }
        }else {
            return Msg.fail().add("msg","验证码有误");
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
