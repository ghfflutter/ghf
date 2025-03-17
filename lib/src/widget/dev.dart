//调试工具
import 'package:flutter/material.dart';
import 'package:ghf/src/widget/app_root_widget.dart';
import '../ext/state.dart';
import '../utils/api_logs.dart';
import '../core.dart';

class Dev extends StatefulWidget {
  const Dev({Key? key}) : super(key: key);

  @override
  _DevState createState() => _DevState();
}

class _DevState extends State<Dev> {
  @override
  Widget build(BuildContext context) {
    WidgetsApp.debugAllowBannerOverride = false;
    String host = GAppRootWidget.of(context).config.apiHost!;
    return Scaffold(
      appBar: AppBar(
        title: Text('调试工具'),
      ),
      body: SingleChildScrollView(
        child: Row(   
          children: [
            TextButton(
                onPressed: () {
                  push(DevLog());
                },
                child: Text("请求日志")),
            Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      labelText: "当前接口地址",
                      counterText: host,
                      hintText: "请输入地址",),
                  keyboardType: TextInputType.url,
                  onChanged: (value) {
                    host = value;
                  },
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        GAppRootWidget.of(context).config.apiHost = host;
                      });
                    },
                    child: Text("保存"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//显示请求日志
class DevLog extends StatefulWidget {
  const DevLog({Key? key}) : super(key: key);

  @override
  _DevLogState createState() => _DevLogState();
}

class _DevLogState extends State<DevLog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('请求日志'),
          actions: [
            IconButton(
                onPressed: () {
                  ApiLogs.clear();
                  setState(() {});
                },
                icon: Icon(Icons.delete))
          ],
        ),
        body: ListView.builder(
            itemCount: ApiLogs.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(ApiLogs.logs[index].url),
                  subtitle: Text(ApiLogs.logs[index].time),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DevLogInfo(info: ApiLogs.logs[index])));
                  });
            }));
  }
}

//显示请求日志详情
class DevLogInfo extends StatefulWidget {
  final ApiLogInfo info;
  const DevLogInfo({Key? key, required ApiLogInfo this.info}) : super(key: key);

  @override
  _DevLogInfo createState() => _DevLogInfo();
}

class _DevLogInfo extends State<DevLogInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('请求日志'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('请求地址：${widget.info.url}'),
            Text('请求方法：${widget.info.method}'),
            Text('请求参数：${widget.info.params}'),
            Text('请求时间：${widget.info.time}'),
            Text('响应数据：${widget.info.response}'),
          ],
        ),
      ),
    );
  }
}
