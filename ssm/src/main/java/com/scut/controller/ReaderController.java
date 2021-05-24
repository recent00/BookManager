package com.scut.controller;

import com.scut.pojo.Msg;
import com.scut.pojo.Reader;
import com.scut.service.ReaderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ReaderController {

    @Autowired
    ReaderService readerService;

    /**
     * 修改密码
     * @param request
     * @param oldPwd
     * @param newPwd
     * @return
     */
    @RequestMapping(value = "/reader_changePwd", method = RequestMethod.PUT)
    @ResponseBody
    public Msg readerChangePwd(HttpServletRequest request, String oldPwd, String newPwd){
        Reader reader = (Reader) request.getSession().getAttribute("reader");
        Integer readerId = reader.getReaderId();
        Reader readerById = readerService.getReaderById(readerId);
        if(readerById.getReaderPwd().equals(oldPwd)){
            readerService.updatePwd(readerById.getReaderName(),newPwd);
            return Msg.success().add("msg","密码修改成功");
        }else {
            return Msg.fail().add("msg","旧密码错误");
        }
    }

    @RequestMapping(value = "/updatePhone",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updatePhone(Integer readerId,String phone,HttpServletRequest request){
        System.out.println(phone);
        boolean b = readerService.checkPhone(new Reader(null, null, null, phone, null));
        if(b){
            readerService.updatePhone(readerId,phone);
            Reader reader = (Reader) request.getSession().getAttribute("reader");
            reader.setPhone(phone);
            request.getSession().setAttribute("reader",reader);
            return Msg.success();
        }else {
            return Msg.fail().add("msg","手机号已被注册过");
        }
    }
}
