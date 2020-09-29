package com.ctrip.framework.apollo.biz.service;

public interface MachineIdService {
	/**
	 * 生成MachineId的方法
	 *
	 * @return machineId 机器码
	 */
	Long getMachineId();

	/**
	 * 心跳（持续交互执行相关动作）
	 */
	void heartbeat();
}
