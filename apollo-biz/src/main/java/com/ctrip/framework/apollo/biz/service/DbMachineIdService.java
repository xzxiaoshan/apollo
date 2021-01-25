package com.ctrip.framework.apollo.biz.service;

import com.ctrip.framework.apollo.biz.entity.SysIdMachine;
import com.ctrip.framework.apollo.biz.repository.MachineRepository;
import com.ctrip.framework.apollo.common.utils.MachineUtils;
import com.ctrip.framework.apollo.tracer.Tracer;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Random;

/**
 * 基于DB的实现
 */
@Service
public class DbMachineIdService implements MachineIdService {

    private MachineRepository machineRepository;

    private String appName;
    private int appPort;

    public DbMachineIdService() {

    }

    public DbMachineIdService(MachineRepository machineRepository, String appName, int appPort) {
        super();
        this.appName = appName;
        this.appPort = appPort;
        this.machineRepository = machineRepository;
    }

    @Transactional
    @Override
    public Long getMachineId() {
        SysIdMachine sysIdMachine = machineRepository.findByMachineIpAndAppName(getMachineStr(), appName);
        Date nowDate = new Date();
        int machineId = -1;
        if (sysIdMachine != null) {
            machineRepository.updateByMachineIpAndAppName(getMachineStr(), this.appName, nowDate);
            machineId = sysIdMachine.getMachineId();
        } else {
            sysIdMachine = new SysIdMachine();
            sysIdMachine.setMachineIp(getMachineStr());
            sysIdMachine.setAddTime(nowDate);
            sysIdMachine.setHeartLastTime(nowDate);
            sysIdMachine.setAppName(this.appName);
            Random random = new Random();
            for (int i = 0; i < 100; i++) {
                try {
                    Integer value = machineRepository.findMaxMachineId(this.appName);
                    machineId = value == null ? 1 : value + 1;
                    sysIdMachine.setMachineId(machineId);
                    machineRepository.save(sysIdMachine);
                    break;
                } catch (DuplicateKeyException e) {
                    try {
                        Thread.sleep(random.nextInt(3000) + 1);
                    } catch (InterruptedException interruptedException) {
                        Tracer.logEvent("sleep error,cause：", interruptedException.getMessage());
                    }
                    Tracer.logEvent("logEvent", "retry >>>>>>>>>>>>>");
                } catch (Exception e) {
                    Tracer.logEvent("sleep error,cause：", e.getMessage());
                    System.exit(0);
                }
            }
        }
        return (long) machineId;
    }

    @Transactional
    @Override
    public void heartbeat() {
        this.getMachineId();
    }

    private String getMachineStr() {
        return MachineUtils.getMachineIpPort(appPort);
    }
}
