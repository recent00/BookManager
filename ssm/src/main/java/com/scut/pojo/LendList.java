package com.scut.pojo;

import java.util.Date;

public class LendList {
    private Integer serNum;

    private Integer bookId;

    private Integer readerId;

    private Date lendDate;

    private Date backDate;

    private BookInfo bookInfo;

    private Reader reader;

    public LendList() {
    }

    public LendList(Integer serNum, Integer bookId, Integer readerId, Date lendDate, Date backDate, BookInfo bookInfo, Reader reader) {
        this.serNum = serNum;
        this.bookId = bookId;
        this.readerId = readerId;
        this.lendDate = lendDate;
        this.backDate = backDate;
        this.bookInfo = bookInfo;
        this.reader = reader;
    }

    public BookInfo getBookInfo() {
        return bookInfo;
    }

    public void setBookInfo(BookInfo bookInfo) {
        this.bookInfo = bookInfo;
    }

    public Reader getReader() {
        return reader;
    }

    public void setReader(Reader reader) {
        this.reader = reader;
    }

    public Integer getSerNum() {
        return serNum;
    }

    public void setSerNum(Integer serNum) {
        this.serNum = serNum;
    }

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public Integer getReaderId() {
        return readerId;
    }

    public void setReaderId(Integer readerId) {
        this.readerId = readerId;
    }

    public Date getLendDate() {
        return lendDate;
    }

    public void setLendDate(Date lendDate) {
        this.lendDate = lendDate;
    }

    public Date getBackDate() {
        return backDate;
    }

    public void setBackDate(Date backDate) {
        this.backDate = backDate;
    }

    @Override
    public String toString() {
        return "LendList{" +
                "serNum=" + serNum +
                ", bookId=" + bookId +
                ", readerId=" + readerId +
                ", lendDate=" + lendDate +
                ", backDate=" + backDate +
                ", bookInfo=" + bookInfo +
                ", reader=" + reader +
                '}';
    }
}