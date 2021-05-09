package com.scut.dao;

import com.scut.pojo.LendList;
import com.scut.pojo.LendListExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

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

    List<LendList> selectByReaderNameWithBookAndReader(String name);

    int updateByExampleSelective(@Param("record") LendList record, @Param("example") LendListExample example);

    int updateByExample(@Param("record") LendList record, @Param("example") LendListExample example);

    int updateByPrimaryKeySelective(LendList record);

    int updateByPrimaryKey(LendList record);
}