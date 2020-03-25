package service;

import java.util.List;

import com.neu.movie.exception.BusinessException;
import com.neu.movie.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import domain.User;
import mapper.UserMapper;
import query.UserQuery;
import util.Constant;
import util.SysUtil;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	@Qualifier("userMapper")
	UserMapper userMapper;
	
	@Override
	public List<User> findAll() {
		return userMapper.findAll();
	}

	@Override
	public User login(String loginName, String password) {
		password = MD5Util.digest(password);
		return userMapper.login(loginName,password);
	}

	@Override
	public List<User> findByQuery(UserQuery userQuery) {
		userQuery.setOffset((userQuery.getPage()-1)*userQuery.getPageSize());
		return userMapper.findByQuery(userQuery);
	}

    @Override
    public boolean deleteByIds(String[] idArray) {
        int count = userMapper.deleteByIds(idArray);
        if(count!=idArray.length){
            throw new BusinessException("删除失败");
        }
        return true;
    }

	@Override
	public boolean add(User user) {
		user.setPassword(MD5Util.digest(SysUtil.getValue("password")));
		user.setStatus(Constant.STATUS_USER_UNACTIVE);
		return userMapper.add(user)==1;
	}

	@Override
	public User findById(int id) {
		return userMapper.findById(id);
	}

	@Override
	public boolean update(User temp) {
		return userMapper.update(temp)==1;
	}

}
