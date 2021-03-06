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

    /**
     * 检查手机号是否已经注册过
     * @param reader
     * @return 返回true表示手机号未被注册过，否则手机号已被注册
     */
    public boolean checkPhone(Reader reader){
        ReaderExample readerExample = new ReaderExample();
        ReaderExample.Criteria criteria = readerExample.createCriteria();
        criteria.andPhoneEqualTo(reader.getPhone());
        long count = readerMapper.countByExample(readerExample);
        return count==0;
    }

    /**
     * 注册用户，并将注册的用户保存进数据库，注册成功返回读者id，否则返回null
     * @param reader
     */
    public Integer register(Reader reader){
        if(checkPhone(reader)){
            readerMapper.insert(reader);
            System.out.println("注册成功");
            return reader.getReaderId();
        }else {
            System.out.println("手机号已被注册过，注册失败");
            return null;
        }
    }

    /**
     *
     * @param reader_id
     * @param password
     * @return 返回false表示登录失败，否则登录成功
     */
    public boolean hasMatchReader(int reader_id,String password){
        ReaderExample readerExample = new ReaderExample();
        ReaderExample.Criteria criteria = readerExample.createCriteria();
        criteria.andReaderIdEqualTo(reader_id);
        criteria.andReaderPwdEqualTo(password);
        long count = readerMapper.countByExample(readerExample);
        return !(count==0);
    }

    /**
     * 通过id获取读者
     * @param id
     * @return
     */
    public Reader getReaderById(int id){
        Reader reader = readerMapper.selectByPrimaryKey(id);
        return reader;
    }

    /**
     * 修改密码
     * @param readerName
     * @param newPwd
     * @return
     */
    public boolean updatePwd(String readerName,String newPwd){
        ReaderExample example = new ReaderExample();
        ReaderExample.Criteria criteria = example.createCriteria();
        criteria.andReaderNameEqualTo(readerName);
        int i = readerMapper.updateByExampleSelective(new Reader(null, readerName, null,null,newPwd), example);
        return i > 0;
    }

    /**
     * 修改手机号码
     * @param phone
     */
    public void updatePhone(Integer readerId,String phone){
        ReaderExample example = new ReaderExample();
        ReaderExample.Criteria criteria = example.createCriteria();
        criteria.andPhoneEqualTo(phone);
        readerMapper.updateByPrimaryKeySelective(new Reader(readerId,null,null,phone,null));
    }
}
