package com.scut.dao;

import com.scut.pojo.Reader;
import com.scut.pojo.ReaderExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ReaderMapper {
    long countByExample(ReaderExample example);

    int deleteByExample(ReaderExample example);

    int deleteByPrimaryKey(Integer readerId);

    int insert(Reader record);

    int insertSelective(Reader record);

    List<Reader> selectByExample(ReaderExample example);

    Reader selectByPrimaryKey(Integer readerId);

    int updateByExampleSelective(@Param("record") Reader record, @Param("example") ReaderExample example);

    int updateByExample(@Param("record") Reader record, @Param("example") ReaderExample example);

    int updateByPrimaryKeySelective(Reader record);

    int updateByPrimaryKey(Reader record);
}