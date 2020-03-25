package service;

import java.util.List;

import domain.User;
import query.UserQuery;

public interface UserService {
	List<User> findAll();

	User login(String loginName, String password);

    List<User> findByQuery(UserQuery userQuery);

	boolean deleteByIds(String[] idArray);

    boolean add(User user);

    User findById(int id);

    boolean update(User temp);
}
