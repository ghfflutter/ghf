import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../extension/BuildContext.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

app(Widget chile, {Map<String, dynamic>? config}) {
  runApp(App(
    app: chile,
    config: config,
  ));
}

class App extends StatefulWidget {
  Widget app;
  Map<String, dynamic>? config;
  App({required this.app, this.config, Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  bool isLoad = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (!isLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoad = true;
        //lang_map //加载语言包
        if (widget.config!.containsKey("lang_dir") &&
            widget.config!.containsKey("langs")) {
          widget.config!['langs'].foreach((item) {
            rootBundle
                .loadString(widget.config!['lang_dir'] + "/" + item + ".json")
                .then((ss) {
              final dd = json.decode(ss);
              Map lang_map = context.getVal("lang_map", {});
              lang_map[item] = dd;
              context.setValue("lang_map", lang_map);
            });
          });
        }
        //保存配置信息
        if (widget.config != null) {
          widget.config!.forEach((key, value) {
            context.setValue(key, value);
          });
        }
        switch (Theme.of(context).platform) {
          case TargetPlatform.android:
            DeviceInfoPlugin().androidInfo.then((v) {
              context.setValue("device", {
                'device_plaform': 'addroid',
                'device_board': v.board,
                'device_bootloader': v.bootloader,
                'device_brand': v.brand,
                'device_device': v.device,
                'device_display': v.display,
                'device_hardware': v.hardware,
                'device_host': v.host,
                'device_manufacturer': v.manufacturer,
                'device_id': v.id,
                'device_serialNumber': v.serialNumber,
                'device_model': v.model,
                'device_name': v.name,
                'device_product': v.product,
                "device_version": {
                  'baseos': v.version.baseOS,
                  'codename': v.version.codename,
                  'incremental': v.version.incremental,
                  'previewSdkInt': v.version.previewSdkInt,
                  'release': v.version.release,
                  'sdkInt': v.version.sdkInt,
                  'securityPatch': v.version.securityPatch,
                }
              });
            });
            break;
          case TargetPlatform.fuchsia:
            DeviceInfoPlugin().deviceInfo.then((v) {
              context.setValue("device", {
                'device_plaform': 'fuchsia',
              });
            });
            break;
          case TargetPlatform.iOS:
            DeviceInfoPlugin().iosInfo.then((v) {
              context.setValue("device", {
                'device_plaform': 'ios',
                'device_identifierForVendor': v.identifierForVendor,
                'device_isPhysicalDevice': v.isPhysicalDevice,
                'device_isiOSAppOnMac': v.isiOSAppOnMac,
                'device_localizedModel': v.localizedModel,
                'device_model': v.model,
                'device_modelName': v.modelName,
                'device_name': v.name,
                'device_systemName': v.systemName,
                'device_systemVersion': v.systemVersion,
                'device_utsname': v.utsname,
              });
            });
            break;
          case TargetPlatform.linux:
            DeviceInfoPlugin().linuxInfo.then((v) {
              context.setValue("device", {
                'device_plaform': 'linux',
                'device_buildId': v.buildId,
                'device_id': v.id,
                'device_machineId': v.machineId,
                'device_name': v.name,
                'device_prettyName': v.prettyName,
                'device_variant': v.variant,
                'device_variantId': v.variantId,
                'device_version': v.version,
                'device_versionCodename': v.versionCodename,
                'device_versionId': v.versionId,
              });
            });
            break;
          case TargetPlatform.macOS:
            DeviceInfoPlugin().macOsInfo.then((v) {
              context.setValue("device", {
                'device_plaform': 'macos',
                'device_activeCPUs': v.activeCPUs,
                'device_arch': v.arch,
                'device_computerName': v.computerName,
                'device_cpuFrequency': v.cpuFrequency,
                'device_hostName': v.hostName,
                'device_kernelVersion': v.kernelVersion,
                'device_majorVersion': v.majorVersion,
                'device_memorySize': v.memorySize,
                'device_minorVersion': v.minorVersion,
                'device_model': v.model,
                'device_modelName': v.modelName,
                'device_osRelease': v.osRelease,
                'device_patchVersion': v.patchVersion,
                'device_systemGUID': v.systemGUID,
                'device_': v,
              });
            });
            break;
          case TargetPlatform.windows:
            DeviceInfoPlugin().windowsInfo.then((v) {
              context.setValue("device", {
                'device_plaform': 'window',
                'device_buildLab': v.buildLab,
                'device_buildLabEx': v.buildLabEx,
                'device_buildNumber': v.buildNumber,
                'device_computerName': v.computerName,
                'device_csdVersion': v.csdVersion,
                'device_deviceId': v.deviceId,
                'device_displayVersion': v.displayVersion,
                'device_editionId': v.editionId,
                'device_installDate': v.installDate,
                'device_majorVersion': v.majorVersion,
                'device_minorVersion': v.minorVersion,
                'device_numberOfCores': v.numberOfCores,
                'device_platformId': v.platformId,
                'device_productId': v.productId,
                'device_productName': v.productName,
                'device_productType': v.productType,
                'device_registeredOwner': v.registeredOwner,
                'device_releaseId': v.releaseId,
                'device_reserved': v.reserved,
                'device_userName': v.userName,
                'device_servicePackMajor': v.servicePackMajor,
                'device_servicePackMinor': v.servicePackMinor,
                'device_suitMask': v.suitMask,
                'device_systemMemoryInMegabytes': v.systemMemoryInMegabytes,
              });
            });
            break;
        }

        PackageInfo.fromPlatform().then((v) {
          context.setValue("packageinfo", {
            "app_name": v.appName,
            "app_num": v.buildNumber,
            "app_signature": v.buildSignature,
            "app.install_at": v.installTime,
            "app_store": v.installerStore,
            "app_uptime": v.updateTime,
            "app_ver": v.version
          });
        });
      });
      SharedPreferences.getInstance().then((v) {
        context.setValue("sp", v);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: widget.app,
    );
  }
}
