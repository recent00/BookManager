package com.scut.pojo;

public class Reader {

    private Integer readerId;

    private String readerName;

    private Integer sex;

    private String phone;

    private String readerPwd;

    public Reader(Integer readerId, String readerName, Integer sex, String phone, String readerPwd) {
        this.readerId = readerId;
        this.readerName = readerName;
        this.sex = sex;
        this.phone = phone;
        this.readerPwd = readerPwd;
    }

    public Reader() {
    }

    public Integer getReaderId() {
        return readerId;
    }

    public void setReaderId(Integer readerId) {
        this.readerId = readerId;
    }

    public String getReaderName() {
        return readerName;
    }

    public void setReaderName(String readerName) {
        this.readerName = readerName == null ? null : readerName.trim();
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getReaderPwd() {
        return readerPwd;
    }

    public void setReaderPwd(String readerPwd) {
        this.readerPwd = readerPwd == null ? null : readerPwd.trim();
    }

    @Override
    public String toString() {
        return "Reader{" +
                "readerId=" + readerId +
                ", readerName='" + readerName + '\'' +
                ", sex=" + sex +
                ", phone='" + phone + '\'' +
                ", readerPwd='" + readerPwd + '\'' +
                '}';
    }
}