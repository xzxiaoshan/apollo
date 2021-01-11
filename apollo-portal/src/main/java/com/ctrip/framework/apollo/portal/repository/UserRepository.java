package com.ctrip.framework.apollo.portal.repository;

import com.ctrip.framework.apollo.portal.entity.po.UserPO;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * @author lepdou 2017-04-08
 */
public interface UserRepository extends PagingAndSortingRepository<UserPO, Long> {

  List<UserPO> findFirst20ByEnabled(int enabled);

  List<UserPO> findByUsernameLikeAndEnabled(String username, int enabled);

  UserPO findByUsername(String username);

  List<UserPO> findByUsernameIn(List<String> userNames);

  @Modifying
  @Query("UPDATE UserPO SET password= ?2 ,email = ?3 WHERE username=?1")
  int update(String username, String password, String email);

}
