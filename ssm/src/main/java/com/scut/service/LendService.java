package com.scut.service;

import com.scut.dao.LendListMapper;
import com.scut.pojo.LendList;
import com.scut.utils.Status;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class LendService {

    @Autowired
    LendListMapper lendListMapper;

    /**
     * 查询借还日志
     * @return
     */
    public List<LendList> adminLendLog(){
        return lendListMapper.selectWithStatusLog();
    }

    public List<LendList> adminAuditLog(){
        return lendListMapper.selectWithStatusAudit();
    }

    /**
     * 通过id删除日志记录
     * @param id
     */
    public void delLog(Integer id){
        lendListMapper.deleteByPrimaryKey(id);
    }

    /**
     * 判断是否已经借阅到图书
     * @param bookId
     * @param readerId
     * @return true表示已经借阅，false表示尚未借阅
     */
    public boolean isLend(Integer bookId,Integer readerId){
        List<Integer> list = lendListMapper.selectStatusByBookIdAndReaderId(bookId, readerId);
        for (Integer status : list) {
            if(status == 1 || status==2) return true;
        }
        return false;
    }

    /**
     * 借阅图书
     * @param bookId
     * @param readerId
     * @return true:借阅进入审批状态   false;借阅失败
     */
    public boolean lendBook(Integer bookId,Integer readerId){
        if(isLend(bookId,readerId)) return false;
        lendListMapper.insert(new LendList(bookId,readerId,new Date(),null, Status.WAITING_LEND));
        return true;
    }

    /**
     * 根据流水号查询图书id
     * @param serNum
     * @return
     */
    public Integer getBookId(Integer serNum){
        LendList lendList = lendListMapper.selectByPrimaryKey(serNum);
        return lendList.getBookId();
    }

    /**
     * 更新日志记录状态
     * @param serNum
     * @param status
     */
    public void updateLogStatus(Integer serNum,Integer status){
        lendListMapper.updateStatusByPrimaryKey(serNum,status);
    }

    /**
     * 获取读者借还日志
     * @param readerId
     * @return
     */
    public List<LendList> readerLendLog(Integer readerId) {
        return lendListMapper.selectByReaderIdWithBookAndReader(readerId);
    }

    /**
     * 读者还书
     * @param serNum
     */
    public void returnBook(Integer serNum){
        lendListMapper.updateReturnByPrimaryKey(serNum,Status.FINAL_LEND,new Date());
    }
}
