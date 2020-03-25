package controller;

import java.util.List;

import com.neu.movie.exception.ParamException;
import com.neu.movie.utils.StringUtil;
import org.apache.ibatis.builder.ParameterExpression;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.User;
import query.UserQuery;
import service.UserService;
import util.Constant;
import util.JsonModel;

@Controller
@RequestMapping("users")
public class UserController {
	
	@Autowired
	UserService userService;

	@RequestMapping(value = "findAll",method = {RequestMethod.GET})
	@ResponseBody
	public List<User> findAll(){
		return userService.findAll();
	}

	@RequestMapping(value = "",method = RequestMethod.GET)
	public String list(){
		return "user/list";
	}

	@RequestMapping(value = "",method = RequestMethod.GET,headers = {"X-Requested-With=XMLHttpRequest"})
	@ResponseBody
	public JsonModel list(UserQuery userQuery){
		JsonModel jsonModel = new JsonModel();
		List<User> userList = userService.findByQuery(userQuery);
		jsonModel.setResult(true);
		jsonModel.setCount(userList.size());
		jsonModel.setMsg("查询成功");
		jsonModel.setData(userList);
		return jsonModel;
	}

	@RequestMapping(value = "{ids}",method = RequestMethod.DELETE,headers = {"X-Requested-With=XMLHttpRequest"})
	@ResponseBody
	public JsonModel delete(@PathVariable("ids") String ids){
		JsonModel jsonModel = new JsonModel();
		//判断是否为空
		if(StringUtil.isEmpty(ids)){
            new ParamException("删除用户参数错误");
        }
        /*1,2,3->"1","2","3"*/
		String[] idArray = ids.split(",");
        userService.deleteByIds(idArray);
        jsonModel.setResult(true);
        jsonModel.setMsg("删除成功");
		return jsonModel;
	}
	//转发到添加界面
	@RequestMapping(value = "addUI",method = RequestMethod.GET)
	public String addUI(){
		return "user/add";
	}

	//处理添加信息并重定向到列表界面
	@RequestMapping(method=RequestMethod.POST)
	public String add(@Validated User user, Errors errors){

	    if(errors.hasErrors()){
	        return "user/add";
        }
	    boolean result = userService.add(user);

		return "redirect:/users";
	}
	//http://localhost:9090/users/1/edit
	@RequestMapping(value="{id}/edit",method = {RequestMethod.GET})
	public String editUI(@PathVariable int id, Model model){
		User user = userService.findById(id);
		if(user == null){
			throw new ParamException("编辑用户参数错误");
		}
		model.addAttribute(Constant.SESSION_KEY,user);
		return "user/edit";
	}

	@RequestMapping(value = "{id}",method = RequestMethod.PUT)
	public String edit(User user){
		User temp = new User();
		temp.setId(user.getId());
		temp.setName(user.getName());
		temp.setHeader(user.getHeader());
		boolean result = userService.update(temp);
		return "redirect:/users";
	}
}
