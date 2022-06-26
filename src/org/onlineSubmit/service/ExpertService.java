package org.onlineSubmit.service;

import java.util.List;
import java.util.Map;

import org.onlineSubmit.entity.Distribute;
import org.onlineSubmit.entity.Expert;
import org.onlineSubmit.entity.Manuscript;
import org.onlineSubmit.entity.User;
import org.springframework.stereotype.Service;

@Service
public interface ExpertService {
	public Expert findExpertByUserName(String username);
	public int add(Expert expert);
	public List<Distribute> findDistributeList(int id);
	public List<Manuscript> findManuscriptListByExpert(Map<String,Object> queryMap);
	public int getManuscriptTotalByExpert(Map<String,Object> queryMap);
	public int editManuscriptByManuscript(Map<String,Object> updateMap);
	public int addExpertReviewInfo(Map<String,Object> updateMap);
	public Expert queryOwnInfoByExpert(int expert_id);
	public int editOwnInfoByExpert(Expert expert);
	public List<Manuscript> findManuscriptNoReviewListByExpert(Map<String,Object> queryMap);
	public int getManuscriptTotalNoReviewByExpert(Map<String,Object> queryMap);
	public int getExpertTotal(Map<String,Object> queryMap);
	public List<Expert> findExpertList(Map<String,Object> queryMap);
}
