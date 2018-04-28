package com.rt.encrypt;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.MessageDigest;

public class JavaMD5 
{
    private static byte[] hexBase={ '0','1','2','3',
                                    '4','5','6','7',
                                    '8','9','a','b',
                                    'c','d','e','f',};

    public static String encrypt(String s,String charsetName)
    {
        if(s==null) return "";
        try 
        {
            byte buff[]=s.getBytes(charsetName);
            MessageDigest messagedigest = MessageDigest.getInstance("MD5");
            messagedigest.update(buff);
            byte result[] = messagedigest.digest();
            return byte2Hex(result);
        }
        catch(Exception e)
        {
            return "";
        }
    }
     public static String fileHash(String fileName)
        {
         return fileHash(new File(fileName));
        }
    
    public static String fileHash(File file)
    {
        try 
        {
            if(file==null)return null;
            byte buff[]=new byte[4096];
            MessageDigest messagedigest = MessageDigest.getInstance("MD5");
            FileInputStream fis=new FileInputStream(file);
            int len=0;
            while((len=fis.read(buff))>0)
            {
                messagedigest.update(buff,0,len);
            }
            fis.close();
            byte result[] = messagedigest.digest();
            return byte2Hex(result);
        }
        catch(IOException ei)
        {
            System.out.println(JavaMD5.class.getName()+": "+ei.getMessage());
            return "";
        }       
        catch(Exception e)
        {
            return "";
        }       
    }

    public static String byte2Hex(byte b[])
    { 
        if(b==null) return "";
        StringBuffer tmp=new StringBuffer();
        int len=b.length;
        for(int i=0;i<len;i++)
        {
            tmp.append((char)hexBase[(b[i] & 0xF0)>>4]);
            tmp.append((char)hexBase[b[i] & 0x0F]);
        }
        while(tmp.length()<16) tmp.append("00");
        
        return tmp.toString();
    }
public static void main(String arg[]){
    System.out.println(JavaMD5.encrypt("12345678", "utf-8"));
    
    
}
}
