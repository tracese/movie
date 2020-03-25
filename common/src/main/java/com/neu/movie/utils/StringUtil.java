package com.neu.movie.utils;

public class StringUtil {
    public static boolean isEmpty(String param){
        return param == null || "".equals(param.trim());
    }
}
