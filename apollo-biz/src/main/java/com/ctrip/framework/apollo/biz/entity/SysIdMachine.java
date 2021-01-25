package com.ctrip.framework.apollo.biz.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "SYS_ID_MACHINE")
public class SysIdMachine {

    /**
     * 主机IP
     */
    @Id
    @Column(name = "machine_ip")
    private String machineIp;

    /**
     * 主机IP对应的机器码
     */
    @Column(name = "machine_id")
    private Integer machineId;

    /**
     * 创建时间
     */
    @Column(name = "add_time")
    private Date addTime;

    /**
     * 最后一次心跳时间
     */
    @Column(name = "heart_last_time")
    private Date heartLastTime;
    /**
     * 服务名
     */
    @Column(name = "app_name")
    private String appName;

    public Date getHeartLastTime() {
        return heartLastTime;
    }

    public void setHeartLastTime(Date heartLastTime) {
        this.heartLastTime = heartLastTime;
    }

    public Integer getMachineId() {
        return machineId;
    }

    public void setMachineId(Integer machineId) {
        this.machineId = machineId;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public String getMachineIp() {
        return machineIp;
    }

    public void setMachineIp(String machineIp) {
        this.machineIp = machineIp;
    }

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }

}
