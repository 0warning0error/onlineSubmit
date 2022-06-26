package org.onlineSubmit.entity;

import org.springframework.stereotype.Component;

/**
 * 系统管理员实体类
 * @author 11728
 * @date 2021-03-16 17:02
 */
@Component
public class Administrator {
	
	/**
	 * 管理员id
	 */
	private int administrator_id;
	
	/**
	 * 管理员姓名
	 */
	private String administrator_name;

	/**
	 * 用户名
	 */
	private String username;
	
	/**
	 * 密码
	 */
	private String password;
	
	/**
	 * 性别 1男 2女
	 */
	private String sex;

	public int getAdministrator_id() {
		return administrator_id;
	}

	public void setAdministrator_id(int administrator_id) {
		this.administrator_id = administrator_id;
	}

	public String getAdministrator_name() {
		return administrator_name;
	}

	public void setAdministrator_name(String administrator_name) {
		this.administrator_name = administrator_name;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

}
