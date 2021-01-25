package com.ctrip.framework.apollo.portal.scheduling;

import com.ctrip.framework.apollo.portal.service.DbMachineIdService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import java.util.concurrent.TimeUnit;

public class MachineIdHeartTask {

    private static final Logger logger = LoggerFactory.getLogger(MachineIdHeartTask.class);
    private DbMachineIdService dbMachineIdService;

    private Thread thread = null;
    private boolean running = true;

    public MachineIdHeartTask(DbMachineIdService dbMachineIdService) {
        this.dbMachineIdService = dbMachineIdService;
    }

    @PreDestroy
    public void destroy() {
        running = false;
        if (thread != null && thread.isAlive())
            thread.interrupt();
    }

    @PostConstruct
    public void init() {
        thread = new Thread(this::heartbeat);
        thread.start();
    }

    /**
     * 因依赖ID服务，不断检测注册中心，如果id服务存在，则进行一次API同步操作，如果同步完成，则结束
     */
    public void heartbeat() {
        while (running && !Thread.interrupted()) {
            dbMachineIdService.heartbeat();
            // 等候5秒
            try {
                TimeUnit.SECONDS.sleep(10);
            } catch (InterruptedException e) {
                logger.info("线程中断");
                Thread.currentThread().interrupt();
            }
        }
        logger.info("退出MachineId Heartbeat");
    }
}
