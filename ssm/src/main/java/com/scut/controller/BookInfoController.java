package com.scut.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.scut.pojo.BookInfo;
import com.scut.pojo.Msg;
import com.scut.service.BookInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class BookInfoController {

    @Autowired
    BookInfoService bookInfoService;

    @RequestMapping(value = "/getBooks", method = RequestMethod.GET)
    @ResponseBody
    public Msg getBooks(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        System.out.println("getBooks");
        // 引入PageHelper分页插件
        // 在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<BookInfo> books = bookInfoService.getBooks();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        // 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数3
        PageInfo page = new PageInfo(books, 3);
        System.out.println(page.getList());
        return Msg.success().add("pageInfo", page);
    }

    @RequestMapping(value = "/getBooksByBookName", method = RequestMethod.GET)
    @ResponseBody
    public Msg getBooksByBookName(@RequestParam(value = "bookName") String bookName,@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        System.out.println("getBooksByBookName");
        PageHelper.startPage(pn, 5);
        List<BookInfo> books = bookInfoService.getBooksByBookName(bookName);
        PageInfo page = new PageInfo(books, 3);
        System.out.println(page.getList());
        if (books.size() == 0){
            return Msg.fail().add("msg","查询不到该记录");
        }else {
            return Msg.success().add("pageInfo", page);
        }
    }

    @RequestMapping(value = "/checkbook", method = RequestMethod.POST)
    @ResponseBody
    public Msg checkBook(String bookName){
        boolean b = bookInfoService.ckeckBook(bookName);
        if(b) return Msg.success();
        else return Msg.fail().add("va_msg","图书已存在，不可重复添加");
    }

    @RequestMapping(value = "/checkisbn", method = RequestMethod.POST)
    @ResponseBody
    public Msg checkIsbn(String isbn){
        boolean b = bookInfoService.checkIsbn(isbn);
        if(b) return Msg.success();
        else return Msg.fail().add("va_msg","不合法ISBN");
    }

    @RequestMapping(value = "/book",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveBook(BookInfo bookInfo){
        System.out.println("/book");
        bookInfoService.saveBook(bookInfo);
        return Msg.success();
    }
}
