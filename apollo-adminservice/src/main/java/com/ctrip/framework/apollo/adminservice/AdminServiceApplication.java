package com.ctrip.framework.apollo.adminservice;

import com.ctrip.framework.apollo.biz.ApolloBizConfig;
import com.ctrip.framework.apollo.biz.repository.MachineRepository;
import com.ctrip.framework.apollo.biz.service.DbMachineIdService;
import com.ctrip.framework.apollo.biz.service.MachineIdService;
import com.ctrip.framework.apollo.common.ApolloCommonConfig;
import com.ctrip.framework.apollo.common.service.GenerateIdService;
import com.ctrip.framework.apollo.common.service.impl.SnowflakeGenerateIdServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.context.annotation.*;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@EnableAspectJAutoProxy
@EnableEurekaClient
@Configuration
@PropertySource(value = {"classpath:adminservice.properties"})
@EnableAutoConfiguration
@EnableTransactionManagement
@ComponentScan(basePackageClasses = {
        ApolloCommonConfig.class,
        ApolloBizConfig.class,
        AdminServiceApplication.class})
public class AdminServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(AdminServiceApplication.class, args);
    }

    /**
     * 全局ID服务bean
     */
    @Autowired
    MachineRepository machineRepository;

    @Bean
    public GenerateIdService generateIdService() {
        MachineIdService machineIdService = new DbMachineIdService(machineRepository);
        GenerateIdService generateIdService = new SnowflakeGenerateIdServiceImpl(machineIdService.getMachineId());
        return generateIdService;
    }


}
