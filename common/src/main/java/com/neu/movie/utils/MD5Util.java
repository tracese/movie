package com.neu.movie.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Util {
    //MD5:消息摘要,将一段明文加密变成密文，并且不可逆
    static char[] chars = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
    public static String digest(String data){

        MessageDigest messageDigest = null;
        try {
            messageDigest = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        byte[] results = messageDigest.digest(data.getBytes());
        StringBuilder stringBuilder = new StringBuilder();
        for (int result:results) {
            if(result < 0){
                result = result + 256;
            }
            int height = result / 16;
            int low = result % 16;
            stringBuilder.append(chars[height]).append(chars[low]);
        }
        return stringBuilder.toString();
    }
    public static void main(String[] args){
        System.out.println(digest("zs"));
    }
}
