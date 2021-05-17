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
}
