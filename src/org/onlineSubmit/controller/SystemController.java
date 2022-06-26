package org.onlineSubmit.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.onlineSubmit.entity.Administrator;
import org.onlineSubmit.entity.Editor;
import org.onlineSubmit.entity.Expert;
import org.onlineSubmit.entity.User;
import org.onlineSubmit.service.EditorService;
import org.onlineSubmit.service.ExpertService;
import org.onlineSubmit.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/system")
@Controller
public class SystemController {
	@Autowired
	private UserService userService;
	/**
	 * 进入到登录界面
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String index() {
		return "login";
	}
	/**
	 * 进入系统主界面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public ModelAndView index(ModelAndView model) {
		model.setViewName("hello world");
		return model;
	}
	/**
	 * 跳转到注册界面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/register",method=RequestMethod.GET)
	public ModelAndView register(ModelAndView model) {
		model.setViewName("register");
		return model;
	}
	/**
	 * 登录验证
	 * 
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> login(
			@RequestParam(value="username",required=true) String username,
			@RequestParam(value="password",required=true) String password,
			@RequestParam(value="type",required=true) int type,
			HttpServletRequest request,HttpServletResponse response
	){
		response.setContentType("application/json;charset=UTF-8");
		Map<String,String> ret = new HashMap<String,String>();
		User user = userService.findByUserName(username);
		System.out.println("用户类型是"+user.getUser_type());
		if(user == null) {
			ret.put("type","error");
			ret.put("msg","用户不存在！");

			return ret;
		}
		if(StringUtils.isEmpty(username)) {
			ret.put("type","error");
			ret.put("msg","用户名不能为空！");
			return ret;
		}
		if(StringUtils.isEmpty(password)) {
			ret.put("type","error");
			ret.put("msg","密码不能为空！");
			return ret;
		}
		
		//作者登录
		if(type==2) {
			//判断用户类型是否是作者 1
			if(user.getUser_type() != 1) {
				ret.put("type","error");
				ret.put("msg","用户类型不是作者，请重新输入！");
				return ret;
			}
		}
		//专家登录
		if(type==3) {
			if(user.getUser_type() != 2) {
				ret.put("type","error");
				ret.put("msg","用户类型不是专家，请重新输入！");
				return ret;
			}
		}
		//编辑登录
		if(type==1) {
			if(user.getUser_type() != 3) {
				ret.put("type","error");
				ret.put("msg","用户类型不是编辑，请重新输入！");
				return ret;
			}
		}
		//管理员登录
		if(type==4) {
			if(user.getUser_type() != 4) {
				ret.put("type","error");
				ret.put("msg","用户类型不是管理员，请重新输入！");
				return ret;
			}
		}		
		//通过用户名查找到该用户
		if(user==null) {
			ret.put("type","error");
			ret.put("msg","用户名不存在！");
			return ret;
		}
		if(!(user.getPassword().equals(password))) {
			ret.put("type","error");
			ret.put("msg","密码错误！");
			return ret;
		}
		//如果登录成功保存用户信息
		request.getSession().setAttribute("id",user.getId());
		request.getSession().setAttribute("username",user.getUsername());
		request.getSession().setAttribute("author_name",user.getName());
		request.getSession().setAttribute("user",user);
		
		request.getSession().setAttribute("type",type);
		ret.put("type","success");
		ret.put("msg","登录成功！");
		return ret;
	}
	
	/**
	 * 用户注册
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping(value="/register",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> register(User user,
			@RequestParam(value="contain_password",required=true) String contain_password){
		Map<String,String> ret = new HashMap<String,String>();

		if(StringUtils.isEmpty(user.getUsername())) {
			ret.put("type","error");
			ret.put("msg","用户名不能为空！");
			return ret;
		}
		if(StringUtils.isEmpty(user.getPassword())) {
			ret.put("type","error");
			ret.put("msg","密码不能为空！");
			return ret;
		}
		if(StringUtils.isEmpty(contain_password)) {
			ret.put("type","error");
			ret.put("msg","确认密码不能为空！");
			return ret;
		}
		if(!(user.getPassword().equals(contain_password))) {
			ret.put("type","error");
			ret.put("msg","确认密码与密码不一致！");
			return ret;
		}
		if(StringUtils.isEmpty(user.getName())) {
			ret.put("type","error");
			ret.put("msg","姓名不能为空！");
			return ret;
		}
		if(StringUtils.isEmpty(user.getPhone_number())) {
			ret.put("type","error");
			ret.put("msg","电话号码不能为空！");
			return ret;
		}
		if(user.getPhone_number().length()!=11) {
			ret.put("type","error");
			ret.put("msg","电话号码应为11位！");
			return ret;
		}
		/**
		 * 验证手机号码的正确性
		 */
		String regex = "^((13[0-9])|(14[5,7,9])|(15([0-3]|[5-9]))|(166)|(17[0,1,3,5,6,7,8])|(18[0-9])|(19[8|9]))\\d{8}$";
		Pattern p = Pattern.compile(regex);
        Matcher m = p.matcher(user.getPhone_number());
        boolean isMatch = m.matches();
        if (!isMatch) {
        	ret.put("type","error");
			ret.put("msg","请输入正确的手机号");
			return ret;
        }
		if(StringUtils.isEmpty(user.getAddress())) {
			ret.put("type","error");
			ret.put("msg","居住地址不能为空！");
			return ret;
		}
		User existUser = userService.findByUserName(user.getUsername());
		if(existUser != null) {
			ret.put("type","error");
			ret.put("msg","用户名已存在！");
			return ret;
		}
		if(userService.add(user) <= 0) {
			ret.put("type","error");
			ret.put("msg","注册失败！");
			return ret;
		}
		ret.put("type","success");
		ret.put("msg","注册成功！");
		return ret;
	}
}
