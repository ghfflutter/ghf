part of ghf;

extension StateExt on State {
  //获取当前页面的上下文
  dynamic api(String url){
    Navigator.of(context).pushNamed(url);
  }
  
}