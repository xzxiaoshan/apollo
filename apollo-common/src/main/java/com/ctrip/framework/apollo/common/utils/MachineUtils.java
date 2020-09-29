package com.ctrip.framework.apollo.common.utils;

import com.ctrip.framework.apollo.core.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 机器工具类
 *
 * @author 单红宇
 */
public class MachineUtils {

    private static final Logger logger = LoggerFactory.getLogger(MachineUtils.class);

    private static String machineIp = null;

    public static String getIP() {
        if (StringUtils.isBlank(machineIp)) {
            String ipv4 = IpUtils.getInet4Address();
            logger.info("ipv4={}", ipv4);
            machineIp = ipv4;
        }
        if (StringUtils.isBlank(machineIp)) {
            String ipv6 = IpUtils.getInet6Address();
            logger.info("ipv6={}", ipv6);
            machineIp = ipv6;
        }
        return machineIp;
    }

}
