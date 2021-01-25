package com.ctrip.framework.apollo.configservice;

import com.ctrip.framework.apollo.biz.ApolloBizConfig;
import com.ctrip.framework.apollo.biz.repository.MachineRepository;
import com.ctrip.framework.apollo.biz.scheduling.MachineIdHeartTask;
import com.ctrip.framework.apollo.biz.service.DbMachineIdService;
import com.ctrip.framework.apollo.biz.service.MachineIdService;
import com.ctrip.framework.apollo.common.ApolloCommonConfig;
import com.ctrip.framework.apollo.common.service.GenerateIdService;
import com.ctrip.framework.apollo.common.service.impl.SnowflakeGenerateIdServiceImpl;
import com.ctrip.framework.apollo.metaservice.ApolloMetaServiceConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.*;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * Spring boot application entry point
 *
 * @author Jason Song(song_s@ctrip.com)
 */

@EnableAspectJAutoProxy
@EnableAutoConfiguration // (exclude = EurekaClientConfigBean.class)
@Configuration
@EnableTransactionManagement
@PropertySource(value = {"classpath:configservice.properties"})
@ComponentScan(basePackageClasses = {
        ApolloCommonConfig.class,
        ApolloBizConfig.class,
        ConfigServiceApplication.class,
        ApolloMetaServiceConfig.class})
public class ConfigServiceApplication {

    public static void main(String[] args) throws Exception {
        SpringApplication.run(ConfigServiceApplication.class, args);
    }

    /**
     * 全局ID服务bean
     */
    @Autowired
    MachineRepository machineRepository;

    @Value("${spring.application.name}")
    private String appName;
    @Value("${server.port}")
    private int appPort;

    @Bean
    public GenerateIdService generateIdService() {
        MachineIdService machineIdService = new DbMachineIdService(machineRepository, this.appName, this.appPort);
        GenerateIdService generateIdService = new SnowflakeGenerateIdServiceImpl(machineIdService.getMachineId());
        return generateIdService;
    }

    @Bean
    public MachineIdHeartTask machineIdHeartTask() {
        DbMachineIdService machineIdService = new DbMachineIdService(machineRepository, this.appName, this.appPort);
        MachineIdHeartTask machineIdHeartTask = new MachineIdHeartTask(machineIdService);
        return machineIdHeartTask;
    }
}
