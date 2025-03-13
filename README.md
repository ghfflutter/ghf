# GHF 
## 1. 安装依赖

```bash
flutter pub get ghf
```

## 2. 引入依赖

```dart
import 'package:ghf/ghf.dart';
Ghf.run(Widget home,"接口地址",false)
```
## 3. 使用
### 程序入口

### 多语言

### 调试

### api请求

### 路由
#### widget
```dart
Ghf.push(Widget widget)
Ghf.pushNamed(String name)
Ghf.pushReplacement(Widget widget)
Ghf.pushReplacementNamed(String name)
Ghf.pop()
```
#### 其他使用方式
```dart
Ghf.push(MaterialPageRoute());
```
### 本地存储
```dart
//获取
Ghf.getStorage("key").then((value) {})
//设置
Ghf.setStorage("key", "value")
Ghf.getStorageBool("key")
Ghf.getStorageInt("key")

//删除
Ghf.removeStorage("key")
Ghf.clearStorage()  //清空所有
```


