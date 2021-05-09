package com.scut.service;

import com.scut.dao.ReaderMapper;
import com.scut.pojo.Reader;
import com.scut.pojo.ReaderExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReaderService {

    @Autowired
    ReaderMapper readerMapper;

    private ReaderExample readerExample = new ReaderExample();
    private ReaderExample.Criteria criteria = readerExample.createCriteria();

    /**
     * 检查手机号是否已经注册过
     * @param reader
     * @return 返回true表示手机号未被注册过，否则手机号已被注册
     */
    public boolean checkPhone(Reader reader){

        criteria.andPhoneEqualTo(reader.getPhone());
        long count = readerMapper.countByExample(readerExample);
        return count==0;
    }

    /**
     * 注册用户，并将注册的用户保存进数据库
     * @param reader
     */
    public void register(Reader reader){
        if(checkPhone(reader)){
            readerMapper.insert(reader);
            System.out.println("注册成功");
        }else {
            System.out.println("手机号已被注册过，注册失败");
        }
    }

    /**
     * 普通读者登录
     * @param reader
     * @return 返回false表示登录失败，否则登录成功
     */
    public boolean login(Reader reader){
        criteria.andReaderIdEqualTo(reader.getReaderId());
        criteria.andReaderPwdEqualTo(reader.getReaderPwd());
        long count = readerMapper.countByExample(readerExample);
        return !(count==0);
    }
}
