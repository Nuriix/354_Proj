package com.jtspringproject.JtSpringProject.services;

import com.jtspringproject.JtSpringProject.models.*;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jtspringproject.JtSpringProject.dao.userDao;
import com.jtspringproject.JtSpringProject.models.User;

@Service
public class userService {
	@Autowired
	private userDao userDao;
	
	public List<User> getUsers(){
		return this.userDao.getAllUser();
	}

	public User getUser(int id) {return this.userDao.getUser(id);}
	
	public User addUser(User user) {
		return this.userDao.saveUser(user);
	}

	public User updateUser(int id , User user) {
		user.setId(id);
		return this.userDao.updateUser(user);
	}

	public Boolean deleteUser(int id) { return this.userDao.deleteUser(id);}
	
	public User checkLogin(String username,String password) {
		return this.userDao.getUser(username, password);
	}
}
