package com.scut.pojo;

import javax.validation.constraints.Pattern;

public class Reader {

    private Integer readerId;

    private String readerName;

    private Integer sex;

    @Pattern(regexp = "(^1\\d{10}$)",message = "提示:手机号不合法")
    private String phone;

    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)",message = "提示:密码应是6-16位英文和数字的组合")
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