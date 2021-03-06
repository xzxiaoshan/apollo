package com.ctrip.framework.apollo.portal;

import com.ctrip.framework.apollo.common.ApolloCommonConfig;
import com.ctrip.framework.apollo.common.service.GenerateIdService;
import com.ctrip.framework.apollo.common.service.impl.SnowflakeGenerateIdServiceImpl;
import com.ctrip.framework.apollo.openapi.PortalOpenApiConfig;
import com.ctrip.framework.apollo.portal.repository.MachineRepository;
import com.ctrip.framework.apollo.portal.service.DbMachineIdService;
import com.ctrip.framework.apollo.portal.service.MachineIdService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@EnableAspectJAutoProxy
@Configuration
@EnableAutoConfiguration
@EnableTransactionManagement
@ComponentScan(basePackageClasses = {
        ApolloCommonConfig.class,
        PortalApplication.class,
        PortalOpenApiConfig.class})
public class PortalApplication {

    public static void main(String[] args) throws Exception {
        SpringApplication.run(PortalApplication.class, args);
    }


    @Autowired
    MachineRepository machineRepository;

    /**
     * 全局ID服务bean
     *
     * @return
     */
    @Bean
    public GenerateIdService generateIdService() {
        MachineIdService machineIdService = new DbMachineIdService(machineRepository);
        GenerateIdService generateIdService = new SnowflakeGenerateIdServiceImpl(machineIdService.getMachineId());
        return generateIdService;
    }
}
