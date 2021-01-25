package com.ctrip.framework.apollo.biz.repository;

import com.ctrip.framework.apollo.biz.entity.SysIdMachine;
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

    @Transactional
    @Modifying
    @Query("update SysIdMachine set heartLastTime= :heartLastTime where machineIp = :machineIp and appName = :appName")
    void updateByMachineIpAndAppName(@Param("machineIp") String machineIp, @Param("appName") String appName, @Param("heartLastTime") Date heartLastTime);

    SysIdMachine findByMachineIpAndAppName(@Param("machineIp") String machineIp, @Param("appName") String appName);

    @Query("select MAX(machineId)  from SysIdMachine where appName= :appName")
    Integer findMaxMachineId(@Param("appName") String appName);
}
