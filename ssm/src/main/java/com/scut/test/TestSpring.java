package com.scut.test;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestSpring {

    ApplicationContext ioc = new ClassPathXmlApplicationContext("classpath:application.xml");
    @Test
    public void test1(){

    }

}
