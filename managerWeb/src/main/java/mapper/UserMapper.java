package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import domain.User;
import query.UserQuery;

@Repository
public interface UserMapper {
	List<User> findAll();

    User login(@Param("loginName") String loginName, @Param("password") String password);

    List<User> findByQuery(UserQuery userQuery);

    int deleteByIds(String[] idArray);

    int add(User user);

    User findById(int id);

    int update(User temp);
}
