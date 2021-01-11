package com.ctrip.framework.apollo.portal.entity.po;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * @author panxs
 * @create 2021-01-11-13:08
 */
@Entity
@Table(name = "AUTHORITIES")
public class Authorities {

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

    @Column(name = "AUTHORITY", nullable = false)
    private String authority;

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

    public String getAuthority() {
        return authority;
    }

    public void setAuthority(String authority) {
        this.authority = authority;
    }

    public Authorities() {
    }

    public Authorities(String username, String authority) {
        this.username = username;
        this.authority = authority;
    }


}
