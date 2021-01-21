package com.ctrip.framework.apollo.openapi.v1.controller;

import com.ctrip.framework.apollo.common.dto.ClusterDTO;
import com.ctrip.framework.apollo.common.entity.App;
import com.ctrip.framework.apollo.common.utils.BeanUtils;
import com.ctrip.framework.apollo.openapi.dto.OpenAppDTO;
import com.ctrip.framework.apollo.openapi.dto.OpenEnvClusterDTO;
import com.ctrip.framework.apollo.openapi.util.OpenApiBeanUtils;
import com.ctrip.framework.apollo.portal.component.PortalSettings;
import com.ctrip.framework.apollo.portal.component.config.PortalConfig;
import com.ctrip.framework.apollo.portal.entity.model.AppModel;
import com.ctrip.framework.apollo.portal.entity.vo.Organization;
import com.ctrip.framework.apollo.portal.environment.Env;
import com.ctrip.framework.apollo.portal.listener.AppCreationEvent;
import com.ctrip.framework.apollo.portal.service.AppService;
import com.ctrip.framework.apollo.portal.service.ClusterService;
import com.ctrip.framework.apollo.portal.service.RolePermissionService;
import com.ctrip.framework.apollo.portal.spi.UserInfoHolder;
import com.ctrip.framework.apollo.portal.util.RoleUtils;
import com.google.common.collect.Sets;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

@RestController("openapiAppController")
@RequestMapping("/openapi/v1")
public class AppController {

    private final UserInfoHolder userInfoHolder;
    private final RolePermissionService rolePermissionService;
    private final ApplicationEventPublisher publisher;
    private final PortalSettings portalSettings;
    private final ClusterService clusterService;
    private final AppService appService;
    private final PortalConfig portalConfig;

    public AppController(final UserInfoHolder userInfoHolder,
                         final RolePermissionService rolePermissionService,
                         final ApplicationEventPublisher publisher,
                         final PortalSettings portalSettings,
                         final ClusterService clusterService,
                         final AppService appService,
                         final PortalConfig portalConfig) {
        this.userInfoHolder = userInfoHolder;
        this.rolePermissionService = rolePermissionService;
        this.publisher = publisher;
        this.portalSettings = portalSettings;
        this.clusterService = clusterService;
        this.appService = appService;
        this.portalConfig = portalConfig;
    }

    @GetMapping(value = "/apps/{appId}/envclusters")
    public List<OpenEnvClusterDTO> loadEnvClusterInfo(@PathVariable String appId) {

        List<OpenEnvClusterDTO> envClusters = new LinkedList<>();

        List<Env> envs = portalSettings.getActiveEnvs();
        for (Env env : envs) {
            OpenEnvClusterDTO envCluster = new OpenEnvClusterDTO();

            envCluster.setEnv(env.name());
            List<ClusterDTO> clusterDTOs = clusterService.findClusters(env, appId);
            envCluster.setClusters(BeanUtils.toPropertySet("name", clusterDTOs));

            envClusters.add(envCluster);
        }

        return envClusters;

    }

    @GetMapping("/apps")
    public List<OpenAppDTO> findApps(@RequestParam(value = "appIds", required = false) String appIds) {
        final List<App> apps = new ArrayList<>();
        if (StringUtils.isEmpty(appIds)) {
            apps.addAll(appService.findAll());
        } else {
            apps.addAll(appService.findByAppIds(Sets.newHashSet(appIds.split(","))));
        }
        return OpenApiBeanUtils.transformFromApps(apps);
    }

    @PreAuthorize(value = "@permissionValidator.hasCreateApplicationPermission()")
    @PostMapping("/createApp")
    public App create(@Valid @RequestBody AppModel appModel) {

        App app = transformToApp(appModel);

        App createdApp = appService.createAppInLocal(app);

        publisher.publishEvent(new AppCreationEvent(createdApp));

        Set<String> admins = appModel.getAdmins();
        if (admins != null) {
            rolePermissionService
                    .assignRoleToUsers(RoleUtils.buildAppMasterRoleName(createdApp.getAppId()),
                            admins, userInfoHolder.getUser().getUserId());
        }

        return createdApp;
    }

    private App transformToApp(AppModel appModel) {
        String appId = appModel.getAppId();
        String appName = appModel.getName();
        String ownerName = appModel.getOwnerName();
        String orgId = appModel.getOrgId();
        String orgName = appModel.getOrgName();

        return App.builder()
                .appId(appId)
                .name(appName)
                .ownerName(ownerName)
                .orgId(orgId)
                .orgName(orgName)
                .build();

    }

    @GetMapping("/organizations")
    public List<Organization> loadOrganization() {
        return portalConfig.organizations();
    }

    @PostMapping("/addRoleMaster")
    public String addRoleMaster(@RequestBody AppModel appModel) {
        if (appModel.getAdmins() != null) {
            rolePermissionService
                    .assignRoleToUsers(RoleUtils.buildAppMasterRoleName(appModel.getAppId()),
                            appModel.getAdmins(), userInfoHolder.getUser().getUserId());
        }
        return appModel.getAppId();
    }
}
