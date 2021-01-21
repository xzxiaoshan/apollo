package com.ctrip.framework.apollo.openapi.v1.controller;

import com.ctrip.framework.apollo.common.exception.BadRequestException;
import com.ctrip.framework.apollo.core.utils.StringUtils;
import com.ctrip.framework.apollo.portal.entity.po.UserPO;
import com.ctrip.framework.apollo.portal.service.RolePermissionService;
import com.ctrip.framework.apollo.portal.service.SystemRoleManagerService;
import com.ctrip.framework.apollo.portal.spi.UserInfoHolder;
import com.ctrip.framework.apollo.portal.spi.UserService;
import com.ctrip.framework.apollo.portal.spi.springsecurity.SpringSecurityUserService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashSet;

/**
 * @author panxs
 * @create 2021-01-11-19:27
 */
@RestController("openapiUserController")
@RequestMapping("/openapi/v1")
public class UserController {

    private final UserService userService;
    private final UserInfoHolder userInfoHolder;
    private final RolePermissionService rolePermissionService;


    public UserController(final UserService userService,
                          final UserInfoHolder userInfoHolder,
                          final RolePermissionService rolePermissionService) {
                          this.userService = userService;
                          this.userInfoHolder = userInfoHolder;
                          this.rolePermissionService = rolePermissionService;
    }

    @PostMapping("/users")
    public void createOrUpdateUser(@RequestBody UserPO user) {
        if (StringUtils.isContainEmpty(user.getUsername(), user.getPassword())) {
            throw new BadRequestException("Username and password can not be empty.");
        }

        if (userService instanceof SpringSecurityUserService) {
            ((SpringSecurityUserService) userService).createOrUpdate(user);
            //给用户添加创建APPLICATION权限
            HashSet<String> users = new HashSet<>();
            users.add(user.getUsername());
            System.out.println("当前登陆人信息：" + userInfoHolder.getUser().getUserId());
            rolePermissionService.assignRoleToUsers(SystemRoleManagerService.CREATE_APPLICATION_ROLE_NAME,
                    users, userInfoHolder.getUser().getUserId());
        } else {
            throw new UnsupportedOperationException("Create or update user operation is unsupported");
        }
    }
}
