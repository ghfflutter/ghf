



extension IntExt on int {
  //显示日期
  String showDate(){    
    return DateFormat("yyyy-MM-dd").format(DateTime.fromMillisecondsSinceEpoch(this));
  }
  //显示时间
  String showTime(){
    return DateFormat("HH:mm:ss").format(DateTime.fromMillisecondsSinceEpoch(this));
  }
  //显示日期时间
  String showDateTime(){
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.fromMillisecondsSinceEpoch(this));
  }
  String showTimeAgo(){
    DateTime now = DateTime.now();
    DateTime dd = DateTime.fromMillisecondsSinceEpoch(this);
    now.second - dd.second;
    if(now.year - dd.year > 0){
      return "${now.year - dd.year}年前";
    }else if(now.month - dd.month > 0){
      return "${now.month - dd.month}月前"; 
    }else if(now.day - dd.day > 0){
      return "${now.day - dd.day}天前"; 
    }else if(now.hour - dd.hour > 0){
      return "${now.hour - dd.hour}小时前"; 
    }else if(now.minute - dd.minute > 0){
      return "${now.minute - dd.minute}分钟前";
    }else{
      return  "${now.second - dd.second}秒前";
    }
  }
  //显示日期
  String showUnixDate(){    
    return DateFormat("yyyy-MM-dd").format(DateTime.fromMillisecondsSinceEpoch(this * 1000));
  }
  //显示时间
  String showUnixTime(){
    return DateFormat("HH:mm:ss").format(DateTime.fromMillisecondsSinceEpoch(this * 1000));
  }
  //显示日期时间
  String showUnixDateTime(){
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.fromMillisecondsSinceEpoch(this * 1000));
  }
  String showUnixTimeAgo(){
    DateTime now = DateTime.now();
    DateTime dd = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    now.second - dd.second;
    if(now.year - dd.year > 0){
      return "${now.year - dd.year}年前";
    }else if(now.month - dd.month > 0){
      return "${now.month - dd.month}月前"; 
    }else if(now.day - dd.day > 0){
      return "${now.day - dd.day}天前"; 
    }else if(now.hour - dd.hour > 0){
      return "${now.hour - dd.hour}小时前"; 
    }else if(now.minute - dd.minute > 0){
      return "${now.minute - dd.minute}分钟前";
    }else{
      return  "${now.second - dd.second}秒前";
    }
  }
}