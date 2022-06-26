package org.onlineSubmit.controller;

import java.io.IOException;
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
import org.onlineSubmit.entity.Distribute;
import org.onlineSubmit.entity.Editor;
import org.onlineSubmit.entity.Expert;
import org.onlineSubmit.entity.ExpertReview;
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
import org.springframework.web.servlet.ModelAndView;
@RequestMapping("/editor")
@Controller
public class EditorController {
	@Autowired
	private EditorService editorService;
	@Autowired
	private UserService userService;
	@Autowired
	private ExpertService expertService;
	@Autowired
	private AuthorService authorService;
	/**
	/**
	 * 编辑登录进入系统主页
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public ModelAndView index(ModelAndView model,HttpServletRequest request) {
		int id = (Integer) request.getSession().getAttribute("id");
		User user = authorService.queryOwnInfo(id);
		model.addObject("user",user);
		model.setViewName("editor/index");
		return model;
	}
	/**
	 * 编辑进入查询页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/queryManuscript",method=RequestMethod.GET)
	public ModelAndView queryManuscriptByEditor(ModelAndView model) {
		model.setViewName("editor/queryManuscript");
		return model;
	}
	/**
	 * 显示稿件数据列表
	 * @param manuscript
	 * @param manuscript_file
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value="/get_list_by_editor",method=RequestMethod.POST)
	@ResponseBody
		public Map<String,Object> getList(
				@RequestParam(value="state",required=true,defaultValue="") String state,
				Page page,
				HttpServletRequest request,HttpServletResponse response
				){
		Map<String,Object> ret = new HashMap<String,Object>();
		Map<String,Object> queryMap = new HashMap<String,Object>();
		Map<String,Object> ids = new HashMap<String,Object>();
			if(state.equals("显示所有稿件")) {
				state = "";
			}
			if(state.equals("已退回(编辑复审)")) {
				state = "已退回";
			}
			queryMap.put("state","%"+state+"%");
			page.setOffset();
			queryMap.put("offset",page.getOffset());
			queryMap.put("pageSize",page.getRows());
			List<Manuscript> list = editorService.findManuscriptList(queryMap);
			ret.put("rows",list);
			ret.put("total",editorService.getTotalByEditor(queryMap));
			return ret;
		}
	/**
	 * 个人信息列表
	 */
	@RequestMapping(value="/queryOwnInfo",method=RequestMethod.GET)
	public ModelAndView editOwnInfo(ModelAndView model) {
		model.setViewName("editor/queryOwnInfo");
		return model;
	}
	/**
	 * 处理编辑个人信息列表请求
	 * 
	 */
	@RequestMapping(value="/getOwnInfoByEditor",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> getOwnInfo(
			HttpServletRequest request,HttpServletResponse response
			){
	Map<String,Object> ret = new HashMap<String,Object>();
		int id = (Integer) request.getSession().getAttribute("id");
		User user = authorService.queryOwnInfo(id);
		List<User> list = new ArrayList();
		list.add(user);
		ret.put("rows",list);
		ret.put("total",1);
		return ret;
	}
	/**
	 * 修改个人信息
	 * 
	 */
	@RequestMapping(value="/editOwnInfoByEditor",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> register(User user){
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
		if(authorService.editOwnInfo(user) <= 0) {
			ret.put("type","error");
			ret.put("msg","修改失败！");
			return ret;
		}
		ret.put("type","success");
		ret.put("msg","修改成功！");
		return ret;
	}
	/**
	 * 跳转到用户列表页面
	 */
	@RequestMapping(value="/queryUserInfo",method=RequestMethod.GET)
	public ModelAndView queryUserInfo(ModelAndView model) {
		model.setViewName("editor/queryUserInfo");
		return model;
	}
	/**
	 * 显示用户列表
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
			List<User> list = editorService.findUserList(queryMap);
			ret.put("rows",list);
			ret.put("total",editorService.getUserTotalByEditor(queryMap));
			return ret;
		}

	
	/**
	 * 跳转到专家信息列表页面
	 */
	@RequestMapping(value="/queryExpertInfo",method=RequestMethod.GET)
	public ModelAndView queryExpertInfo(ModelAndView model) {
		model.setViewName("editor/queryExpertInfo");
		return model;
	}
	/**
	 * 显示专家信息列表
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/getExpertInfoByEditor",method=RequestMethod.POST)
	@ResponseBody
		public Map<String,Object> getExpertListByAdmin(Page page,@RequestParam(value="username",required=true,defaultValue="") String username){
		Map<String,Object> ret = new HashMap<String,Object>();
		Map<String,Object> queryMap = new HashMap<String,Object>();
			queryMap.put("username","%"+username+"%");
			page.setOffset();
			queryMap.put("offset",page.getOffset());
			queryMap.put("pageSize",page.getRows());
			List<User> list = editorService.findExpertList(queryMap);
			ret.put("rows",list);
			ret.put("total",editorService.getUserTotalByEditor(queryMap));
			return ret;
		}
	/**
	 * 修改专家信息
	 * @param user
	 * @return
	 */

	/**
	 * 跳转到类别信息列表页
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/queryNavInfo",method=RequestMethod.GET)
	public ModelAndView queryNavInfo(ModelAndView model) {
		model.setViewName("editor/queryNavInfo");
		return model;
	}
	/**
	 * 显示类别信息列表
	 * @param page
	 * @param username
	 * @return
	 */
	@RequestMapping(value="/getNavInfoByEditor",method=RequestMethod.POST)
	@ResponseBody
		public Map<String,Object> getNavList(Page page){
		Map<String,Object> ret = new HashMap<String,Object>();
		Map<String,Object> queryMap = new HashMap<String,Object>();
			page.setOffset();
			queryMap.put("offset",page.getOffset());
			queryMap.put("pageSize",page.getRows());
			List<Nav> list = editorService.findNavList(queryMap);
			ret.put("rows",list);
			ret.put("total",editorService.getNavTotalByEditor(queryMap));
			return ret;
		}
	/**
	 * 添加用户信息
	 * 
	 */
	@RequestMapping(value="/addNavInfo",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> addNavInfo(Nav nav){
		Map<String,String> ret = new HashMap<String,String>();
		if(StringUtils.isEmpty(nav.getNav_name())) {
			ret.put("type","error");
			ret.put("msg","类别名称不能为空！");
			return ret;
		}
		String nav_name = nav.getNav_name();
		Nav existNavName = editorService.findByNavName(nav_name);
		if(existNavName != null) {
			ret.put("type","error");
			ret.put("msg","类别名称已存在！");
			return ret;
		}
		if(editorService.addNavInfo(nav) <= 0) {
			ret.put("type","error");
			ret.put("msg","添加失败！");
			return ret;
		}
		ret.put("type","success");
		ret.put("msg","添加成功！");
		return ret;
	}
	/**
	 * 删除类别信息
	 */
	@RequestMapping(value="/deleteNavInfo",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> deleteNavInfoByEditor(
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
		List<Manuscript> list = editorService.findManuscriptListByNavId(idsString);
		if(list.size() >= 1) {
			ret.put("type", "error");
			ret.put("msg", "该类别含有稿件，请谨慎操作!");
			return ret;
		}
		if(editorService.deleteNavInfo(idsString) <= 0){
			ret.put("type", "error");
			ret.put("msg", "删除失败!");
			return ret;
		}
		ret.put("type", "success");
		ret.put("msg", "删除成功!");
		return ret;
	}

	/**
	 * 跳转到稿件分配信息列表页
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/distributeManuscript",method=RequestMethod.GET)
	public ModelAndView distributeManuscript(ModelAndView model) {
		model.setViewName("editor/distributeManuscript");
		return model;
	}
	/**
	 * 处理编辑稿件尚未分配列表页请求
	 * @param state
	 * @param page
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/get_list_by_NoDistribute",method=RequestMethod.POST)
	@ResponseBody
		public Map<String,Object> get_list_by_NoDistribute(
				Page page,
				HttpServletRequest request,HttpServletResponse response
				){
		Map<String,Object> ret = new HashMap<String,Object>();
		Map<String,Object> queryMap = new HashMap<String,Object>();
			page.setOffset();
			queryMap.put("offset",page.getOffset());
			queryMap.put("pageSize",page.getRows());
			queryMap.put("state","待审核");
			List<Manuscript> list = editorService.findManuscriptListNodDistribute(queryMap);
			ret.put("rows",list);
			ret.put("total",editorService.getTotalByEditorNodDistribute(queryMap));
			return ret;
		}
	/**
	 * 在线分配稿件
	 */
	@RequestMapping(value="/distributeManuscript",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> distributeManuscript(
			@RequestParam(value="ids[]",required=true) Long[] ids,
			@RequestParam(value="id",required=true) Long expert_id,
			Distribute distribute,
			HttpServletRequest request,HttpServletResponse response
		){
		Map<String, Object> ret = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		if(ids == null){
			ret.put("type", "error");
			ret.put("msg", "请选择要分配的记录!");
			return ret;
		}
		String idsString = "";
		for(Long id:ids){
			idsString += id + ",";
		}
		idsString = idsString.substring(0,idsString.length()-1);
		map.put("remarks","已分配");
		map.put("ids",idsString);
		//List<Manuscript> list = editorService.findManuscriptList(map);
		if(editorService.updateManuscriptReMarks(map) <= 0)
		{
			ret.put("type", "error");
			ret.put("msg", "备注失败!");
			return ret;
		}
		//设置分配记录
		distribute.setDistribute_idstring(idsString);
		distribute.setDistribute_num(ids.length);
		distribute.setDistribute_expert_id(expert_id.intValue());
		if(editorService.addDistributeInfo(distribute) <= 0)
		{
			ret.put("type", "error");
			ret.put("msg", "稿件分配失败!");
			return ret;
		}
		ret.put("type", "success");
		ret.put("msg", "分配成功!");
		return ret;
	}
	/**
	 * 跳转到编辑复审列表页
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/doubleReviewManuscript",method=RequestMethod.GET)
	public ModelAndView doubleReviewManuscript(ModelAndView model) {
		model.setViewName("editor/doubleReviewManuscript");
		return model;
	}
	
	/**
	 * 显示用户信息列表
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/get_list_expert",method=RequestMethod.POST)
	@ResponseBody
		public Map<String,Object>  getExpertList(Page page,@RequestParam(value="username",required=true,defaultValue="") String username){
		Map<String,Object> ret = new HashMap<String,Object>();
		Map<String,Object> queryMap = new HashMap<String,Object>();
			queryMap.put("username","%"+username+"%");
			page.setOffset();
			queryMap.put("offset",page.getOffset());
			queryMap.put("pageSize",page.getRows());
			List<User> list = editorService.findExpertList(queryMap);
			ret.put("rows",list);
			ret.put("total",editorService.getUserTotalByEditor(queryMap));
			return ret;
		}
	
	/**
	 * 处理编辑稿件复审列表请求
	 * @param author_name
	 * @param title
	 * @param page
	 * @param request
	 * @param response
	 * 条件：
	 * 1.专家已审核过
	 * 2.稿件状态为已通过
	 * @return
	 */
	@RequestMapping(value="/get_list_by_editorDoubleReview",method=RequestMethod.POST)
	@ResponseBody
		public Map<String,Object> getDoubleReviewList(
				Page page,
				HttpServletRequest request,HttpServletResponse response
				){
		Map<String,Object> ret = new HashMap<String,Object>();
		Map<String,Object> queryMap = new HashMap<String,Object>();
			page.setOffset();
			queryMap.put("offset",page.getOffset());
			queryMap.put("pageSize",page.getRows());
			//找到专家已经审核过的稿件列表
			List<ExpertReview> ExpertReviewList = editorService.queryExpertReviewList();
			String manuscript_ids = "";
			for(ExpertReview expertReview : ExpertReviewList) {
				manuscript_ids += expertReview.getManuscript_id()+",";
			}
			manuscript_ids = manuscript_ids.substring(0,manuscript_ids.length()-1);
			queryMap.put("manuscript_ids",manuscript_ids);
			queryMap.put("state","已通过");
			List<Manuscript> arraylist = editorService.findManuscriptListByEditorReview(queryMap);
			ret.put("rows",arraylist);
			ret.put("total",editorService.getManuscriptTotalByEditor(queryMap));
			return ret;
		}
	//编辑复审
	@RequestMapping(value="/doubleReview",method=RequestMethod.GET)
	public void review(HttpServletRequest request,HttpServletResponse response,String flag,int manuscript_id, String opinion) {
		Map<String,Object> updateMap = new HashMap<String,Object>();
		updateMap.put("manuscript_id",manuscript_id);
		if(flag.equals("true")) {
			updateMap.put("state","已发布");
		}
		if(flag.equals("false")) {
			updateMap.put("state","已退回");
		}
		if(expertService.editManuscriptByManuscript(updateMap) >= 0) {
			System.out.print("更新成功");
		}
		int editor_id = (Integer) request.getSession().getAttribute("id");
		updateMap.put("editor_id",editor_id);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String format = sf.format(new Date());
		updateMap.put("editor_review_time",format);
		updateMap.put("editor_opinion", updateMap.get("state"));
		updateMap.put("editor_opinion_value",opinion);
		if(editorService.addEditorReviewInfo(updateMap) >=0 ) {
			System.out.println("插入数据成功！");
			try {
				response.sendRedirect("doubleReviewManuscript");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 跳转到专家审稿记录页面
	 */
	@RequestMapping(value="/queryExpertReviewRecord",method=RequestMethod.GET)
	public ModelAndView queryExpertReviewRecord(ModelAndView model) {
		model.setViewName("editor/queryExpertReviewRecord");
		return model;
	}
	
	/**
	 * 显示专家审稿记录列表
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/get_expert_review_record_list",method=RequestMethod.POST)
	@ResponseBody
		public Map<String,Object>  get_expert_review_record_list(Page page){
		Map<String,Object> ret = new HashMap<String,Object>();
		Map<String,Object> queryMap = new HashMap<String,Object>();
			page.setOffset();
			queryMap.put("offset",page.getOffset());
			queryMap.put("pageSize",page.getRows());
			List<ExpertReview> list = editorService.findExpertReviewList(queryMap);
			ret.put("rows",list);
			ret.put("total",editorService.getExpertReviewTotal(queryMap));
			return ret;
		}
	
	
}
