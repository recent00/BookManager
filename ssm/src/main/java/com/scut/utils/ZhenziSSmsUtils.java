package com.scut.utils;

import com.zhenzi.sms.ZhenziSmsClient;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class ZhenziSSmsUtils {
    private static final String apiUrl = "https://sms_developer.zhenzikj.com";
    private static final String appId = "109176";
    private static final String appSecret = "f1f51922-3839-4ab4-86cf-e485972eeec0";
    private static final  String templateId = "5456";

    /**
     * 获取6位随机码
     * @return
     */
    public static String getCode(){
        return String.valueOf(new Random().nextInt(899999) + 100000);
    }

    /**
     * 发送短信给手机接收验证码
     * @param phone 手机号
     * @param code 验证码
     * @return 1：有异常  0：成功
     */
    public static String sendToPhone(String phone,String code){
        ZhenziSmsClient client = new ZhenziSmsClient(apiUrl,appId,appSecret);
        Map<String, Object> params = new HashMap<>();
        params.put("number", phone);
        params.put("templateId", templateId);
        String[] templateParams = new String[2];
        templateParams[0] = code;
        templateParams[1] = "5";
        params.put("templateParams", templateParams);
        try {
            String result = client.send(params);
            return result;
        } catch (Exception e) {
            return "发送失败";
        }
    }
}
