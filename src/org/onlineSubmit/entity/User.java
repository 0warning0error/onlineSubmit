package org.onlineSubmit.entity;
import org.springframework.stereotype.Component;
/**
 * ������@Component��@Service��@Repositoryע�ⶼ�Ὣ�������spring������
 * @author Administrator
 */
@Component
public class User {
	private int id;
	private String username;
	private String password;
	private String name;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	private String sex;
	public int getUser_type() {
		return user_type;
	}
	public void setUser_type(int user_type) {
		this.user_type = user_type;
	}
	private String phone_number;
	private String address;
	/**
	 * 用户类型
	 * 1 作者
	 * 2 专家
	 * 3 编辑
	 * 4 管理员
	 */
	private int user_type;
	
	/**
	 * 用户类型描述
	 */
	private String user_type_value;
	
	public String getUser_type_value() {
		return user_type_value;
	}
	public void setUser_type_value(String user_type_value) {
		this.user_type_value = user_type_value;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getPhone_number() {
		return phone_number;
	}
	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}
