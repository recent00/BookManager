package com.scut.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.scut.pojo.BookInfo;
import com.scut.pojo.LendList;
import com.scut.pojo.Msg;
import com.scut.service.BookInfoService;
import com.scut.service.LendService;
import com.scut.utils.Status;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class LendController {

    @Autowired
    LendService lendService;

    @Autowired
    BookInfoService bookInfoService;

    /**
     * 管理员查询所有日志记录
     * @param pn
     * @return
     */
    @RequestMapping(value = "/getLogs",method = RequestMethod.GET)
    @ResponseBody
    public Msg getLogs(@RequestParam(value = "pn", defaultValue = "1") Integer pn){
        System.out.println("getLogs");
        // 引入PageHelper分页插件
        // 在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<LendList> lendLists = lendService.adminLendLog();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        // 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数3
        PageInfo page = new PageInfo(lendLists, 3);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 删除日志记录
     * @param delId
     * @return
     */
    @RequestMapping(value = "/log/{delete-id}")
    @ResponseBody
    public Msg delLog(@PathVariable("delete-id") Integer delId){
        System.out.println("log" + delId);
        lendService.delLog(delId);
        return Msg.success().add("msg","删除成功");
    }

    /**
     * 读者借阅图书
     * @param bookId
     * @param readerId
     * @return
     */
    @RequestMapping(value = "/lendBook")
    @ResponseBody
    public Msg lendBook(Integer bookId,Integer readerId){
        boolean b = lendService.lendBook(bookId, readerId);
        if(b) {
            boolean isNotEmpty = bookInfoService.updateNumber(bookId, 0);
            if(isNotEmpty)
                return Msg.success().add("msg","请等待管理员审核");
            else return Msg.fail().add("msg","您借阅的图书库存为空");
        }
        return Msg.fail().add("msg","您已借阅该图书，借阅失败");
    }

    /**
     * 获取待审核图书记录
     * @param pn
     * @return
     */
    @RequestMapping(value = "/getAuditLogs",method = RequestMethod.GET)
    @ResponseBody
    public Msg getAuditLogs(@RequestParam(value = "pn", defaultValue = "1") Integer pn){
        System.out.println("getAuditLogs");
        // 引入PageHelper分页插件
        // 在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<LendList> lendLists = lendService.adminAuditLog();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        // 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数3
        PageInfo page = new PageInfo(lendLists, 3);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 管理员审核通过
     * @param serNum
     * @return
     */
    @RequestMapping(value = "/passLend/{pass-id}")
    @ResponseBody
    public Msg passLend(@PathVariable("pass-id") Integer serNum){
        lendService.updateLogStatus(serNum, Status.IN_LEND);
        return Msg.success();
    }

    /**
     * 管理员审核拒绝
     * @param serNum
     * @return
     */
    @RequestMapping(value = "/rejectLend/{reject-id}")
    @ResponseBody
    public Msg rejectLend(@PathVariable("reject-id") Integer serNum){
        lendService.updateLogStatus(serNum, Status.REJECT_LEND);
        Integer bookId = lendService.getBookId(serNum);
        bookInfoService.updateNumber(bookId,1);
        return Msg.success();
    }

    /**
     * 获取读者日志
     * @param pn
     * @param readerId
     * @return
     */
    @RequestMapping(value = "/getReaderLogs",method = RequestMethod.GET)
    @ResponseBody
    public Msg getReaderLogs(@RequestParam(value = "pn", defaultValue = "1") Integer pn,Integer readerId){
        System.out.println("getReaderLogs");
        PageHelper.startPage(pn, 5);
        List<LendList> lendLists = lendService.readerLendLog(readerId);
        PageInfo page = new PageInfo(lendLists, 3);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 读者归还图书
     * @param serNum
     * @return
     */
    @RequestMapping(value = "/returnBook/{return-id}", method = RequestMethod.POST)
    @ResponseBody
    public Msg returnBook(@PathVariable("return-id") Integer serNum){
        lendService.returnBook(serNum);
        Integer bookId = lendService.getBookId(serNum);
        bookInfoService.updateNumber(bookId,1);
        return Msg.success();
    }
}
