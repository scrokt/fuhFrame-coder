package com.rt.test.dataserver;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import com.rt.encrypt.JavaMD5;
import com.rt.encrypt.Tea;
import com.rt.http.HttpSender;

public class MacOnlineTest {

    public static void main(String[] args) throws UnsupportedEncodingException {
       /*List<Thread> threads = new ArrayList<Thread>();
       for(int i=0;i<500;i++){
           threads.add(new TestThread(i));
       }
       for(Thread thread:threads){
           thread.start();
       }*/
       //hotpotTrail();
       System.out.println(Long.valueOf("000001234"));
    }
    
    /**
     * 热点轨迹
     * @throws UnsupportedEncodingException
     */
    public static void hotpotTrail() throws UnsupportedEncodingException{
        send("action=Hotspot&cmd=trail&mac=02934401018C&ssid=OpenWrt&channel=1&encryptType=99&fieldStrength=-63&deviceLongitude=114.941136&deviceLatitude=25.837045&onlineTime=1461303211000&sessionId=2-7511224713493440129E2-02934401018C-1461303211000&placeCode=36230139000206&placeTypeGateway=0303&deviceCode=7511224713493440129E2");
    }
    
    
    public static void send(String param) throws UnsupportedEncodingException{
        param = param+"&time="+System.currentTimeMillis();
        // checkcode 加在后面
        String checkCode = JavaMD5.encrypt(param+"nccd","UTF-8");
        param = param + "&checkCode=" + checkCode;
        // 加密
        String encodeParam = Tea.encryptByTea(param);
        // 发送 GET 请求

        String s = HttpSender.sendGet("http://localhost:8080/","d2=" + URLEncoder.encode(encodeParam,"UTF-8"));
        System.out.println(s);
    }
    
    /**
     * 热点上线
     * @throws UnsupportedEncodingException
     */
    public static void hotpot() throws UnsupportedEncodingException{
        String param = "action=Hotspot&cmd=online&mac=02934401018C&ssid=OpenWrt"
                + "&channel=1&encryptType=99&fieldStrength=-63"
                + "&deviceLongitude=114.941136&deviceLatitude=25.837045"
                + "&onlineTime=1461303211000&sessionId=2-7511224713493440129E2-02934401018C-1461303211000"
                + "&placeCode=36230139000206&placeTypeGateway=0303&deviceCode=7511224713493440129E2";
        param = param+"&time="+System.currentTimeMillis();
        // checkcode 加在后面
        String checkCode = JavaMD5.encrypt(param+"nccd","UTF-8");
        param = param + "&checkCode=" + checkCode;
        // 加密
        String encodeParam = Tea.encryptByTea(param);
        // 发送 GET 请求

        String s = HttpSender.sendGet("http://localhost:8080/","d2=" + URLEncoder.encode(encodeParam,"UTF-8"));
        System.out.println(s);
    }
   
    
    /**
     * 浏览url
     * @throws UnsupportedEncodingException 
     */
    public static void url() throws UnsupportedEncodingException{
        String param = "action=Log&cmd=http&placeCode=3601010236" + "&identityCode=360124198202100402&identityKindCode=011"
                + "&sessionId=36230011011012345600000000000020140804092718287929" + "&placeTypeGateway=0101&createTime=" + System.currentTimeMillis()
                + "&url=http://www.3344.com/main.htm"
                 +"&time="+System.currentTimeMillis();
        // checkcode 加在后面
        String checkCode = JavaMD5.encrypt(param+"nccd","UTF-8");
        param = param + "&checkCode=" + checkCode;
        // 加密
        String encodeParam = Tea.encryptByTea(param);
        // 发送 GET 请求

        String s = HttpSender.sendGet("http://localhost:8080/","d2=" + URLEncoder.encode(encodeParam,"UTF-8"));
        System.out.println(s);
    }
    /**
     * 非命中url
     * @throws UnsupportedEncodingException
     */
    public static void url2() throws UnsupportedEncodingException{
        String param = "action=Log&cmd=http&placeCode=3601010236" + "&identityCode=360124198202100402&identityKindCode=011"
                + "&sessionId=36230011011012345600000000000020140804092718287929" + "&placeTypeGateway=0101&createTime=" + System.currentTimeMillis()
                + "&url=http://www.description.com/main.htm"
                 +"&time="+System.currentTimeMillis();
        // checkcode 加在后面
        String checkCode = JavaMD5.encrypt(param+"nccd","UTF-8");
        param = param + "&checkCode=" + checkCode;
        // 加密
        String encodeParam = Tea.encryptByTea(param);
        // 发送 GET 请求

        String s = HttpSender.sendGet("http://localhost:8080/","d2=" + URLEncoder.encode(encodeParam,"UTF-8"));
        System.out.println(s);
    }
    
    /**
     * 网民上线
     * @throws UnsupportedEncodingException
     */
    private static void online() throws UnsupportedEncodingException{
        String param = "action=Log&cmd=http&placeCode=3601010236" + "&identityCode=360124198202100402&identityKindCode=011"
                + "&sessionId=36230011011012345600000000000020140804092718287929" + "&placeTypeGateway=0101&createTime=" + System.currentTimeMillis()
                + "&url=http://www.3344.com/main.htm";
        // checkcode 加在后面
        String checkCode = JavaMD5.encrypt(param+"nccd","UTF-8");
        param = param + "&checkCode=" + checkCode;
        // 加密
        String encodeParam = Tea.encryptByTea(param);
        // 发送 GET 请求

        String s = HttpSender.sendGet("http://localhost:8080/","d2=" + URLEncoder.encode(encodeParam,"UTF-8"));
        System.out.println(s);
    }
    /**
     * 电子围栏设备上线
     * @throws UnsupportedEncodingException 
     */
    private static void elefenceMacOnline() throws UnsupportedEncodingException{
        String param = "action=EleFenceMac&cmd=online&placeCode=3601001671" + "&deviceCode=110110000000001671&macAddr=A6870000586D"
                + "&sessionId=3601001671-06870000586D-74199379" + "&deviceSingnal=-10&onlineTime=" + System.currentTimeMillis() + "&actionTime="
                + System.currentTimeMillis() + "&deviceLongitude=000.000000&deviceLatitude=000.000000"
                +"&time="+System.currentTimeMillis();
        // checkcode 加在后面
        String checkCode = JavaMD5.encrypt(param+"nccd","UTF-8");
        param = param + "&checkCode=" + checkCode;
        // 加密
        String encodeParam = Tea.encryptByTea(param);
        // 发送 GET 请求

        String s = HttpSender.sendGet("http://localhost:8080/","d2=" + URLEncoder.encode(encodeParam,"UTF-8"));
        System.out.println(s);
    }
}
