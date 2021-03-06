package org.onlineSubmit.dao;

import java.util.List;
import java.util.Map;

import org.onlineSubmit.entity.Distribute;
import org.onlineSubmit.entity.Editor;
import org.onlineSubmit.entity.Expert;
import org.onlineSubmit.entity.ExpertReview;
import org.onlineSubmit.entity.Manuscript;
import org.onlineSubmit.entity.Nav;
import org.onlineSubmit.entity.User;
import org.springframework.stereotype.Repository;
@Repository
public interface EditorDao {
	public Editor findEditorByUserName(String username);
	public List<Manuscript> findManuscriptList(Map<String,Object> queryMap);
	public int getTotalByEditor(Map<String,Object> queryMap);
	public Editor queryOwnInfoByEditor();
	public int editOwnInfoByEditor(Editor editor);
	public List<User> findUserList(Map<String,Object> queryMap);
	public int getUserTotalByEditor(Map<String,Object> queryMap);
	public int editUserInfo(User user);
	public int deleteUserInfo(String ids);
	public Expert queryExpertInfo();
	public int editExpertInfo(Expert expert);
	public int deleteExpertInfo(String ids);
	public List<Nav> findNavList(Map<String,Object> queryMap);
	public int getNavTotalByEditor(Map<String,Object> queryMap);
	public Nav findByNavName(String nav_name);
	public int addNavInfo(Nav nav);
	public int deleteNavInfo(String ids);
	public int editNavInfo(Nav nav);
	public List<Manuscript> findManuscriptListByNavId(String ids);
	public int addDistributeInfo(Distribute distribute);
	public int updateManuscriptReMarks(Map<String,Object> map);
	public List<ExpertReview> queryExpertReviewList(); 
	public List<Manuscript> findManuscriptListByEditorReview(Map<String,Object> queryMap);
	public int getManuscriptTotalByEditor(Map<String,Object> queryMap);
	public int addEditorReviewInfo(Map<String,Object> updateMap);
	public List<Manuscript> findManuscriptListNodDistribute(Map<String,Object> queryMap);
	public int getTotalByEditorNodDistribute(Map<String,Object> queryMap);
	public int add(Editor editor);
	public List<Editor> findEditorList(Map<String,Object> queryMap);
	public int deleteEditorInfo(String ids);
	public int switchUserInfo(User user);
	public List<User> findUserListByAdmin(Map<String,Object> queryMap);
	public List<User> findExpertList(Map<String,Object> queryMap);
	public List<ExpertReview> findExpertReviewList(Map<String,Object> queryMap);
	public int getExpertReviewTotal(Map<String,Object> queryMap);
	public List<User> findSwitchUserListByAdmin(Map<String,Object> queryMap);
}
