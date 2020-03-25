package domain;

import group.AddGroup;
import group.EditGroup;
import org.hibernate.validator.constraints.NotBlank;

public class User {
	private int id;
	@NotBlank(groups = {AddGroup.class, EditGroup.class},message = "{user.name}")
	private String name;
	private String loginName;
	private String password;
	private Byte status;//0:未激活 1：已激活 2：已删除
	private String header;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Byte getStatus() {
		return status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}
}
