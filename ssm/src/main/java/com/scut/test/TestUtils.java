package com.scut.test;

import com.zhenzi.sms.ZhenziSmsClient;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class TestUtils {
    public static void main(String[] args) throws Exception {
        // 初始化ZhenziSmsClient
/*        ZhenziSmsClient client = new ZhenziSmsClient("https://sms_developer.zhenzikj.com","109176"," f1f51922-3839-4ab4-86cf-e485972eeec0");
        Map<String, Object> params = new HashMap<>();
        params.put("number", "15759285986");
        params.put("templateId", "5456");
        String[] templateParams = new String[2];
        templateParams[0] = "3421";
        templateParams[1] = "5分钟";
        params.put("templateParams", templateParams);
        String result = client.send(params);
        System.out.println(result);*/
        System.out.println(String.valueOf(new Random().nextInt(899999) + 100000));
    }
}
