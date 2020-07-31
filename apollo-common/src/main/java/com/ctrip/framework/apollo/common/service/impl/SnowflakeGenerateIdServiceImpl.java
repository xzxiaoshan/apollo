package com.ctrip.framework.apollo.common.service.impl;

import com.ctrip.framework.apollo.common.service.SnowflakeIdWorker;
import com.ctrip.framework.apollo.common.service.GenerateIdService;

/**
 * 基于雪花算法的ID生成
 *
 * @author 单红宇
 */
public class SnowflakeGenerateIdServiceImpl implements GenerateIdService {

    private SnowflakeIdWorker idWorker = null;

    public SnowflakeGenerateIdServiceImpl(Long machineId) {
        super();
        this.idWorker = new SnowflakeIdWorker(machineId);
    }

    @Override
    public Long getId() {
        return idWorker.nextId();
    }

    public void refreshIdWorker(Long machineId) {
        this.idWorker = new SnowflakeIdWorker(machineId);
    }

}
