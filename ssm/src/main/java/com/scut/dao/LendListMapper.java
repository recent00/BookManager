package com.scut.dao;

import com.scut.pojo.LendList;
import com.scut.pojo.LendListExample;

import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;

import javax.xml.crypto.Data;

public interface LendListMapper {
    long countByExample(LendListExample example);

    int deleteByExample(LendListExample example);

    int deleteByPrimaryKey(Integer serNum);

    int insert(LendList record);

    int insertSelective(LendList record);

    List<LendList> selectByExample(LendListExample example);

    LendList selectByPrimaryKey(Integer serNum);

    List<LendList> selectByExampleWithBookAndReader(LendListExample example);

    LendList selectByPrimaryKeyWithBookAndReader(Integer serNum);

    List<LendList> selectByReaderIdWithBookAndReader(Integer readerId);

    List<LendList> selectWithStatusLog();

    List<LendList> selectWithStatusLogByReaderId(Integer readerId);

    List<LendList> selectWithStatusAudit();

    List<Integer> selectStatusByBookIdAndReaderId(@Param("bookId") Integer bookId,@Param("readerId") Integer readerId);

    int updateByExampleSelective(@Param("record") LendList record, @Param("example") LendListExample example);

    int updateByExample(@Param("record") LendList record, @Param("example") LendListExample example);

    int updateByPrimaryKeySelective(LendList record);

    int updateByPrimaryKey(LendList record);

    int updateStatusByPrimaryKey(@Param("serNum") Integer serNum, @Param("status") Integer status);

    int updateReturnByPrimaryKey(@Param("serNum") Integer serNum, @Param("status") Integer status, @Param("backDate") Date backDate);
}