package com.ctrip.framework.apollo.portal.repository;

import com.ctrip.framework.apollo.portal.entity.po.SysIdMachine;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * @author Jason Song(song_s@ctrip.com)
 */
public interface MachineRepository extends CrudRepository<SysIdMachine, Long> {

    @Modifying
    SysIdMachine save(SysIdMachine sysIdMachine);

    @Transactional
    @Modifying
    @Query("update SysIdMachine set heartLastTime=?3 where machineIp=?1 and appName=?2")
    void update(String machineIp, String appName, Date heartLastTime);


    SysIdMachine findByMachineIpAndAppName(String machineIp, String appName);

    @Query("select MAX(machineId)  from SysIdMachine where appName=?1")
    Integer findMaxMachineId(String appName);
}
