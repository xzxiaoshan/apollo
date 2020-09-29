package com.ctrip.framework.apollo.biz.scheduling;

import com.ctrip.framework.apollo.biz.service.DbMachineIdService;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@EnableScheduling
public class MachineIdHeartTask {

    private final DbMachineIdService dbMachineIdService;

    public MachineIdHeartTask(DbMachineIdService dbMachineIdService) {
        this.dbMachineIdService = dbMachineIdService;
    }

    /**
     * 心跳机制
     */
    @Scheduled(fixedRate = 10000)
    public void redisMachineIdDefendTask() {
        dbMachineIdService.heartbeat();
    }
}
