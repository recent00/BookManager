package com.scut.service;

import com.scut.dao.BookInfoMapper;
import com.scut.pojo.BookInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookInfoService {
    @Autowired
    BookInfoMapper bookInfoMapper;

    public List<BookInfo> getBooks(){
        return bookInfoMapper.selectByExample(null);
    }
}
