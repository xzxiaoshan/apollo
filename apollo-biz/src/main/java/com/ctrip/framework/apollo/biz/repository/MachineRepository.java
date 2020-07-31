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

    @Modifying
    SysIdMachine save(SysIdMachine sysIdMachine);

    @Transactional
    @Modifying
    @Query("update SysIdMachine set heartLastTime=?2 where machineIp = ?1")
    void update(String machineIp, Date heartLastTime);

    SysIdMachine findByMachineIp(@Param(value = "machineIp") String machineIp);

    @Query("select MAX(machineId)  from SysIdMachine")
    Integer findMaxMachineId();
}
