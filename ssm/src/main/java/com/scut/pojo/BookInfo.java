package com.scut.pojo;

import java.math.BigDecimal;

public class BookInfo {
    private Integer bookId;

    private String author;

    private String publish;

    private String bookName;

    private String isbn;

    private BigDecimal price;

    private Integer number;

    public BookInfo() {
    }

    public BookInfo(Integer bookId, String author, String publish, String bookName, String isbn, BigDecimal price, Integer number) {
        this.bookId = bookId;
        this.author = author;
        this.publish = publish;
        this.bookName = bookName;
        this.isbn = isbn;
        this.price = price;
        this.number = number;
    }

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author == null ? null : author.trim();
    }

    public String getPublish() {
        return publish;
    }

    public void setPublish(String publish) {
        this.publish = publish == null ? null : publish.trim();
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName == null ? null : bookName.trim();
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn == null ? null : isbn.trim();
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    @Override
    public String toString() {
        return "BookInfo{" +
                "bookId=" + bookId +
                ", author='" + author + '\'' +
                ", publish='" + publish + '\'' +
                ", bookName='" + bookName + '\'' +
                ", isbn='" + isbn + '\'' +
                ", price=" + price +
                ", number=" + number +
                '}';
    }
}