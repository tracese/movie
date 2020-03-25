package util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class SysUtil {
    private static Properties properties = null;
    static{
        InputStream inputStream = SysUtil.class.getClassLoader().getResourceAsStream("sys.properties");

        properties = new Properties();
        try {
            properties.load(inputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if(inputStream!=null){
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    public static String getValue(String key){
        return properties.getProperty(key);
    }
}
