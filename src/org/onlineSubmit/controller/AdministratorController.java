package org.onlineSubmit.controller;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.onlineSubmit.dao.UserDao;
import org.onlineSubmit.entity.Administrator;
import org.onlineSubmit.entity.Editor;
import org.onlineSubmit.entity.Expert;
import org.onlineSubmit.entity.Manuscript;
import org.onlineSubmit.entity.Nav;
import org.onlineSubmit.entity.User;
import org.onlineSubmit.page.Page;
import org.onlineSubmit.service.AuthorService;
import org.onlineSubmit.service.EditorService;
import org.onlineSubmit.service.ExpertService;
import org.onlineSubmit.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
/**
 * 以管理员身份登录系统
 * @author Administrator
 *
 */
@RequestMapping("/administrator")
@Controller
public class AdministratorController {
	@Autowired
	private UserService userService;
	@Autowired
	private EditorService editorService;
	@Autowired
	private AuthorService authorService;
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public ModelAndView index(ModelAndView model,HttpServletRequest request) {
		int id = (Integer) request.getSession().getAttribute("id");
		User user = authorService.queryOwnInfo(id);
		model.addObject("user",user);
		model.setViewName("administrator/index");
		return model;
	}
	
	
	/**
	 * 管理员身份跳转到用户列表页面
	 */
	@RequestMapping(value="/queryUserInfo",method=RequestMethod.GET)
	public ModelAndView queryUserInfo(ModelAndView model) {
		model.setViewName("administrator/queryUserInfo");
		return model;
	}
	/**
	 * 显示用户信息列表
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/getUserInfoByEditor",method=RequestMethod.POST)
	@ResponseBody
		public Map<String,Object> getList(Page page,@RequestParam(value="username",required=true,defaultValue="") String username){
		Map<String,Object> ret = new HashMap<String,Object>();
		Map<String,Object> queryMap = new HashMap<String,Object>();
			queryMap.put("username","%"+username+"%");
			page.setOffset();
			queryMap.put("offset",page.getOffset());
			queryMap.put("pageSize",page.getRows());
			List<User> list = editorService.findUserListByAdmin(queryMap);
			for(User user : list) {
				if(user.getUser_type() == 1) {
					user.setUser_type_value("作者");
				}
				if(user.getUser_type() == 2) {
					user.setUser_type_value("专家");
				}
				if(user.getUser_type() == 3) {
					user.setUser_type_value("编辑");
				}
				if(user.getUser_type() == 4) {
					user.setUser_type_value("管理员");
				}
			}
			ret.put("rows",list);
			ret.put("total",editorService.getUserTotalByEditor(queryMap));
			return ret;
		}
	
	/**
	 * 修改用户信息
	 */
	@RequestMapping(value="/editUserInfoByEditor",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> editUserInfoByEditor(User user){
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
		if(editorService.editUserInfo(user) <= 0) {
			ret.put("type","error");
			ret.put("msg","修改失败！");
			return ret;
		}
		ret.put("type","success");
		ret.put("msg","修改成功！");
		return ret;
	}
	/**
	 * 添加用户信息
	 */
	@RequestMapping(value="/addUserInfo",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> addUserInfo(User user){
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
		if(userService.addByAdmin(user) <= 0) {
			ret.put("type","error");
			ret.put("msg","添加失败！");
			return ret;
		}
		ret.put("type","success");
		ret.put("msg","登录成功！");
		return ret;
	}
	/**
	 * 批量删除用户操作
	 */
	@RequestMapping(value="/deleteUserInfo",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> delete(
			@RequestParam(value="ids[]",required=true) Long[] ids
		){
		Map<String, String> ret = new HashMap<String, String>();
		if(ids == null){
			ret.put("type", "error");
			ret.put("msg", "请选择要删除的数据!");
			return ret;
		}
		String idsString = "";
		for(Long id:ids){
			idsString += id + ",";
		}
		idsString = idsString.substring(0,idsString.length()-1);
		if(editorService.deleteUserInfo(idsString) <= 0){
			ret.put("type", "error");
			ret.put("msg", "删除失败!");
			return ret;
		}
		ret.put("type", "success");
		ret.put("msg", "修改成功!");
		return ret;
	}
	
	/**
	 * 管理员身份跳转到用户切换列表页面
	 */
	@RequestMapping(value="/switchJurisdiction",method=RequestMethod.GET)
	public ModelAndView switchJurisdiction(ModelAndView model) {
		model.setViewName("administrator/switchJurisdiction");
		return model;
	}
	
	/**
	 * 显示用户信息列表
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/getUserInfoByAdmin",method=RequestMethod.POST)
	@ResponseBody
		public Map<String,Object> getUserList(Page page,@RequestParam(value="username",required=true,defaultValue="") String username){
		Map<String,Object> ret = new HashMap<String,Object>();
		Map<String,Object> queryMap = new HashMap<String,Object>();
			queryMap.put("username","%"+username+"%");
			page.setOffset();
			queryMap.put("offset",page.getOffset());
			queryMap.put("pageSize",page.getRows());
			List<User> list = editorService.findSwitchUserListByAdmin(queryMap);
			for(User user : list) {
				if(user.getUser_type() == 1) {
					user.setUser_type_value("作者");
				}
				if(user.getUser_type() == 2) {
					user.setUser_type_value("专家");
				}
				if(user.getUser_type() == 3) {
					user.setUser_type_value("编辑");
				}
			}
			ret.put("rows",list);
			ret.put("total",editorService.getUserTotalByEditor(queryMap));
			return ret;
		}
	
	/**
	 * 切换用户权限
	 */
	@RequestMapping(value="/switchUserPower",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> switchUserPower(User user){
		Map<String,String> ret = new HashMap<String,String>();
		if(editorService.switchUserInfo(user) <= 0) {
			ret.put("type","error");
			ret.put("msg","切换失败！");
			return ret;
		}
		ret.put("type","success");
		ret.put("msg","切换成功！");
		return ret;
	}
	
}
