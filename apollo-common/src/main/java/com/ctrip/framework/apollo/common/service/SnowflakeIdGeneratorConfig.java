package com.ctrip.framework.apollo.common.service;

import com.ctrip.framework.apollo.common.service.GenerateIdService;
import com.ctrip.framework.apollo.common.utils.SpringUtil;
import org.hibernate.HibernateException;
import org.hibernate.engine.spi.SharedSessionContractImplementor;
import org.hibernate.id.IdentifierGenerator;

import java.io.Serializable;

public class SnowflakeIdGeneratorConfig implements IdentifierGenerator {

    @Override
    public Serializable generate(SharedSessionContractImplementor session, Object object) throws HibernateException {
        /**
         * 获取容器中的 Bean
         */
        GenerateIdService generateIdService = SpringUtil.getBean(GenerateIdService.class);
        long id = generateIdService.getId();
        return id;
    }
}
