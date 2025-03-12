
//调试工具
import 'package:flutter/material.dart';

class Dev extends StatefulWidget {
  const Dev({ Key? key }) : super(key: key);

  @override
  _DevState createState() => _DevState();
}

class _DevState extends State<Dev> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
// //显示请求日志
// class DevLog extends StatefulWidget {
//   const DevLog({ Key? key }) : super(key: key);

//   @override
//   _DevLogState createState() => _DevLogState();
// }

// class _DevLogState extends State<DevLog> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      appBar: AppBar(
//        title: Text('请求日志'),
//        actions: [
//          IconButton(onPressed: () {
//            ApiLogs.clear();
//            setState(() {});
//          }, icon: Icon(Icons.delete))
//        ],
//      ),
//      body: ListView.builder(
//        itemCount: ApiLogs.length,
//        itemBuilder: (context, index) {
//          return ListTile(
//            title: Text(ApiLogs.logs[index].url),
//            subtitle: Text(ApiLogs.logs[index].time),
//            onTap: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => DevLogInfo(info: ApiLogs.logs[index])));
//            }
//          );
//        }
//      ) 
//     );
//   }
// }
// //显示请求日志详情
// class DevLogInfo extends StatefulWidget {
//   final ApiLogInfo info;
//   const DevLogInfo({ Key? key ,required ApiLogInfo this.info}) :super(key: key);

//   @override
//   _DevLogInfo createState() => _DevLogInfo();
// }

// class _DevLogInfo extends State<DevLogInfo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('请求日志'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Text('请求地址：${widget.info.url}'),
//             Text('请求方法：${widget.info.method}'),
//             Text('请求参数：${widget.info.params}'),
//             Text('请求时间：${widget.info.time}'),
//             Text('响应数据：${widget.info.response}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
