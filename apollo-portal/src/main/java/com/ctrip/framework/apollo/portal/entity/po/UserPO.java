package com.ctrip.framework.apollo.portal.entity.po;

import com.ctrip.framework.apollo.portal.entity.bo.UserInfo;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * @author lepdou 2017-04-08
 */
@Entity
@Table(name = "USERS")
public class UserPO {

    @Id
    @GeneratedValue(generator = "snowflakeIdGeneratorConfig")
    @GenericGenerator(
            name = "snowflakeIdGeneratorConfig",
            strategy = "com.ctrip.framework.apollo.common.service.SnowflakeIdGeneratorConfig"
    )
    @Column(name = "ID")
    private long id;
    @Column(name = "USERNAME", nullable = false)
    private String username;
    @Column(name = "PASSWORD", nullable = false)
    private String password;
    @Column(name = "EMAIL", nullable = false)
    private String email;
    @Column(name = "ENABLED", nullable = false)
    private int enabled;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getEnabled() {
        return enabled;
    }

    public void setEnabled(int enabled) {
        this.enabled = enabled;
    }

    public UserInfo toUserInfo() {
        UserInfo userInfo = new UserInfo();
        userInfo.setName(this.getUsername());
        userInfo.setUserId(this.getUsername());
        userInfo.setEmail(this.getEmail());
        return userInfo;
    }
}
