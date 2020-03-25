package controller;

import domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import service.UserService;
import util.Constant;
import util.JsonModel;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class HomeController {
    @RequestMapping(value="login",method={RequestMethod.GET})
    public String loginUI(){
        return "login";
    }

    @RequestMapping(value = "main",method = {RequestMethod.GET})
    public String main(){
        return "main";
    }

    @Autowired
    UserService userService;

    @RequestMapping(value="login",method = RequestMethod.POST)
    @ResponseBody
    public JsonModel login(String loginName, String password, int remember, HttpSession session, HttpServletResponse response){
        JsonModel jsonModel = new JsonModel();
        User user = userService.login(loginName,password);
        if(user == null){
            jsonModel.setResult(false);
            jsonModel.setMsg("账号或密码错误");
        }else{
            jsonModel.setResult(true);
            jsonModel.setMsg("登录成功");//{result:true,"msg":"登录成功","count":null,data:null}
            session.setAttribute(Constant.SESSION_KEY,user);
            if(remember == 1){
                Cookie loginNamecookie = new Cookie("loginName",loginName);
                response.addCookie(loginNamecookie);
                Cookie passwordcookie = new Cookie("password",password);
                response.addCookie(passwordcookie);
            }
        }
        return jsonModel;
    }

}
