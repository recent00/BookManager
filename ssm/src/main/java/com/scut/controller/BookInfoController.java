package com.scut.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.scut.pojo.BookInfo;
import com.scut.pojo.Msg;
import com.scut.service.BookInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
public class BookInfoController {

    @Autowired
    BookInfoService bookInfoService;

    /**
     * 获取所有图书
     * @param pn
     * @return
     */
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

    /**
     * 对图书进行模糊查询
     * @param bookName
     * @param pn
     * @return
     */
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

    /**
     * 检查图书是否已经存在
     * @param bookName
     * @return
     */
    @RequestMapping(value = "/checkbook", method = RequestMethod.POST)
    @ResponseBody
    public Msg checkBook(String bookName){
        boolean b = bookInfoService.ckeckBook(bookName);
        if(b) return Msg.success();
        else return Msg.fail().add("va_msg","图书已存在，不可重复添加");
    }

    /**
     * 检查isbn是否重复
     * @param isbn
     * @return
     */
    @RequestMapping(value = "/checkisbn", method = RequestMethod.POST)
    @ResponseBody
    public Msg checkIsbn(String isbn){
        boolean b = bookInfoService.checkIsbn(isbn);
        if(b) return Msg.success();
        else return Msg.fail().add("va_msg","不合法ISBN");
    }

    /**
     * 保存图书
     * @param bookInfo
     * @return
     */
    @RequestMapping(value = "/book",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveBook(BookInfo bookInfo){
        System.out.println("/book");
        bookInfoService.saveBook(bookInfo);
        return Msg.success();
    }

    /**
     * 回显图书数据
     * @param id
     * @return
     */
    @RequestMapping(value = "/book/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getBookById(@PathVariable("id") Integer id){
        System.out.println("getBookById");
        BookInfo book = bookInfoService.getBookInfoById(id);
        return Msg.success().add("book",book);
    }

    /**
     * 更新图书
     * @param bookInfo
     * @return
     */
    @RequestMapping(value = "/book/{bookId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateBook(BookInfo bookInfo){
        System.out.println(bookInfo);
        bookInfoService.updateBook(bookInfo);
        return Msg.success().add("msg","更新成功");
    }

    /**
     * 批量、单个删除图书
     * @param ids
     * @return
     */
    @RequestMapping(value = "/book/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteBook(@PathVariable("ids") String ids){
       //批量删除
        if(ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for (String str_id : str_ids) {
                del_ids.add(Integer.parseInt(str_id));
                bookInfoService.deleteBatch(del_ids);
            }
        }else {
            //单个删除
            int id = Integer.parseInt(ids);
            bookInfoService.deleteBook(id);
        }
        return Msg.success().add("msg","删除成功");
    }
}
