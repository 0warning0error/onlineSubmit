package org.onlineSubmit.entity;

import org.springframework.stereotype.Component;

@Component
public class Distribute {
	private int distribute;
	private int distribute_num;
	private String distribute_idstring;
	private int distribute_expert_id;//分配id
	public int getDistribute() {
		return distribute;
	}
	public int getDistribute_expert_id() {
		return distribute_expert_id;
	}
	public void setDistribute_expert_id(int distribute_expert_id) {
		this.distribute_expert_id = distribute_expert_id;
	}
	public void setDistribute(int distribute) {
		this.distribute = distribute;
	}
	public int getDistribute_num() {
		return distribute_num;
	}
	public void setDistribute_num(int distribute_num) {
		this.distribute_num = distribute_num;
	}
	public String getDistribute_idstring() {
		return distribute_idstring;
	}
	public void setDistribute_idstring(String distribute_idstring) {
		this.distribute_idstring = distribute_idstring;
	}
	
}
