package com.scut.service;

import com.scut.dao.BookInfoMapper;
import com.scut.pojo.BookInfo;
import com.scut.pojo.BookInfoExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookInfoService {
    @Autowired
    BookInfoMapper bookInfoMapper;

    /**
     * 获取全部图书
     * @return
     */
    public List<BookInfo> getBooks(){
        return bookInfoMapper.selectByExample(null);
    }

    /**
     * 对图书进行模糊查询
     * @param bookName
     * @return
     */
    public List<BookInfo> getBooksByBookName(String bookName){
        BookInfoExample bookInfoExample = new BookInfoExample();
        BookInfoExample.Criteria criteria = bookInfoExample.createCriteria();
        if(bookName!=null && !"".equals(bookName)){
            criteria.andBookNameLike("%"+bookName+"%");
        }
        List<BookInfo> books = bookInfoMapper.selectByExample(bookInfoExample);
        return books;
    }

    /**
     * 检查图书是否已经存在
     * @param bookName
     * @return true:代表不存在，可用  false：不可用
     */
    public boolean ckeckBook(String bookName){
        BookInfoExample bookInfoExample = new BookInfoExample();
        BookInfoExample.Criteria criteria = bookInfoExample.createCriteria();
        criteria.andBookNameEqualTo(bookName);
        long count = bookInfoMapper.countByExample(bookInfoExample);
        return count == 0;
    }

    /**
     * 检查isbn是否已经存在
     * @param isbn
     * @return true:代表不存在，可用  false：不可用
     */
    public boolean checkIsbn(String isbn){
        BookInfoExample bookInfoExample = new BookInfoExample();
        BookInfoExample.Criteria criteria = bookInfoExample.createCriteria();
        criteria.andIsbnEqualTo(isbn);
        long count = bookInfoMapper.countByExample(bookInfoExample);
        return count == 0;
    }

    public void saveBook(BookInfo bookInfo){
        bookInfoMapper.insertSelective(bookInfo);
    }

    /**
     * 通过id获取图书
     * @param id
     * @return
     */
    public BookInfo getBookInfoById(Integer id){
        return bookInfoMapper.selectByPrimaryKey(id);
    }

    /**
     * 更新图书
     * @param bookInfo
     */
    public void updateBook(BookInfo bookInfo){
        bookInfoMapper.updateByPrimaryKeySelective(bookInfo);
    }

    /**
     * 更新库存
     * @param bookId
     * @param flag 0:库存减一   1：库存加一
     * @return false:库存为空 true:更新成功
     */
    public boolean updateNumber(Integer bookId, Integer flag){
        BookInfo bookInfo = bookInfoMapper.selectByPrimaryKey(bookId);
        if(bookInfo.getNumber() == 0) return false;
        Integer newNumber = null;
        if(flag == 0){
            newNumber = bookInfo.getNumber() - 1;
        }else {
            newNumber = bookInfo.getNumber() + 1;
        }
        bookInfo.setNumber(newNumber);
        bookInfoMapper.updateByPrimaryKeySelective(bookInfo);
        return true;
    }

    /**
     * 删除图书（单个删除）
     * @param id
     */
    public void deleteBook(Integer id){
        bookInfoMapper.deleteByPrimaryKey(id);
    }

    /**
     * 删除图书（批量删除）
     * @param del_ids
     */
    public void deleteBatch(List<Integer> del_ids){
        BookInfoExample example = new BookInfoExample();
        BookInfoExample.Criteria criteria = example.createCriteria();
        criteria.andBookIdIn(del_ids);
        bookInfoMapper.deleteByExample(example);
    }
}
